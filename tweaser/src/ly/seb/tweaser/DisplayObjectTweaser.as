package ly.seb.tweaser
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import ly.seb.tweaser.core.ITweasable;
	import ly.seb.tweaser.core.TweaserGroup;

	public class DisplayObjectTweaser extends TweaserGroup
	{
		
		public var clip : DisplayObject; 
		
		public function DisplayObjectTweaser(clip : DisplayObject, speed : Number = 0.2, spring : Number = 0, delay : int = 0)
		{
			this.clip = clip; 
			addNumberTweaser("x", clip.x, speed, spring, delay); 
			addNumberTweaser("y", clip.y, speed, spring, delay); 
			addNumberTweaser("rotation", clip.rotation, speed, spring, delay); 
			addNumberTweaser("scaleX", clip.scaleX, speed, spring, delay);
			addNumberTweaser("scaleY", clip.scaleY, speed, spring, delay);
			
			clip.addEventListener(Event.ENTER_FRAME, enterFrame); 
			
		}

		public function enterFrame(e : Event) : void
		{
			var changed : Boolean = update();
			
			clip.alpha = changed ? 1 : 0.7; 
		}
		
		override public function destroy() : void
		{
			super.destroy(); 
		}
	
		public function set rotation(n : Number) :  void
		{
			tweasers["rotation"].target = n; 
		}
		public function set x(n : Number) : void
		{
			tweasers["x"].target = n; 
		}
		public function set y(n : Number) : void
		{
			tweasers["y"].target = n; 
		}
		public function set scaleX(n : Number) : void
		{
			tweasers["scaleX"].target = n; 
		}
		public function set scaleY(n : Number) : void
		{
			tweasers["scaleY"].target = n; 
		}
		
		public function get rotation() : Number
		{
			return tweasers["rotation"].target; 
		}
		public function get x() : Number
		{
			return tweasers["x"].target; 
		}
		public function get y() : Number
		{
			return tweasers["y"].target; 
		}
		public function get scaleX() : Number
		{
			return tweasers["scaleX"].target; 
		}
		public function get scaleY() : Number
		{
			return tweasers["scaleY"].target ; 
		}
		
		
		
		override public function addNumberTweaser(label : String, value : Number, speed : Number = 0.2, spring : Number = 0, delay : int = 0 ) : NumberTweaser
		{
			var tweaser : NumberTweaser = super.addNumberTweaser(label, value, speed, spring, delay); 
			tweaser.updateFunction = updateProperty; 
			tweaser.updateFunctionArg = label; 
			
			return tweaser;
		}
		
		public function updateProperty(value : Number, propname : String) : void
		{
			clip[propname] = value; 
		}
		public function set delay( n : int ) : void
		{
			for each(var tweaser : NumberTweaser in tweasers) 
			{
				tweaser.delay = n; 
			}
		}
//	
	
	}
}