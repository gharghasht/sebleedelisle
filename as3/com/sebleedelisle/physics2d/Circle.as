package com.sebleedelisle.physics2d 
{
	import com.sebleedelisle.maths.Vector2;

	import flash.display.Sprite;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class Circle extends Sprite
	{
		
		public var pos : Vector2; 
		public var radius : Number;
		private var circleGFX : CircleGFX; 

		public function Circle(x : Number, y : Number, r : Number, col : int = 0x0066cc, outlinecol : int = 0x000000, outlineweight : Number = 2) 
		{
			pos = new Vector2(x,y); 
			radius = r; 
			
			circleGFX = new CircleGFX();
			addChild(circleGFX); 
			
			
			/*graphics.lineStyle(outlineweight, outlinecol); 
			graphics.beginFill(col); 
			graphics.drawCircle(0,0,radius);
			 * 
			 */
			render (); 
		}
		
		
		public function render() : void
		{
			x = pos.x; 
			y = pos.y; 
			circleGFX.scaleX =circleGFX.scaleY = radius/10; 
			
		}
	}
}
