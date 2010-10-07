package
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	
	import org.wiiflash.Wiimote;
	import org.wiiflash.events.ButtonEvent;

	public class WiimoteManager
	{
		
		public var pressed : Array; 
		public var buttonCallBack : Function;
		public var connected : Boolean = false; 
		
		public var wiimotes : Vector.<Wiimote>; 
		public function WiimoteManager(buttonCallBack : Function)
		{
			wiimotes = new Vector.<Wiimote>(); 
			pressed = new Array(); 
			this.buttonCallBack = buttonCallBack;
			
			for(var i : int = 0; i<4;i++)
			{
				var wiimote: Wiimote = new Wiimote();
				wiimote.addEventListener( Event.CONNECT, onWiimoteConnect );
				wiimote.addEventListener(IOErrorEvent.IO_ERROR,onIOError); 
				//				try
				//				{
				
				//				}
				//				finally
				//				{
				//					trace("ERROR!");
				//				}
				//				catch(error : IOError)
				//				{
				//					trace("ERROR CONNECTING");
				//				}
				wiimotes.push(wiimote)	;
				pressed.push(false); 
			}
			
			
		}
		
		
		public function connect() : void
		{
			ControlPanel.instance.showConnectLight(false); 
			
			for each(var wiimote : Wiimote in wiimotes)
			{
				wiimote.connect();
				trace("wiimote.connect");
			}
			
			
		}
		
		public function onWiimoteConnect(e:Event) : void
		{
			trace("CONNECTED!", e.target); 
			
			var wiimote : Wiimote = e.target as Wiimote; 
			wiimote.mouseControl  = false; 
			wiimote.addEventListener(ButtonEvent.A_PRESS, pressButton); 
			wiimote.addEventListener(ButtonEvent.B_PRESS, pressButton); 
			wiimote.addEventListener(ButtonEvent.A_RELEASE, releaseButton); 
			wiimote.addEventListener(ButtonEvent.B_RELEASE, releaseButton); 
			connected = true; 
			
			ControlPanel.instance.showConnectLight(true); 
		}
		public function onIOError(e: IOErrorEvent) : void
		{
			trace("ERROR"); 
			connected = false; 
			
			ControlPanel.instance.showConnectLight(false); 
			
		}
		
		public function pressButton(e : ButtonEvent) : void
		{
			var wiimote : Wiimote = e.target as Wiimote; 
			trace("button Pressed", e.target); 
			//snd.play(300); 
			pressed[wiimote.id] = true; 
			buttonCallBack(wiimote.id, true);
			
			//wiimote.rumbleTimeout = 1; 
			wiimote.leds = Wiimote.LED1 | Wiimote.LED2 | Wiimote.LED3 | Wiimote.LED4;
			trace(wiimote.leds); 
		}
		public function releaseButton(e : ButtonEvent) : void
		{
			var wiimote : Wiimote = e.target as Wiimote; 
			trace("button Released", e.target); 
			//snd.play(300); 
			pressed[wiimote.id] = false; 
			buttonCallBack(wiimote.id, false);
			wiimote.leds = 0; 
			//wiimote.leds = Wiimote["LED"+(wiimote.id+1)]
		}
	}
}