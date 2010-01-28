package com.sebleedelisle.input
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class KeyUtils
	{
		
		public static var stage : Stage;
		public static var keysDown : Array = new Array(); 
		public static var initialised : Boolean = false; 
		
	
		public static var bPaused : Boolean = true;	
		
		
		public static var keyDownCallbacks : Dictionary = new Dictionary(false); 
		
		public function KeyUtils()
		{
		}


		static public function init(s:Stage) : void
		{
			if(initialised) 
			{
				throw (new Error("KeyUtils needs to be initialised before use!")); 
			} 
			
			stage = s; 
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			
			stage.addEventListener( Event.ACTIVATE , appActivate );
			stage.addEventListener( Event.DEACTIVATE, appDeactivate );
			
			initialised = true; 
			
		}
		
		static public function keyDownHandler(event : KeyboardEvent) : void
		{
			//trace("DOWN", event.keyCode, event.charCode, String.fromCharCode(event.charCode)); 
			var rapidFire : Boolean = false ;
			if ( keysDown[event.keyCode] == true )
			{
				rapidFire = true ;
				//trace("RAPID FIRE!"); 
			}
			
			keysDown[event.keyCode] = true;
			//trace("keyDown", keyDownCallbacks, event.charCode); 
			for(var key : * in keyDownCallbacks)
			{
				if(key is Function)
				{
					var callBack : Function = key as Function;
					
					try
					{
						callBack ( event.clone() );//, event.clone (), rapidFire );
					}
					catch ( e : Error )
					{
						callBack(event.charCode, event.clone()); 
					}
				}
			}
			
		}
		static public function keyUpHandler(event : KeyboardEvent) : void
		{
		
			//trace("UP", event.keyCode, event.charCode); 
			keysDown[event.keyCode] = false;
			
		}
		
		static public function isDown(index : int) : Boolean
		{
			
			if(!initialised)
			{
				return false; 
				
				
			}
			stage.focus = stage;
			return keysDown[index]; 
			
		}
		
		
		static public function focusStage() : void
		{
			stage.focus = stage;
		
		}
		static public function isKeyCharDown(char : String) : Boolean
		{
			var code : int = char.charCodeAt(0); 
			return isDown(code); 
			
		}
		
		static public function addKeyDownCallback(callback : Function) : void
		{
		//	trace("adding callback"); 
			keyDownCallbacks[callback] = true; 
			
		}
		static public function removeKeyDownCallback(callback : Function) : void
		{
			if(keyDownCallbacks[callback])
				delete keyDownCallbacks	[callback];
		}
		
		static public function appActivate( event:Event ) : void
		{
			bPaused = false;
		}
		static public function appDeactivate( event:Event ) : void
		{
			// Flush all key-down state
			//keybits = new Array( 256 );
			keysDown = new Array(); 
			bPaused = true;
		}
		
		
	}
}