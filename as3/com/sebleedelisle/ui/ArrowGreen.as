package com.sebleedelisle.ui 
{
	import com.sebleedelisle.maths.Vector2;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class ArrowGreen extends Sprite 
	{
		private var arrowGFX : ArrowGFX;
		private var _label : String;
		private var labelTextField : TextField; 
		public var start : Vector2; 
		public var end : Vector2; 
		public var v : Vector2;
		public var arrowDistance : Number = 1; 

		public function ArrowGreen(x1 : Number = 0, y1 : Number = 0, x2 : Number = 10, y2 : Number = 0, labeltext : String = "")
		{
			this._label = labeltext;
			
			start = new Vector2(x1,y1); 
			end = new Vector2(x2, y2); 
			v = new Vector2(); 
			
			arrowGFX = new ArrowGFX(); 
			addChild(arrowGFX); 
			labelTextField = arrowGFX.textField; 
			labelTextField.defaultTextFormat = labelTextField.getTextFormat(); 
			arrowGFX.removeChild(labelTextField); 
			
			render(); 
			
			label = labeltext; 
		}
		
		public function setStartPoint(...args) : void
		{
			if(args[0] is Vector2)
			{
				start.copyFrom(args[0] as Vector2);
			}
			else if(args[0] is Number)
			{
				start.x = args[0] as Number; 
				if(args[1] is Number) start.y = args[1];
			}
			render(); 
		}
		
		public function setEndPoint(...args) : void
		{
			if(args[0] is Vector2)
			{
				end.copyFrom(args[0] as Vector2);
			}
			else if(args[0] is Number)
			{
				end.x = args[0] as Number; 
				if(args[1] is Number) end.y = args[1];
			}
			render(); 
		}
		
		public function setVector(...args) : void
		{
			if(args[0] is Vector2)
			{
				v.copyFrom(args[0] as Vector2);
			}
			else if(args[0] is Number)
			{
				v.x = args[0] as Number; 
				if(args[1] is Number) v.y = args[1];
			}
			end.copyFrom(start); 
			end.plusEq(v); 
			render(); 
		}
		
		public function render() : void
		{
			//arrowGFX.scaleX = arrowGFX.scaleY = radius/10;
			x = start.x; 
			y = start.y; 
			
			v.copyFrom(end); 
			v.minusEq(start); 
			graphics.clear(); 
			graphics.lineStyle(2,0x007700); 
			graphics.moveTo(0,0); 
			graphics.lineTo(v.x, v.y); 
			arrowGFX.x = v.x * arrowDistance;
			arrowGFX.y = v.y * arrowDistance; 
			arrowGFX.rotation = v.angle(); 
			 	
			labelTextField.x = arrowGFX.x-4; 
			labelTextField.y = arrowGFX.y+4; 
				
		}
		
		public function set label (s : String) : void
		{
			if(!contains(labelTextField	)) addChild(labelTextField); 
			labelTextField.text = s; 
			
		}
	}
}
