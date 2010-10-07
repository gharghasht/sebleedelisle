package
{
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.media.Sound;

	public class FlashyFortunes extends Sprite
	{
		
		
		public var scoreboardWindow : NativeWindow; 
		public var scoreboard : Scoreboard; 
		public var controlPanel : ControlPanel; 
		
		public var controlWindow : NativeWindow; 
		public var display : Sprite; 
		
		//public var currentAnswer : int = 0; 
		
		public var gameModel : GameModel; 
		
		public var lockoutWinner : int = -1; 
		
		
		
		/*public var rounds : Array; 
		public var roundIndex : int = 0;
		public var currentRound : RoundData; */

		public function FlashyFortunes()
		{
			super();
			var windowOptions : NativeWindowInitOptions = new NativeWindowInitOptions(); 
			
			//windowOptions.maximizable = false;
			//windowOptions.resizable = false;
			//windowOptions.systemChrome = NativeWindowSystemChrome.ALTERNATE;
			scoreboardWindow = new NativeWindow(windowOptions);
			scoreboardWindow.activate();
			scoreboardWindow.title = "Scoreboard !";
			scoreboardWindow.width = 1024; 
			scoreboardWindow.height = 788; 
			scoreboardWindow.x = 1920;
			scoreboardWindow.y =0;
			
			
			gameModel = new GameModel(); 
			
			scoreboard = new Scoreboard(gameModel) ;
			scoreboardWindow.stage.addChild(scoreboard); 
			scoreboardWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			scoreboardWindow.stage.align = StageAlign.TOP_LEFT;
			
			scoreboard.toggleFullScreen();
			//outputWindow.
			
			stage.nativeWindow.visible = true; 
			
			display = new Sprite();
			
			stage.nativeWindow.stage.addChild(display); 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.nativeWindow.x = stage.nativeWindow.y =0; 
			setSize(800,600); 
			
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown); 
			
			controlPanel = new ControlPanel(gameModel); 
			addChild(controlPanel); 
			
			
			controlPanel.linkButton("button0", buttonClicked);
			controlPanel.linkButton("button1", buttonClicked);
			controlPanel.linkButton("button2", buttonClicked);
			controlPanel.linkButton("button3", buttonClicked);
			controlPanel.linkButton("button4", buttonClicked);
			controlPanel.linkButton("button5", buttonClicked);
			controlPanel.linkButton("button_x", buttonXClicked); 
			
			controlPanel.linkButton("next_mc", nextButtonClicked);
			controlPanel.linkButton("prev_mc", prevButtonClicked); 
			
			gameModel.connect(); 
			
			controlPanel.updateDisplay(); 	
		}
		
		public function buttonXClicked(e : MouseEvent) : void
		{
			trace("X"); 	
		
			
			wrong(); 
			// now check to see how many wrongs we have!
			
		}
		
		
		public function buttonClicked(e : MouseEvent) : void
		{
			
			var name : String = e.currentTarget.name; 
			var index : int = Number(name.substring(name.length-1, name.length)); 
			revealAnswer(index); 
			
			
		}
		
		public function revealAnswer(answerNumber : int ) : void
		{
			if(gameModel.revealAnswer(answerNumber))
			{
				scoreboard.updateDisplay(); 
				
			}
			
		}
		public function wrong() : void
		{
			gameModel.wrong(); 
			
		}
		
		public function nextButtonClicked(e : MouseEvent) : void
		{
			if(gameModel.nextRound())
			{
				controlPanel.updateDisplay(); 
				scoreboard.updateDisplay(); 
				
			}
		}
		public function prevButtonClicked(e : MouseEvent) : void
		{
			if(gameModel.prevRound())
			{
				controlPanel.updateDisplay(); 
				scoreboard.updateDisplay(); 
				
			}
		}

		public function setSize(w : int, h : int) : void
		{
			stage.nativeWindow.width = w; 
			stage.nativeWindow.height = h; 
			
			with(display.graphics)
			{
				clear(); 
				lineStyle(2,0x000000); 
				drawRect(0,0,w,h); 
			}
		}
		
		
		
	}
	
}