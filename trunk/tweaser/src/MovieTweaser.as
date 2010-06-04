package
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class MovieTweaser extends TweaserGroup
	{
		
		public var clip : DisplayObject; 
		
		public function MovieTweaser(clip : DisplayObject)
		{
			this.clip = clip; 
			addNumberTweaser("x", clip.x); 
			addNumberTweaser("y", clip.y); 
			addNumberTweaser("rotation", clip.rotation); 
			addNumberTweaser("scaleX", clip.scaleX);
			addNumberTweaser("scaleY", clip.scaleY);
			
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
		
		
		
		override public function addNumberTweaser(label : String, value : Number ) : NumberTweaser
		{
			var tweaser : NumberTweaser = super.addNumberTweaser(label, value); 
			tweaser.updateFunction = updateProperty; 
			tweaser.updateFunctionArg = label; 
			
			return tweaser;
		}
		
		public function updateProperty(value : Number, propname : String) : void
		{
			clip[propname] = value; 
		}
//	
	
	}
}