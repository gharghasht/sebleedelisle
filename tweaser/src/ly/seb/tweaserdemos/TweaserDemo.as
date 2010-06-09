package ly.seb.tweaserdemos
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ly.seb.tweaser.DisplayObjectTweaser;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
	
	public class TweaserDemo extends Sprite
	{
		
		public var myClip1 : MovieClip; 
		public var myClip2 : MovieClip; 
		public var movieTweaser1 : DisplayObjectTweaser; 
		public var movieTweaser2 : DisplayObjectTweaser; 
		
		public function TweaserDemo()
		{
			myClip1 = new MovieClip(); 
			myClip2 = new MovieClip(); 
			addChild(myClip1); 
			addChild(myClip2); 
			
			
			with (myClip1.graphics) 
			{
				beginFill(0xff0000); 
				drawRect(-50,-50,100,100); 
			}
			with (myClip2.graphics) 
			{
				beginFill(0x00ff00); 
				drawRect(-50,-50,100,100); 
			}
			
			movieTweaser1 = new DisplayObjectTweaser(myClip1); 
			movieTweaser2 = new DisplayObjectTweaser(myClip2); 
			
			movieTweaser1.x = 500;
			movieTweaser1.rotation = 50; 	
			movieTweaser1.y = 400; 
			
			movieTweaser2.x = 200;
			movieTweaser2.rotation = 350; 	
			movieTweaser2.y = 200; 
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown); 
			addEventListener(Event.ENTER_FRAME, enterFrame) ; 
		}
		
		public function enterFrame(e : Event) : void
		{
			movieTweaser1.x = 640 - mouseX; 
			movieTweaser1.y = mouseY; 
			movieTweaser1.rotation = mouseX*0.5 + mouseY *0.5; 
		}
		
		
		public function mouseDown(e : MouseEvent ) : void
		{
			movieTweaser2.x = mouseX; 
			movieTweaser2.y = mouseY; 
			movieTweaser2.rotation = mouseX*0.5 + mouseY *0.5; 
			movieTweaser2.scaleX = movieTweaser2.scaleY = Math.random(); 
		}
	}
}