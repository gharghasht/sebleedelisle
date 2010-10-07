// Augmented Reality wormhole
// Author : Seb Lee-Delisle
// Blog : seb.ly
//
// This work is licenced under a Creative Commons Attribution-Noncommercial-Share Alike 2.0 UK: England & Wales License. 
// 
// Full details of the license are here : http://creativecommons.org/licenses/by-nc-sa/2.0/uk/
// mail me : seb@sebleedelisle.com


package ly.seb.arwormhole
{
	import flash.events.Event;
	
	import ly.seb.simplar.SimplARBase;
	import ly.seb.simplarexamples.SimplAR1_Basic;
	
	import org.papervision3d.view.layer.ViewportLayer;
	
	[SWF (width="640", height="480", backgroundColor="0x000000",frameRate="30")]	
	
	
	public class ARWormhole extends SimplARBase
	{
		
		public var wormhole : WormHole; 
		public var spin : Number = 0; 
		public var depth : Number = 0; 
	
		public var wormHoleLayer : ViewportLayer; 
		public var wormHoleMask : ViewportLayer; 
		
		override public function add3dObjects() : void
		{
		
			wormhole = new WormHole(camBitmapData, viewport.scaleX, viewport.scaleY,100);  
			wormhole.rotationX = -90; 

			container.addChild(wormhole); 

			wormHoleLayer = viewport.getChildLayer(wormhole, true, false); 	
			wormHoleMask = viewport.getChildLayer(wormhole.referenceDisc, true, false); 
			
			wormHoleLayer.mask = wormHoleMask; 
			wormHoleMask.visible = false;
		

		}
		
		override public function enterFrame(e : Event) : void
		{
			wormhole.twist(spin, -depth); 
			
			super.enterFrame(e); 
		}
		
		override public function onImageFound() : void
		{
			if(spin<250) spin+=5; 
			if(depth<250) depth+=5; 
		}

		override public function onImageLost() : void
		{
			if(spin>0) spin-=10; 
			else spin = 0; 
			if(depth>0) depth-=10; 
			else depth = 0; 
		}

	}
}