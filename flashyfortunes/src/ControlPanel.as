package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	public class ControlPanel extends Sprite
	{
		
		public static var instance : ControlPanel; 
		
		public var clip : MovieClip; 
		public var gameModel : GameModel; 
		
		public var labels : Vector.<TextField>; 
		public var buttons : Vector.<MovieClip>; 
		public var wiiLights : Vector.<MovieClip>;
		
		public var lockoutButton : MovieClip; 
		public var connectionLight : MovieClip; 
		
		public var teamA : MovieClip ; 
		public var teamB : MovieClip ; 
		public var stateClip : MovieClip ;
		
		public var themeSound : ThemeSND; 
		public var themeChannel : SoundChannel; 
		
		public var questionText : TextField; 
		
		public var musicPlaying : Boolean = false; 
		
		public function ControlPanel(gameModel : GameModel)
		{
			instance = this;
			
			super();
			
			this.gameModel = gameModel; 
			
			clip = new ControlPanelGFX(); 
			addChild(clip); 
			
			labels = new Vector.<TextField>;
			var i : int = 0; 
			while(clip["label_tf"+i])
			{
				labels.push(clip["label_tf"+i] as TextField);
				i++;
			}
			
			
			buttons = new Vector.<MovieClip>(); 
			i=0; 
			while(clip["button"+i])
			{
				buttons.push(clip["button"+i] as MovieClip); 
				i++; 
			}
			
			wiiLights = new Vector.<MovieClip>(); 
			i=1; 
			while(clip["wii"+i])
			{
				var light : MovieClip = clip["wii"+i] as MovieClip;
				wiiLights.push(light);
				light.gotoAndStop(1);
				i++; 
			}
			
			
			linkButton("lockoutToggle_mc", lockoutToggle);
			linkButton("reset_mc", resetButton);
			
			linkButton("connect_mc", connect); 
				
			linkButton("fullscreen_mc", Scoreboard.instance.toggleFullScreen); 
			linkButton("logo_mc", Scoreboard.instance.toggleLogo); 
			linkButton("music_mc", toggleMusic); 
			
			linkButton("teama_mc", switchTeams); 
			linkButton("teamb_mc", switchTeams); 
			teamA = clip["teama_mc"]; 
			teamB = clip["teamb_mc"]; 
			stateClip = clip["state_mc"]; 
			
			questionText = clip["label_question_tf"];
				
			connectionLight = clip["connectionLight_mc"]; 
			showConnectLight(false); 
			
			themeSound = new ThemeSND(); 
			
		}
		
		public function linkButton(label : String, callback : Function) : void
		{
			var button : MovieClip = clip[label]; 
			trace(label, button); 
			if(!button) 
			{
			
				trace("can't link button",label);
				return; 
					
			}
			
			//button.mouseChildren = true; 
			//if(TextField(button["label_tf"]).text = "hello"; 
			
			button.buttonMode = true; 
			button.gotoAndStop(1); 
			button.addEventListener(MouseEvent.CLICK, callback); 
			
			
			
		}
		
		public function updateDisplay() : void
		{
			var items : Vector.<ItemData> = gameModel.currentRound.items; 
			
			
			
			for (var i : int = 0; i<6; i++)
			{
				if(i<items.length)
				{
					labels[i].text = items[i].answerTextLong; 
					buttons[i].visible =true; 
				}
				else 
				{
					labels[i].text ="";
					buttons[i].visible = false; 
				}
				
			}
			
		}
		
		public function resetRound(e : MouseEvent) : void
		{
			gameModel.resetRound(); 
			
		}
		public function lockoutToggle(e:  MouseEvent) : void
		{
			gameModel.lockoutToggle(); 
			clip["lockoutToggle_mc"].alpha = (gameModel.state==GameModel.STATE_BUZZER_LOCKOUT)?0.5:1; 
			trace(gameModel.state==	GameModel.STATE_BUZZER_LOCKOUT,clip["lockoutToggle_mc"]);
			updateState();
		}
		
		public function switchTeams(e : MouseEvent) : void
		{
			gameModel.switchTeams(); 
			
			
		}
		
		public function connect(e : MouseEvent) : void
		{
			gameModel.connect(); 
			
		}
		
		public function toggleMusic(e : MouseEvent) : void
		{
			if(themeChannel)
			{
				themeChannel.stop(); 
			}
			
			if(!musicPlaying)
			{	
				themeChannel = themeSound.play(); 
				Scoreboard.instance.logo.visible=true; 
			}
			else 
			{
				themeChannel = null ; 
			}
			musicPlaying = !musicPlaying; 
			
		}
		public function resetButton(e : MouseEvent) : void
		{
			var button : MovieClip = clip["reset_mc"]; 
			if(button.alpha == 1) 
				button.alpha = 0.5; 
			else
			{
				button.alpha = 1; 
				gameModel.resetRound(); 
			}
		
		}
		public function wiiLight(num : int, on : Boolean = true) : void
		{
			wiiLights[num].gotoAndStop(on?2:1);		
		}
		
		public function getTeamForIndex(index : int) : int
		{
			return index;
		}
		
		public function showConnectLight(on : Boolean = true) : void
		{
			connectionLight.gotoAndStop(on ? "on" : "off") ;
			
			
		}
		
		
		public static function updateState() : void
		{
			if(instance)
			{
				//var tf : TextField = instance.clip.state_tf;
				//tf.text = GameModel.stateNames[instance.gameModel.state];
				
				instance.stateClip.gotoAndStop(instance.gameModel.state+1); 
				var team : int = instance.gameModel.currentTeam;
				
				instance.teamA.gotoAndStop(1); 
				instance.teamB.gotoAndStop(1); 
				
				if(team ==0) instance.teamA.gotoAndStop(2);
				else if(team ==1) instance.teamB.gotoAndStop(2); 
				
				if(instance.gameModel.state==GameModel.STATE_PRE_PLAY) 
					instance.questionText.text = "Press Lock-out Button";
				else	
					instance.questionText.text = instance.gameModel.currentRound.question;
				
				
			}
		}
	
	}
}