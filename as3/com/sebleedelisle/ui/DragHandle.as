package com.sebleedelisle.ui
{
	import com.sebleedelisle.input.KeyUtils;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import com.sebleedelisle.maths.Vector2;
	

	public class DragHandle extends Sprite
	{
		
	//	public var selected : Boolean; 	
		public var scale : Number; 
		
		public var mouseClickPos : Vector2 = new Vector2; 
		public var mousePos : Vector2 = new Vector2;
		public var startScale : Number; 
		
		public var scaling : Boolean = false; 
		public var moving : Boolean = false; 
		
		
		protected var _dirty : Boolean = true; 
		
		public function DragHandle(size : Number = 20, colour : int = 0xff0000, outlinecolour : int = 0xffffff, outlineweight : Number = 0, blendmode : String = BlendMode.NORMAL)
		{
			super();
			
			this.blendMode = blendmode;
			
			graphics.beginFill(colour,0.2);
			graphics.lineStyle(outlineweight,outlinecolour, 0.7); 
			graphics.drawRect(-size/2,-size/2,size, size);
		
			addEventListener(Event.ADDED_TO_STAGE, initListeners); 
			addEventListener(Event.REMOVED, removeStageListeners); 
			
			
			select(false); 
			 
			//this.selected = false; 
			this.scale = 1; 
			
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
			if(e.target!=this) return;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove); 
			
			if(KeyUtils.isDown(Keyboard.SHIFT))
			{
				startScaling(); 
			}
			else
			{
				startDrag(); 
			}
			
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
	
		
		protected function startScaling() : void
		{
			mouseClickPos.reset(stage.mouseX-this.x, stage.mouseY-this.y); 
		
			startScale = scale; 
			scaling = true; 
			
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
			if(state)
				alpha = 1; 
			else
				alpha = 0.5; 
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