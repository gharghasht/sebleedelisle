package
{
	public class NumberTweaser implements Tweasable
	{
		
		public var current : Number; 
		public var target : Number; 
		public var tolerance : Number = 0.001; 
		public var speed : Number = 0.2; 
		
		public function NumberTweaser(value : Number = 0)
		{
			current = target = value; 
		}
		
		public function update() : Boolean
		{
			var atrest : Boolean = true; 
			var diff : Number = target - current;
			
			//trace(diff); 
			if(Math.abs(diff) > tolerance)
			{
				current += diff*speed; 
				atrest = false; 
			}
			else
			{
				current = target; 
			}
			
			return atrest; 
						
		}
	}
}