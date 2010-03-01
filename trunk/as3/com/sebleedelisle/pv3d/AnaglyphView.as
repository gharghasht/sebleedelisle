package com.sebleedelisle.pv3d
{
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Keyboard;
	
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.Viewport3D;

	public class AnaglyphView extends BasicView
	{
		
		public var anaglyphViewport : Viewport3D; 
		
		public var anaglyphOffset : Number = 3; 
		public var anaglyphRotation : Number = 0.3; 
		
		public function AnaglyphView(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			super(viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
			
			anaglyphViewport = new Viewport3D(viewportWidth,viewportHeight,scaleToStage,interactive); 
			addChild(anaglyphViewport); 
			anaglyphViewport.blendMode = BlendMode.SCREEN;
			anaglyphViewport.transform.colorTransform = new ColorTransform(0,12/255,1); 
			
			viewport.transform.colorTransform = new ColorTransform(180/255,0,0); 
			
				
			if(stage) stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown); 
		}
		
		override protected function onRenderTick(event:Event = null) : void
		{
			camera.moveLeft(anaglyphOffset)
			camera.yaw(anaglyphRotation); 
			renderer.renderScene(scene, camera, viewport);			
			
			camera.moveRight(anaglyphOffset*2);
			camera.yaw(anaglyphRotation*-2);  
			renderer.renderScene(scene, camera, anaglyphViewport);	
			
			camera.moveLeft(anaglyphOffset);
			camera.yaw(anaglyphRotation);  		
		}
		
		private function keyDown(e:KeyboardEvent = null) : void
		{
			trace(e.keyCode); 
			
			if(e.keyCode==Keyboard.RIGHT)
			{
				anaglyphOffset++; 
			}
			else if(e.keyCode == Keyboard.LEFT)
			{
				anaglyphOffset--;
			}
			else if(e.keyCode == Keyboard.DOWN)
			{
				anaglyphRotation+=0.1;
			}
			else if(e.keyCode == Keyboard.UP)
			{
				anaglyphRotation-=0.1;
			}
			
			trace(anaglyphOffset, anaglyphRotation);
		}
		
	}
}