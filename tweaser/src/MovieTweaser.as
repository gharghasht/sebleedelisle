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
			
			clip.addEventListener(Event.ENTER_FRAME, enterFrame); 
			
		}

		public function enterFrame(e : Event) : void
		{
			update(); 
//			
//			for (var i : String in tweasers) 
//			{
//				var tweaser : Tweasable = tweasers[i];
//				
//				if(tweaser is NumberTweaser)
//					clip[i] = NumberTweaser(tweaser).current; 
//				
//			}
			
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
		
		
		override public function addNumberTweaser(label : String, value : Number = 0) : NumberTweaser
		{
			var tweaser : NumberTweaser = super.addNumberTweaser(label, value); 
			tweaser.updateFunction = updateProperty; 
			tweaser.updateFunctionArg = label; 
			
		}
		
		public function updateProperty(value : Number, propname : String) : void
		{
			clip[propname] = value; 
		}
//	
	
	}
}