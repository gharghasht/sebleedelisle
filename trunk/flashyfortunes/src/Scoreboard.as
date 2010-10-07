package
{
	
	import fl.text.TLFTextField;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	
	import mx.controls.Text;
	
	public class Scoreboard extends Sprite
	{
		
		public static var instance : Scoreboard;
		
		public var scoreboardClip : Sprite; 
		
		public var lines : Vector.<String> = new Vector.<String>(); 
		public var screenText : TLFTextField; 
		
		//public var round : RoundData; 
			
		
		public var leftXs : MovieClip; 
		public var rightXs : MovieClip; 
		
		public var leftBuzzerLight : MovieClip;
		public var rightBuzzerLight : MovieClip;
		
		public var logo : MovieClip; 
		
		public var gameModel : GameModel;
		
		public var scoreTFs : Vector.<TextField>; 
		
		public function Scoreboard(gameModel :GameModel)
		{
			instance = this;
			
			super();
			
			this.gameModel = gameModel; 
			
			scoreboardClip = new ScoreBoardGFX();
			addChild(scoreboardClip); 
			screenText = scoreboardClip["text_tlf"] as TLFTextField;
			//screenText.defaultTextFormat = screenText.getTextFormat(); 
			//trace(text, typeof text); 
			
			leftBuzzerLight = scoreboardClip["familyLight1"];
			rightBuzzerLight = scoreboardClip["familyLight2"];

			leftBuzzerLight.gotoAndStop(1);
			rightBuzzerLight.gotoAndStop(1);
			
			scoreTFs = new Vector.<TextField>; 
			scoreTFs.push(scoreboardClip["score1_tf"]);
			scoreTFs.push(scoreboardClip["score2_tf"]); 
			
			leftXs = scoreboardClip["left_xs"]; 
			rightXs = scoreboardClip["right_xs"];
			
			
			logo = scoreboardClip["logo_mc"];
			logo.visible = false; 
			
			clearBoard(); 
			
			updateState(); 
			updateDisplay(); 
			
			
			
		}
		
		public function toggleLogo(e : MouseEvent) : void
		{
			logo.visible = !logo.visible; 
			
		}
			
		public function updateDisplay() : void
		{
			var round : RoundData = currentRound;
			
			lines[0] = "          "+(round.items.length)+" ANSWERS";
			var line : String;
			
			var index : int = 2; 
			for(var i : int = 0; i< 8; i++) 
			{
				if(i<round.items.length)
				{
					line = "    "+(i+1)+"."; 
					
					var item : ItemData = round.items[i]; 
					
					if(item.revealed)
					{
						line+=item.answerText; 
						while(line.length<24) line+=" "; 
						line+=String(item.num);
					}
				}
				else
				{
					line = ""; 
				}
				line = line.toUpperCase();
				lines[i+index] = line;
				
			}
			
			
			
			lines[9] = "            TOTAL : "+currentRound.total ; 
			
			
			scoreTFs[0].text = gameModel.scores[0].toString(); 
			scoreTFs[1].text = gameModel.scores[1].toString(); 
			
			updateBoardContent(); 
			
		}
	
		public function clearBoard() : void
		{
			
			lines = new Vector.<String>(); 
			
			for (var i : int = 0; i<9; i++)
			{
				var line : String = ""; 
				lines.push(line);
				
			}
			updateBoardContent(); 
			
		}
	
		public function updateBoardContent() : void
		{
			screenText.text = "";
			for each (var line : String in lines)
			{
				
				
				screenText.appendText(line+"\n");
				
			}
			leftXs.visible = false; 
			leftXs.stop(); 
			rightXs.visible = false; 
			rightXs.stop(); 
			
			if(currentRound)
			{
				if(currentRound.wrongCount(GameModel.LEFT_TEAM)>0)
				{
					leftXs.gotoAndStop(currentRound.wrongCount(GameModel.LEFT_TEAM)); 
					leftXs.visible = true; 
				}
				
				
				if(currentRound.wrongCount(GameModel.RIGHT_TEAM)>0)
				{
					rightXs.gotoAndStop(currentRound.wrongCount(GameModel.RIGHT_TEAM)); 
					rightXs.visible = true; 
					
				}
			}
				
		}
		
		public function familyLight(teamLight : int, state :Boolean, flash : Boolean = true) : void
		{
			//ewwwwwwwww!
			trace(teamLight,leftBuzzerLight);
			if(teamLight==0)
			{
				leftBuzzerLight.gotoAndStop(state?flash?3:2:1);
					
			}
			else if(teamLight==1)
				rightBuzzerLight.gotoAndStop(state?flash?3:2:1);
			
		}
		
		
		public function toggleFullScreen(e : MouseEvent = null) : void
		{
			if(stage)
			{
				if(stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)
				{
					stage.displayState = StageDisplayState.NORMAL;
					scaleX = scaleY =1; 
					//x = y =0; 
				} else
				{
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					//x = (stage.stageWidth-width)/2;
					//y = (stage.stageHeight-height)/2;
					scaleX = stage.stageWidth/1024; 
					scaleY = stage.stageHeight/ 768; 
				}
				
					
			}
			
		}
		public function get currentRound(): RoundData
		{
			return gameModel.currentRound; 
		}
	/*	override public function commitProperties() : void
		{
			super.commitProperties();
			setStyle("backgroundColor", 0x000000); 
		}*/
		
		public static function updateState() : void
		{
			if(instance)
			{
				//var tf : TextField = instance.scoreboardClip.state_tf;
				//tf.text = instance.gameModel.state;
				//if(instance.gameModel.currentTeam)
				//{
					instance.familyLight(0, instance.gameModel.currentTeam==0, false);
					instance.familyLight(1, instance.gameModel.currentTeam==1, false);
				//}
			}
		}
		
	
	}
}