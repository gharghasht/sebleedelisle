package ly.seb.simplar 
{
	
	//with thanks to thesven.com who's Alchemy FlarToolkit code I adapted.
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.FLARParam;
	import org.libspark.flartoolkit.core.FLARRgbRaster;
	import org.libspark.flartoolkit.core.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	import org.libspark.flartoolkit.support.pv3d.FLARCamera3D;
	import org.libspark.flartoolkit.support.pv3d.FLARMarkerNode;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.Viewport3D;

	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
		

	public class SimplARBase extends BasicView 
	{
		//this points to the pattern marker which needs to be in the root of the Flex project
		[Embed(source="../seb_ly.patt", mimeType="application/octet-stream")]
		private var MarkerPattern:Class;

		//FLAR variables
		protected var cameraParams:FLARParam;
		protected var marker:FLARCode;
		protected var raster:FLARRgbRaster;
		protected var detector:FLARSingleMarkerDetector;
		protected var result:FLARTransMatResult;
		protected var flarCam:FLARCamera3D;
		protected var container:FLARMarkerNode;
		
		//video variables
		protected var video:Video;
		protected var webCam:Camera;
		protected var camBitmapData:BitmapData;
		protected var camBitmap : Bitmap; 
		
		public const WIDTH:Number = 640;
		public const HEIGHT:Number = 480;
		
		protected var threshold : int = 80; 
		protected var thresholdVariance : int = 1; 
		protected var currentThreshold : int; 
		protected var counter : int = 0; 
		
		public function SimplARBase(pattern : *  = null)
		{

			super(640,480, false); 
			cameraParams = FLARParam.getDefaultParam(WIDTH * 0.5, HEIGHT * 0.5);
			
			marker = new FLARCode(16, 16);
			
			if(pattern == null) 
				pattern  = new MarkerPattern() ; 
			
			marker.loadARPattFromFile(pattern);
			
			init();
		}
		
		protected function init():void
		{
			
			video = new Video(WIDTH, HEIGHT);
			webCam = Camera.getCamera();
			webCam.setMode(WIDTH, HEIGHT, 30);
			video.attachCamera(webCam);
			video.smoothing = true; 
		
			camBitmapData = new BitmapData(WIDTH *0.5, HEIGHT * 0.5,false, 0x000000);
			
			camBitmap = new Bitmap(camBitmapData); 
			camBitmap.scaleX = camBitmap.scaleY = 2; 
			addChildAt(camBitmap,0); 
			
			raster = new FLARRgbRaster(WIDTH *0.5, HEIGHT * 0.5);
			detector = new FLARSingleMarkerDetector(cameraParams, marker, 80);
			result = new FLARTransMatResult();

			viewport.x = -4;
			
			_camera = new FLARCamera3D(cameraParams);
			container = new FLARMarkerNode();
			scene.addChild(container);
			
			add3dObjects(); 
			
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function add3dObjects() : void
		{
			
			var wmat:WireframeMaterial = new WireframeMaterial(0xff0000, 1, 2);
			wmat.doubleSided = true;
			
			var plane : Plane = new Plane(wmat, 80, 80);
			container.addChild(plane);
			
			var light:PointLight3D = new PointLight3D();
			light.x = 1000;
			light.y = 1000;
			light.z = -1000;

			var fmat:FlatShadeMaterial = new FlatShadeMaterial(light, 0xff22aa, 0x0);
			var cube : Cube = new Cube(new MaterialsList({all: fmat}), 40, 40, 40);
			cube.z = -20;
			container.addChild(cube);
			
		}
		
		
		public function enterFrame(e:Event):void
		{
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(0.5, 0.5);
			camBitmapData.draw(video, scaleMatrix);
			
			raster.setBitmapData(camBitmapData);
			
			counter++; 
			
			if(counter == 3) counter = 0; 
						
			var imageFound : Boolean = false
			
			currentThreshold = threshold+ (((counter%3)-1)*thresholdVariance);
			currentThreshold = (currentThreshold>255) ? 255 : (currentThreshold<0) ? 0 : currentThreshold; 
		
			imageFound = (detector.detectMarkerLite(raster, currentThreshold) && detector.getConfidence() > 0.5) ;
			
			if(imageFound)
			{ 
				detector.getTransformMatrix(result);
				container.setTransformMatrix(result);
				container.visible = true;
				
				threshold = currentThreshold;
				thresholdVariance = 0; 
			
				onImageFound();
			} 
			else 
			{
				if(counter==2) thresholdVariance +=2; 
				
				if(thresholdVariance>128 ) thresholdVariance = 1; 
				
				onImageLost(); 
							
			}	
			
			singleRender(); 
		}

		public function onImageFound() : void
		{
			
		}
		
		public function onImageLost() : void
		{
			
		}
		
	}
}
