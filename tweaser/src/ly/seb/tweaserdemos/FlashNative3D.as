package ly.seb.tweaserdemos
{
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import ly.seb.tweaser.DisplayObjectTweaser;
	import ly.seb.tweaser.DisplayObjectTweaser3D;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	

	
	public class FlashNative3D extends Sprite
	{
		public var clips : Array = []; 
		public var tweasers : Array = []; 
		
		public function FlashNative3D()
		{
			
			for(var i : int = 0; i< 64; i++) 
			{
				var clip : MovieClip = new MovieClip(); 
				
				with (clip.graphics)
				{
					lineStyle(0,0x000000); 
					beginFill(0xff0000); 
					drawRect(-30,-20,60,40); 
					endFill(); 
					
				}
				
				addChild(clip); 
				clip.x = 60+ (i%8 *66); 
				clip.y = 60 + (Math.floor(i/8) * 46); 
				clip.z = 1000; 
				clip.rotationY = Math.random()*40 - 20; 
				clip.rotationX = Math.random()*40 - 20; 
				clip.startX = clip.x; 
				clip.startY = clip.y; 
				
				var tweaser : DisplayObjectTweaser3D = new DisplayObjectTweaser3D(clip, 0.3,0.5,Math.random()*10); 
				tweaser.z = 0; 
				tweaser.rotationX = 0; 
				tweaser.rotationY = 0; 
				
				
				tweasers.push(tweaser); 
				clips.push(clip); 
				clip.tweaser = tweaser; 
				
				clip.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown); 
				
			}
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown); 
			addEventListener(Event.ENTER_FRAME, enterFrame) ; 
		}
		
		public function enterFrame(e : Event) : void
		{
			clips.sortOn("z", Array.DESCENDING | Array.NUMERIC); 
			
			for (var i : int = 0; i< clips.length; i++)
			{
				var clip : MovieClip = clips[i]; 
				var tweaser : DisplayObjectTweaser3D = clip.tweaser; 
			
				if(tweaser.rotationY!=0) continue; 
				
				var diff : Point = new Point(mouseX - clip.x, mouseY - clip.y); 
				var distance : Number  = diff.length *2;
				tweaser.z = (distance > 200) ? 200 : distance; 
				
				if(getChildIndex(clip)!=i) setChildIndex(clip, i); 
			}
			
			
		}
		
		public function handleMouseDown(e : MouseEvent) : void
		{
			var clip : MovieClip = e.target as MovieClip; 
			var tweaser : DisplayObjectTweaser3D = clip.tweaser as DisplayObjectTweaser3D; 
			if(tweaser.rotationY!=0) 
			{
				tweaser.rotationY = 0; 
				tweaser.z = 0; 
				tweaser.x = clip.startX; 
				tweaser.y = clip.startY; 
				tweaser.scaleX = tweaser.scaleY = 1; 
			
			}
			else
			{
				tweaser.rotationY = 180; 
				tweaser.z = -200; 
				tweaser.x = 320; 
				tweaser.y = 240; 
				tweaser.scaleX = tweaser.scaleY = 3; 
			}
		
		}
		
		public function mouseDown(e : MouseEvent ) : void
		{
			
		}
	}
}