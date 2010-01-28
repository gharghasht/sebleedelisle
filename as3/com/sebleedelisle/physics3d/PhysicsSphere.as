package  
com.sebleedelisle.physics3d
{
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.objects.primitives.Sphere;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class PhysicsSphere extends PhysicsSphereBase 
	{
		

		public function PhysicsSphere(material : MaterialObject3D = null, radius : Number = 100, segmentsW : int = 8, segmentsH : int = 6)
		{
			super(radius, new Sphere(material, radius, segmentsW, segmentsH));
			
			
			//vel = new Number3D(); 	
			
			//var testSphere : Sphere = new Sphere();
			//testSphere.x = 100; 
			//addChild(testSphere); 
			
			//newPosition = new Number3D(0,0,0); 
		}
		
		
	}
}
