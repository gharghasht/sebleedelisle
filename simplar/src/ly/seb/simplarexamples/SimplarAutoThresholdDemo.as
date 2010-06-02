package ly.seb.simplarexamples
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import ly.seb.simplar.SimplARBase;
	
	[SWF (width="960", height="480", backgroundColor="0x000000",frameRate="30")]	

	
	// This file is to show how the automatic threshold detection works
	// it's not meant for production purposes. 
	
	public class SimplarAutoThresholdDemo extends SimplARBase
	{
		public var thresholdBitmap : BitmapData;

		
		public function SimplarAutoThresholdDemo()
		{
			super();
			
			thresholdBitmap = camBitmapData.clone(); 
			var bitmap : Bitmap = new Bitmap(thresholdBitmap); 
			addChild(bitmap); 
			bitmap.x = WIDTH;

		}
		
		override public function enterFrame(e:Event):void
		{
			super.enterFrame(e); 
			thresholdBitmap.fillRect(thresholdBitmap.rect,0xffffff); 
			thresholdBitmap.threshold(camBitmapData, thresholdBitmap.rect, thresholdBitmap.rect.topLeft,">", currentThreshold | (currentThreshold<<8)| (currentThreshold<<16), 0xffffff, 0xffffff, false); 
		}
	}
}