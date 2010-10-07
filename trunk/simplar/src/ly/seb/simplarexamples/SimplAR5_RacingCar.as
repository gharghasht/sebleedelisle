package ly.seb.simplarexamples
{
	import com.sebleedelisle.input.KeyTracker;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	
	import ly.seb.simplar.SimplARBase;
	
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shadematerials.EnvMapMaterial;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.primitives.Arrow;
	import org.papervision3d.objects.primitives.Plane;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
	
	public class SimplAR5_RacingCar extends SimplARBase
	{
		public var racingCar : RacingCar3D; 
		
		
		public function SimplAR5_RacingCar() 
		{
			KeyTracker.init(stage); 
			
			super(); 
			
		}
		
		override public function add3dObjects():void
		{
			racingCar = new RacingCar3D(); 
			racingCar.addEventListener(FileLoadEvent.LOAD_COMPLETE, loadComplete); 
			
		}
		
		override public function enterFrame(e:Event):void
		{
			
			if(KeyTracker.upDown) racingCar.accelerate(1); 
			else if(KeyTracker.downDown) racingCar.accelerate(-0.5); 
			
			if(KeyTracker.leftDown) racingCar.steer(1); 
			else if (KeyTracker.rightDown) racingCar.steer(-1);
			
			racingCar.update(); 
			super.enterFrame(e); 
		}
		
		public function loadComplete(e:FileLoadEvent) : void
		{
			racingCar.useOwnContainer = true; 
			container.addChild(racingCar); 
			
		}
		
		override public function onImageFound() : void
		{
			if(racingCar.alpha<1) racingCar.alpha+=0.1; 
		}
		override public function onImageLost() : void
		{
			if(racingCar.alpha>0) racingCar.alpha-=0.1; 
		}
		
	}
}