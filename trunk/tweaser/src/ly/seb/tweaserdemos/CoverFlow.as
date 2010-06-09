package ly.seb.tweaserdemos
{
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import ly.seb.tweaser.DisplayObjectTweaser;
	import ly.seb.tweaser.DisplayObjectTweaser3D;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	

	
	public class FlashNative3D extends Sprite
	{
		public var clips : Array = []; 
		public var tweasers : Array = []; 
		public var numClips : int = 20; 
		
		public function FlashNative3D()
		{
			
			x = 320; 
			
			
			for(var i : int = 0; i< numClips; i++) 
			{
				var clip : MovieClip = new MovieClip(); 
				
				with (clip.graphics)
				{
					beginFill(0xff0000); 
					drawRect(-50,-50,100,100); 
					endFill(); 
					var m : Matrix = new Matrix(); 
					m.createGradientBox(100,100,Math.PI/2,-50, 50); 
					beginGradientFill(GradientType.LINEAR, [0x660000,0x000000], [0xff,0xff],[0,255],m);
					drawRect(-50,50,100,100); 
					endFill();
				}
				
				addChild(clip); 
				clip.x = i *120; 
				clip.y = 250; 
				
				var tweaser : DisplayObjectTweaser3D = new DisplayObjectTweaser3D(clip); 
				tweasers.push(tweaser); 
				clips.push(clip); 
				
			}
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown); 
			addEventListener(Event.ENTER_FRAME, enterFrame) ; 
		}
		
		public function enterFrame(e : Event) : void
		{
			for (var i : int = 0; i< numClips; i++)
			{
				var tweaser : DisplayObjectTweaser3D = tweasers[i]; 
				var posnum : Number = (i-(numClips/2) - (mouseX/50));
				tweaser.x = (posnum*posnum*posnum )*10 ; 
				
				
				tweaser.rotationY = Math.max(-55, Math.min((tweaser.x )*0.5, 55));
					
				//tweaser.rotationY = i*120-mouseX;
				if(i==1) trace(tweaser.rotationY); 
			}
			
			
		}
		
		
		public function mouseDown(e : MouseEvent ) : void
		{
			
		}
	}
}