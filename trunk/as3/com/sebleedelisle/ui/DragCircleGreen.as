package com.sebleedelisle.ui 
{
	import flash.text.TextField;
	

	import flash.display.BlendMode;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class DragCircleGreen extends DragCircle 
	{
		private var circleGFX : GreenCircle;
		
		public function DragCircleGreen(x : Number = 0, y : Number = 0, radius : Number = 10, labeltext : String = "")
		{
			circleGFX = new GreenCircle(radius); 
			addChild(circleGFX); 
			super(x, y, radius, 0, 0, 0, BlendMode.NORMAL);
			label = labeltext; 
			
			
			
		}
		
		override public function render() : void
		{
			circleGFX.render(); 	
		}
		public function set label (s : String) : void
		{
			circleGFX.label = s; 
		}
	}
}
