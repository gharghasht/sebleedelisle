package ly.seb.simplarexamples
{
	import ly.seb.simplar.SimplARBase;
	
	import org.papervision3d.objects.primitives.Cone;
	import org.papervision3d.objects.primitives.Sphere;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	

	public class SimplAR1_Basic extends SimplARBase
	{
		
		override public function add3dObjects() : void
		{
			// make a cone
			var cone : Cone = new Cone(null, 40,60,8,1); 
			
			//adjust its position and rotation
			cone.rotationX =  -90; 
			cone.z = -30;
			
			//add it into the container that is updated 
			//relative to the pattern marker
			container.addChild(cone); 
			
		}
		
	}
}