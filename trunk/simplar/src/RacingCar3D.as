package  
{
	import com.sebleedelisle.maths.Vector2;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.primitives.Arrow;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class RacingCar3D extends DisplayObject3D 
	{
		public var vel : Vector2; 
		public var forwardVel : Number; 
		public var forwardFriction : Number = 0.98; 
		public var steeringStrength  :Number = 0.3; 
		
		public var normal : Vector2; 
		
		public var pos : Vector2; 
		public var newPos : Vector2; 
		public var wheelRotation : Number ;//  -1 to +1; 
		public var enginePower : Number = 0.2; 
		public var steering : Boolean;
		
		public var rotation : Number = 0; 
	
		public var dae : DAE; 
		//public var tiresFront : Sprite; 

		public function RacingCar3D()
		{
			
			super(); 
			vel = new Vector2() ; 
			pos = new Vector2() ; 
			newPos = new Vector2() ; 
			normal = new Vector2(1,0); 
			wheelRotation = 0; 
			forwardVel = 0; 
			
			dae = new DAE(); 
			
			dae.load("assets/focus.dae"); 
			scale = 4; 
			dae.rotationX = -90; 
			dae.rotationZ = -90; 
			
			dae.addEventListener(FileLoadEvent.LOAD_COMPLETE, loadComplete);
			addChild(dae); 
			
							 
		}
		
		
		public function loadComplete(e : FileLoadEvent) : void
		{
			/*var arrow : Arrow = new Arrow(); 
			arrow.scale =0.02; 
			addChild(arrow);*/
			dispatchEvent(e.clone()); 
		}
		
		public function accelerate(amount : Number = 1) : void
		{
			var force : Vector2 = normal.clone(); 
			force.multiplyEq(amount * enginePower); 
			vel.plusEq ( force); 
			
			
		}
		public function steer(amount : Number) : void
		{
			
			wheelRotation+=(amount * 0.1 ); 
			steering = true; 
			
		}
		public function update(friction : Number = NaN) : void
		{
			
			if(isNaN(friction)) friction = forwardFriction;
			
			// get the speed in the direction we're facing
			forwardVel = vel.dot(normal); 
			// add a bit of drag 
			forwardVel *= friction; 
			
			var speedadjustment : Number = 1 - (Math.min(1,(vel.magnitude()/45)));
			var easedWheelRotation : Number = wheelRotation * speedadjustment;
			
			rotation += (easedWheelRotation*forwardVel*steeringStrength);
			
			// update normal (unit vector in the direction of the car)
			normal.reset(1,0); 
			normal.rotate(rotation); 
			
			// velocity = normal * forwardVel
			
			vel.copyFrom(normal); 
			vel.multiplyEq(forwardVel); 
			
			pos.plusEq(vel);
			
			x = pos.x; 
			y = pos.y; 		
			
			 
			if(!steering)
				wheelRotation*=0.4;
			else
			{
				if(wheelRotation>1) wheelRotation = 1; 
				else if (wheelRotation<-1) wheelRotation = -1; 
				
				steering = false; 		
			}
			
			rotationZ = rotation; 
			//tiresFront.rotation = easedWheelRotation * 10; 
		}
	}
}
