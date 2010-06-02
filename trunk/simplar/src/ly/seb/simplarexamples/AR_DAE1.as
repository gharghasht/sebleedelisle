package ly.seb.simplarexamples
{
	import org.papervision3d.objects.parsers.DAE;
	import ly.seb.simplar.SimplarBase;

	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	

	public class AR_DAE1 extends SimplarBase
	{
		public var dae : DAE; 
	
		override public function initialise():void
		{
			dae = new DAE(); 
			dae.load("assets/torusknot.dae"); 
			dae.z -=50;
			dae.rotationX = 90; 
			
			container.addChild(dae); 
			
		}
		
	}
}