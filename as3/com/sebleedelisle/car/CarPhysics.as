package com.sebleedelisle.car 
{
	import com.sebleedelisle.maths.Vector2;

	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class CarPhysics extends Sprite 
	{
		public var vel : Vector2; 
		public var forwardVel : Number; 
		public var forwardFriction : Number = 0.99; 
		public var steeringStrength  :Number = 0.25; 
		
		public var normal : Vector2; 
		
		public var pos : Vector2; 
		public var newPos : Vector2; 
		public var wheelRotation : Number ;// I'm thinking probably -1 to +1; 
		private var enginePower : Number = 0.3;
		private var steering : Boolean; 

		public function CarPhysics()
		{
			vel = new Vector2() ; 
			pos = new Vector2() ; 
			newPos = new Vector2() ; 
			normal = new Vector2(1,0); 
			wheelRotation = 0; 
			forwardVel = 0; 
			
			var g : Graphics = graphics; 
			g.beginFill(0x9999bb,1); 
			g.drawRoundRect(-40, -20, 40, 20, 6);
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
			
			forwardVel = vel.dot(normal); 
			forwardVel*=friction; 
			var speedadjustment : Number = 1 - (Math.min(1,(vel.magnitude()/45)));
			var easedWheelRotation : Number = wheelRotation * speedadjustment;//*wheelRotation; 
			//if(wheelRotation<0) easedWheelRotation = -easedWheelRotation; 
			
			rotation += (easedWheelRotation*forwardVel*steeringStrength);
			normal.reset(1,0); 
			normal.rotate(rotation); 
			vel.copyFrom(normal); 
			vel.multiplyEq(forwardVel); 
			
			pos.plusEq(vel);
			
			x = pos.x; 
			y = pos.y; 		
			
			 
			//trace(rotation, normal, normal.angle());
			//trace(forwardVel, vel, normal); 
			
			if(!steering)
				wheelRotation*=0.4;
			else
			{
				if(wheelRotation>1) wheelRotation = 1; 
				else if (wheelRotation<-1) wheelRotation = -1; 
				
				steering = false; 		
			}
			//trace("wheel rotation", wheelRotation);
		}
	}
}
