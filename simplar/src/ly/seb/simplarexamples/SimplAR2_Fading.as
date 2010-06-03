package ly.seb.simplarexamples
{
	import ly.seb.simplar.SimplARBase;
	
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.objects.primitives.Cone;
	import org.papervision3d.objects.primitives.Sphere;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
	
	public class SimplAR2_Fading extends SimplARBase
	{
		
		public var cone : Cone; 
		
		override public function add3dObjects() : void
		{
			// make a cone
			cone = new Cone(new FlatShadeMaterial(new PointLight3D(),0xffffff,0x000000), 40,60,8,1); 
			
			//adjust its position and rotation
			cone.rotationX = -90; 
			cone.z = -30; 
			cone.useOwnContainer = true; 
			
			//add it into the container that is updated 
			//relative to the pattern marker
			container.addChild(cone); 
			
		}
		
		
		// onImageFound is called *every* frame that 
		// the pattern is recognised
		override public function onImageFound() : void
		{
			if(cone.alpha<1) cone.alpha+=0.1; 
		}
		
		
		// onImageLost is called *every* frame that 
		// the pattern is not recognised
		override public function onImageLost() : void
		{
			if(cone.alpha>0) cone.alpha-=0.1; 
		}
		
		
		
	}
}