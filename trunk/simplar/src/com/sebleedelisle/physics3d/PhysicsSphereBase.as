package  

com.sebleedelisle.physics3d{
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.objects.DisplayObject3D;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class PhysicsSphereBase extends DisplayObject3D 
	{
		
		public var radius : Number; 
		public var newPosition : Number3D; 
		public var vel : Number3D; 
		
		public var drag : Number = 0.98; 
		public var gravity : Number3D = new Number3D(0, 0, 0);
		public var immovable : Boolean = false; 
		
		public var child : DisplayObject3D; 

		public function PhysicsSphereBase(radius : Number, child : DisplayObject3D)
		{
			super();
			//material, radius, segmentsW, segmentsH);
			
			this.radius = radius; 
			vel = new Number3D(); 	
			
			//var testSphere : Sphere = new Sphere();
			addChild(child); 
			this.child = child; 
			newPosition = new Number3D(0,0,0); 
		}
		
		public function updateForces() : void
		{
			vel.multiplyEq(drag); 
			vel.plusEq(gravity);
			newPosition.copyFrom(position); 
			newPosition.plusEq(vel); 
		}
		
		public function updatePosition() : void
		{
			// position is a getter setter so no worries re objects
			position = newPosition; 	
			
		}
		
		public function updateNewPosToTime(t : Number) : void
		{
			newPosition.copyFrom(vel); 
			newPosition.multiplyEq(t);
			newPosition.plusEq(position); 
		}
	}
}
