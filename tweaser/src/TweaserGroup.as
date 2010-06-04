package
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class TweaserGroup extends EventDispatcher implements Tweasable 
	{
		public var tweasers : Dictionary = new Dictionary(); 
		private var atRest : Boolean = false; 
		
		public function TweaserGroup()
		{
			
		}
		
		public function update() : Boolean
		{
			var active : Boolean  = false;
			for (var i : String in tweasers) 
			{
				var tweaser : Tweasable = tweasers[i];
				active = tweaser.update() || active; 
					
			}
			
			if(!active && !atRest)
			{
				atRest = true; 
				// broadcast atRest message
			}
			
			return atRest; 
		}
		
		public function destroy() : void
		{
			
		}
		
		public function addNumberTweaser(label : String, value : Number) : void
		{
			tweasers[label] = new NumberTweaser(value); 
			
		}
		
	}
}