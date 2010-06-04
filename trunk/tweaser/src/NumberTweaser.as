package
{
	public class NumberTweaser implements Tweasable
	{
		
		public var current : Number; 
		public var target : Number; 
		public var tolerance : Number = 0.001; 
		public var speed : Number = 0.2; 
		public var updateFunction : Function; 
		public var updateFunctionArg : *; 
		
		public var atRest : Boolean = true; 
		
		public function NumberTweaser(value : Number = 0)
		{
			current = target = value; 
		}
		
		public function update() : Boolean
		{
			
			var diff : Number = target - current;
			
			//trace(diff); 
			if(Math.abs(diff) > tolerance)
			{
				current += diff*speed; 
				atRest = false; 
			}
			else if(!atRest)
			{
				atRest = true; 
				current = target;
				if(updateFunction) updateFunction.apply(current, updateFunctionArg); 
			}
			
			return atRest; 
						
		}
	}
}