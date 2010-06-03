package ly.seb.simplarexamples
{
	import ly.seb.simplar.SimplARBase;
	
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.objects.primitives.Sphere;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
	
	public class SimplAR3_CustomMarker extends SimplARBase
	{
		
		public var sphere : Sphere; 
		
		[Embed(source="../robotsmiley.patt", mimeType="application/octet-stream")]
		private var RobotSmileyPattern:Class;
		
		public function SimplAR3_CustomMarker()
		{
			// simply pass in the Marker into the constructor : 
			super(new RobotSmileyPattern()); 
		}
		
		
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
		
		
	}
}