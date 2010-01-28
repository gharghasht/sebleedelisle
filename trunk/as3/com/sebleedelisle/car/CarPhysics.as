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
		public var steeringStrength  :Number = 0.6; 
		
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
			g.drawRoundRect(-20, -10, 20, 10, 6);
		}
		
		public function accelerate(amount : Number = 1) : void
		{
			var force : Vector2 = normal.clone(); 
			force.multiplyEq(amount * enginePower); 
			vel.plusEq ( force); 
			
			
		}
		public function steer(amount : Number) : void
		{
			//var speedadjustment : Number = 1 - (vel.magnitude()/50);
			wheelRotation+=(amount * 0.25);// * speedadjustment); 
			if(wheelRotation>1) wheelRotation = 1; 
			else if (wheelRotation<-1) wheelRotation = -1; 
			steering = true; 
			
		}
		public function update() : void
		{
			
			
			
			forwardVel = vel.dot(normal); 
			forwardVel*=forwardFriction; 
			
			var easedWheelRotation : Number = wheelRotation*wheelRotation; 
			if(wheelRotation<0) easedWheelRotation = -easedWheelRotation; 
			
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
			
		
			wheelRotation*=0.4;
			
		}
	}
}
