package ly.seb.simplarexamples
{
	import ly.seb.simplar.SimplARBase;
	
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.objects.primitives.Sphere;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
	
	public class SimplAR_Sphere2 extends SimplARBase
	{
		
		public var sphere : Sphere; 
		
		override public function add3dObjects() : void
		{
			// make a sphere
			sphere = new Sphere(new FlatShadeMaterial(new PointLight3D(),0xffffff,0x000000), 40); 
			
			//adjust its position and rotation
			sphere.rotationX =  90; 
			sphere.z = -50; 
			sphere.useOwnContainer = true; 
			
			//add it into the container that is updated 
			//relative to the pattern marker
			container.addChild(sphere); 
			
		}
		
		
		// onImageFound is called *every* frame that 
		// the pattern is recognised
		override public function onImageFound() : void
		{
			if(sphere.alpha<1) sphere.alpha+=0.1; 
		}
		
		
		// onImageLost is called *every* frame that 
		// the pattern is not recognised
		override public function onImageLost() : void
		{
			if(sphere.alpha>0) sphere.alpha-=0.1; 
		}
		
		
		
	}
}