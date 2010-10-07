package com.sebleedelisle.ui
{
	import com.sebleedelisle.maths.Vector2;

	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class DragCircle extends Sprite
	{
		
		public var scale : Number; 
		
		public var mouseClickPos : Vector2 = new Vector2; 
		public var mousePos : Vector2 = new Vector2;
		public var startScale : Number; 
		
		public var scaling : Boolean = false; 
		public var moving : Boolean = false; 
		
		
		protected var _dirty : Boolean = true;
		protected var _pos : Vector2;
		public var radius : Number;
		protected var colour : int;
		protected var outlineColour : int;
		protected var outlineWeight : Number; 

		public function DragCircle(x : Number = 0, y : Number = 0, radius : Number = 10, colour : int = 0xff0000, outlinecolour : int = 0x000000, outlineweight : Number = 1, blendmode : String = BlendMode.NORMAL)
		{
			super();
			
			this.x = x; 
			this.y = y; 
			
			_pos = new Vector2(x,y); 
			
			this.blendMode = blendmode;
			
			this.radius = radius; 
			this.colour = colour; 
			this.outlineColour = outlinecolour; 
			this.outlineWeight = outlineweight; 
			
			render();

			addEventListener(Event.ADDED_TO_STAGE, initListeners); 
			addEventListener(Event.REMOVED, removeStageListeners); 
			
			buttonMode = true; 
			
			select(false); 
			 			
		}
		
		public function render() : void
		{
			graphics.beginFill(colour);
			graphics.lineStyle(outlineWeight,outlineColour); 
			graphics.drawCircle(0,0,radius); 
		}
		
		public function get pos () : Vector2
		{
			_pos.reset(x, y); 
			return _pos; 
		}
		
		protected function initListeners(e:Event) : void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown); 
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp); 
		}
		
		protected function removeStageListeners(e:Event) : void
		{
			mouseUp(null); 	
			
		}
		protected function mouseDown(e:MouseEvent) : void
		{
			//if(e.target!=this) return;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove); 
			
			
			
			startDrag(); 
			
			
			select(true); 
 
			
		}
		
		protected function mouseUp(e:MouseEvent) : void
		{
			
			if(stage && (stage.hasEventListener(MouseEvent.MOUSE_MOVE)))
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove); 
			
			stopDrag(); 
			
			moving = false; 
			scaling = false; 
			
			select(false); 
			
		}
	
		
		protected function onMouseMove(e:MouseEvent) : void
		{
			if(scaling)
			{
				//if(e.target != this) return;
				mousePos.reset(stage.mouseX-this.x, stage.mouseY-this.y); 
				//mousePos.subtract(mouseClickPos); 
				scale = Math.abs(startScale+((mousePos.y-mouseClickPos.y)*0.01));
				trace(scale, this.mouseY, e.target, this); 
				this.scaleX = this.scaleY = scale;  
			}
			
			_dirty = true; 
			
		}

		public function select(state : Boolean = true) : void
		{
			//if(state)
			//	alpha = 1; 
			//else
			//	alpha = 0.5; 
		}

		public function get dirty() : Boolean 
		{
			return _dirty; 
		}
		
		public function clean () : void 
		{
			_dirty = false; 
		}

		
	}
}