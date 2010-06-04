package
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class TweaserGroup extends EventDispatcher implements ITweasable 
	{
		public var tweasers : Dictionary = new Dictionary(); 
		private var atRest : Boolean = false; 
		
		public function TweaserGroup()
		{
			
		}
		
		public function update() : Boolean
		{
			var moving : Boolean  = false;
			
			for (var i : String in tweasers) 
			{
				var tweaser : ITweasable = tweasers[i];
				moving = tweaser.update() || moving; 
					
			}
			
			if(atRest && moving)
			{
				//broadcast started message!
				atRest = false; 
			}
			else if(!moving && !atRest)
			{
				atRest = true; 
				// broadcast atRest message
			}
			
			return !atRest; 
		}
		
		public function destroy() : void
		{
			
		}
		
		public function addNumberTweaser(label : String, value : Number) : NumberTweaser
		{
			return tweasers[label] = new NumberTweaser(value); 
			
		}
		
	}
}