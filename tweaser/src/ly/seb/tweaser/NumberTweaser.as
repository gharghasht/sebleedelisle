package ly.seb.tweaser
{
	import ly.seb.tweaser.core.ITweasable;

	public class NumberTweaser implements ITweasable
	{
		
		public var current : Number; 
		public var target : Number; 
		public var vel : Number = 0;
		
		public var tolerance : Number = 0.0001; 
		public var speed : Number = 0.2; 
		
		public var delay : int = 0; 
		
		
		protected var spring : Number = 0; 
		
		public var updateFunction : Function; 
		public var updateFunctionArg : *; 
		
		public var atRest : Boolean = true; 
		
		public function NumberTweaser(value : Number = 0, speed : Number = 0.2, spring : Number = 0, delay : int = 0, autoUpdate : Boolean = false)
		{
			current = target = value; 
			this.speed = speed; 
			this.spring = spring;  
			this.delay = delay;
			
		}
		
		// update returns true if its still moving
		
		public function update() : Boolean
		{
			if(delay>0) 
			{
				delay --; 
				return false; 
			}
			
			var diff : Number; 
			var changed : Boolean = false; 
			
			if((target==current) && (vel==0)) return true; 
			
			diff = target - current;
			
//			if(!springy)
//			{
//				// fast version of : if(Math.abs(diff) > tolerance)
//				if((diff > 0 ? diff : -diff) > tolerance)
//				{
//					current += diff*speed; 
//					atRest = false; 
//					
//					changed = true; 
//				}
//				else if(!atRest)
//				{
//					atRest = true; 
//					current = target;
//					changed = true; 	
//				}
//			}
//			else
//			{
				vel*=spring; 
				
				if(((diff > 0 ? diff : -diff)>tolerance) || ((vel > 0 ? vel : -vel) > tolerance))
				{
					diff*=speed;
					vel+=diff; 
					current+=vel; 
					atRest=false;
					
					changed = true; 
				}
				else if(!atRest)
				{
					atRest = true; 
					current = target; 
					vel = 0;
					
					changed = true; 
				}
			//}
		
			if((changed) && (updateFunction!=null))
			{
				updateFunction(current, updateFunctionArg); 
			}
			
			return !atRest; 
						
		}
		
		public function get springy() : Boolean
		{
			return spring>0; 
		}
	}
}