package  
com.sebleedelisle.pv3d
{
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.view.BasicView;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class BasicViewMovable extends BasicView 
	{
		
		public var camYaw : Number = 0; 
		public var camTargetYaw : Number = 0; 
		
		public var camPitch : Number = 0; 
		public var camTargetPitch : Number = 0; 
		
		public var isMouseDown : Boolean = false; 
		
		public var camTargetPosition : Number3D; 
		
		public var lastMousePoint : Point = new Point(); 
		public var mouseMoveEnabled : Boolean = true; 
		
		public var cameraDirty : Boolean = true; 
		
		public var hasBeenRendered : Boolean = false; 
		public var moveSpeed : Number = 0.2; 
		
		
		public function BasicViewMovable(viewportWidth : Number = 640, viewportHeight : Number = 480, scaleToStage : Boolean = true, interactive : Boolean = false)
		{
			super(viewportWidth, viewportHeight, scaleToStage, interactive, CameraType.FREE);
		
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown); 
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp); 
		
			camTargetPosition = new Number3D(); 
		}

		override protected function onRenderTick(event:Event = null) : void
		{
			updateCamera(); 
			super.onRenderTick(null); 
			hasBeenRendered = true; 
			
		}
		public function mouseDown(e:MouseEvent) : void
		{
			
			isMouseDown = true; 
			
			lastMousePoint.x = viewport.containerSprite.mouseX; 
			lastMousePoint.y = viewport.containerSprite.mouseY; 
			
			
		}
		public function mouseUp(e:MouseEvent) : void
		{
			isMouseDown = false; 
			
		}
		
			
		public function updateCamera():void
		{
			
			if(isMouseDown && mouseMoveEnabled)
			{
				
				camTargetYaw += (lastMousePoint.x - viewport.containerSprite.mouseX)*0.5; 
				camTargetPitch += (lastMousePoint.y - viewport.containerSprite.mouseY)*0.5;
				
				lastMousePoint.x = viewport.containerSprite.mouseX;
				lastMousePoint.y = viewport.containerSprite.mouseY;
				
			}
			
			cameraDirty = false; 
			
			if(Math.abs(camYaw-camTargetYaw)>0.001)
			{
				camYaw += ((camTargetYaw-camYaw)*moveSpeed);
				cameraDirty = true; 
			}
			else
			{
				camYaw = camTargetYaw; 
			}
			if(Math.abs(camPitch-camTargetPitch)>0.001)
			{
				camPitch += ((camTargetPitch - camPitch) * moveSpeed); 
				cameraDirty = true; 
			}
			else
			{
				camPitch = camTargetPitch; 
			}
			
			//if(pitch<-85) pitch = -85; 
			//if(pitch>85) pitch = 85; 
			if (!hasBeenRendered) cameraDirty = true; 
			
			if(cameraDirty)
			{
				// move the camera to the centre point
				camera.x = camTargetPosition.x; 
				camera.y = camTargetPosition.y; 
				camera.z = camTargetPosition.z; 
				
				camera.rotationY = camYaw; 
				camera.rotationX = camPitch; 
				
				// then move backwards depending on the new angle we're facing
				camera.moveBackward(1900); 
				//trace(cameraDirty, pitch-targetPitch, yaw - targetYaw); 
			}
			
		}
		
		
	}
}
