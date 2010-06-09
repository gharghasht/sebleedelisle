package ly.seb.tweaser
{
	import flash.display.DisplayObject;
	
	public class DisplayObjectTweaser3D extends DisplayObjectTweaser
	{
		public function DisplayObjectTweaser3D(clip:DisplayObject, speed : Number = 0.2, spring : Number = 0, delay : int = 0)
		{
			super(clip, speed, spring, delay);
			
			addNumberTweaser("z", clip.z, speed, spring, delay); 
			addNumberTweaser("rotationX", clip.rotationX, speed, spring, delay); 
			addNumberTweaser("rotationY", clip.rotationY, speed, spring, delay); 
			addNumberTweaser("rotationZ", clip.rotationZ, speed, spring, delay); 
			addNumberTweaser("scaleX", clip.scaleX, speed, spring, delay);
			addNumberTweaser("scaleY", clip.scaleY, speed, spring, delay);
			
		}
		
		public function set z(n : Number) :  void
		{
			tweasers["z"].target = n; 
		}		
		
		public function set rotationX(n : Number) :  void
		{
			tweasers["rotationX"].target = n; 
		}
		
		public function set rotationY(n : Number) :  void
		{
			tweasers["rotationY"].target = n; 
		}
		
		public function set rotationZ(n : Number) :  void
		{
			tweasers["rotationZ"].target = n; 
		}
		
		
		public function get z() : Number
		{
			return tweasers["z"].target; 
		}		
		
		public function get rotationX() : Number
		{
			return tweasers["rotationX"].target; 
		}
		
		public function get rotationY() : Number
		{
			return tweasers["rotationY"].target; 
		}
		
		public function get rotationZ() : Number
		{
			return tweasers["rotationZ"].target; 
		}
	}
}