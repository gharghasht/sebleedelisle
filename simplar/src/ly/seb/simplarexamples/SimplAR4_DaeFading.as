package ly.seb.simplarexamples
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shadematerials.EnvMapMaterial;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.primitives.Plane;
	import ly.seb.simplar.SimplARBase;

	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	

	public class SimplAR4_DaeFading extends SimplARBase
	{
		public var dae : DAE; 

		override public function add3dObjects():void
		{
			dae = new DAE(); 
			dae.load("assets/torusknot.dae"); 
			dae.z -=50;
			dae.rotationX = 90; 
			
			dae.addEventListener(FileLoadEvent.LOAD_COMPLETE, daeLoadComplete); 
		
		}
		
		override public function enterFrame(e:Event):void
		{
			dae.yaw(3); 
			super.enterFrame(e); 
		}
		
		public function daeLoadComplete(e:FileLoadEvent) : void
		{
			dae.useOwnContainer = true; 
			container.addChild(dae); 
			
		}
		
		override public function onImageFound() : void
		{
			if(dae.alpha<1) dae.alpha+=0.1; 
		}
		override public function onImageLost() : void
		{
			if(dae.alpha>0) dae.alpha-=0.1; 
		}
		
	}
}