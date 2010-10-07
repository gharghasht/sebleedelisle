package  
com.sebleedelisle.pv3d
{
	

	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.core.geom.renderables.Line3D;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Plane3D;
	import org.papervision3d.core.proto.CameraObject3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.view.layer.ViewportLayer;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class Draggable3D extends EventDispatcher 
	{
		
		public var do3d : DisplayObject3D; 
		public var viewport : Viewport3D; 
		public var layer : ViewportLayer; 
		public var camera : CameraObject3D;
		
		public var lastMouseX : Number; 
		public var lastMouseY : Number ;
		public var dragPlane : Plane3D;
		
		public var debugLines : Lines3D;
		public var debugLine1 : Line3D; 
		
		public function Draggable3D(do3d : DisplayObject3D, viewport : Viewport3D, camera : CameraObject3D)
		{
			super();
			this.viewport = viewport;
			this.do3d = do3d; 
			this.camera = camera;
			
			debugLines = new Lines3D(new LineMaterial3D(0x000088));
			debugLine1 = debugLines.addNewLine(4,0,0,0,100,0,0); 
			debugLines.visible = false; 
			
			layer = viewport.getChildLayer(do3d, true);
			layer.addEventListener(MouseEvent.MOUSE_DOWN, startDrag); 
			viewport.stage.addEventListener(MouseEvent.MOUSE_UP, stopDrag); 
			layer.buttonMode = true; 
			
			dragPlane = new Plane3D(); 
		}
		
		public function startDrag(e : MouseEvent) : void
		{
			//lastMouseX = viewport.mouseX; 
			//lastMouseY = viewport.mouseY; 
			viewport.addEventListener(Event.ENTER_FRAME, updateDrag);
			
			var normal : Number3D = new Number3D(0,0,1); 
			Matrix3D.rotateAxis(camera.transform, normal);
			
			dragPlane.setNormalAndPoint(normal, do3d.position);
			trace(dragPlane);
			e.stopPropagation();
			
			debugLines.visible = true; 
		}
		public function updateDrag(e : Event) : void
		{
			
			var ray:Number3D = camera.unproject(viewport.containerSprite.mouseX, viewport.containerSprite.mouseY);
			ray.plusEq(camera.position); 
			var intersect:Number3D = dragPlane.getIntersectionLineNumbers(camera.position, ray);
			
			do3d.x = intersect.x; 
			do3d.y = intersect.y; 
			do3d.z = intersect.z; 

			//lastMouseX = viewport.mouseX; 
			//lastMouseY = viewport.mouseY; 
			
		}
		
		public function stopDrag(e : MouseEvent) : void
		{
			viewport.removeEventListener(Event.ENTER_FRAME, updateDrag);
			debugLines.visible = false; 
		}
	}
}
