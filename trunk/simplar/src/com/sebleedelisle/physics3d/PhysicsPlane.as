package  
com.sebleedelisle.physics3d
{
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.objects.primitives.Plane;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class PhysicsPlane extends Plane 
	{
		
		public var normal : Number3D; 
		public var temp : Number3D = new Number3D; // for making temporary calculations
		public var topLeft : Number3D; 
		public var topRight : Number3D; 
		public var botRight : Number3D; 
		public var botLeft : Number3D; 
		
		public var halfWidth : Number; 
		public var halfHeight : Number;
		
		public function PhysicsPlane(material : MaterialObject3D = null, width : Number = 0, height : Number = 0, segmentsW : Number = 0, segmentsH : Number = 0)
		{
			super(material, width, height, segmentsW, segmentsH);
			
			halfWidth = width/2; 
			halfHeight = height/2; 
			
			topLeft = new Number3D(-halfWidth, halfHeight, 0); 
			topRight = new Number3D(halfWidth, halfHeight, 0);
			botRight = new Number3D(halfWidth, -halfHeight, 0); 
			botLeft = new Number3D(-halfWidth, -halfHeight, 0); 
			
			normal = new Number3D(0,0,-1); 
		}
		
		override public function updateTransform() : void
		{
			super.updateTransform();
			updateNormal(); 
			updateCorners(); 
						
		}
		
		public function updateNormal() : void
		{
			normal.reset(0,0,-1); 
			Matrix3D.rotateAxis(transform, normal);
			trace("PLANE NORMAL updated", normal); 
		}
		
		public function updateCorners() : void
		{
			topLeft.reset(-halfWidth, halfHeight, 0); 
			topRight.reset(halfWidth, halfHeight, 0);
			botRight.reset(halfWidth, -halfHeight, 0); 
			botLeft.reset(-halfWidth, -halfHeight, 0); 
			
			Matrix3D.multiplyVector(transform, topLeft);
			Matrix3D.multiplyVector(transform, topRight);
			Matrix3D.multiplyVector(transform, botRight);
			Matrix3D.multiplyVector(transform, botLeft);
			
		}
		
		public function distanceToPoint( p : Number3D) : Number
		{
			// temp becomes the vector between the point and the plane's position
			temp.copyFrom(p); 
			temp.minusEq(position); 
			
			// the signed distance between the point and the plane 
			return Number3D.dot(temp, normal);
		}
		
	}
}
