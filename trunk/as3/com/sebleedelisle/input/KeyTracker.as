package  
com.sebleedelisle.input
{
	import com.sebleedelisle.utils.ArrayUtils;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class KeyTracker 
	{
		
		public static var stage : Stage;
		public static var keysDown : Array = new Array(); 
		public static var keyListeners : Dictionary = new Dictionary(true); 
		
		static public function init(s : Stage) : void
		{
			// if we're already initialised the don't go again!
			if(stage) 
			{
				return; 
			}
			
			stage = s; 
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
				
		}
		
		
		static public function keyDownHandler(event : KeyboardEvent) : void
		{
			
			if((keyListeners[event.keyCode]) && (!keysDown[event.keyCode]))
			{
				for each(var callBack : Function in keyListeners[event.keyCode])
				{
					
					callBack();
				
				}
			}
			keysDown[event.keyCode] = true;
			
		}
		static public function keyUpHandler(event : KeyboardEvent) : void
		{
			keysDown[event.keyCode] = false;
		}
		
		static public function isDown(key : * ) : Boolean
		{
			if(!stage) 
			{
				trace("KeyTracker : ERROR - you must initialise KeyTracker before you can use it");
				return false;
			}
	
			stage.focus = stage;
			var keycode : int = getKeyCode(key);  
			
			
			return keysDown[keycode]; 
					
		}
		 
 		static public function get leftDown() : Boolean
		{
			return isDown(Keyboard.LEFT); 
		}
		static public  function get rightDown() : Boolean
		{
			return isDown(Keyboard.RIGHT); 
		}
		static public  function get upDown() : Boolean
		{
			return isDown(Keyboard.UP); 
		}
		static public function get downDown() : Boolean
		{
			return isDown(Keyboard.DOWN); 
		}
		static public function get spaceDown() : Boolean
		{
			return isDown(Keyboard.SPACE); 
		}
		
		
		static public function addKeyListener(key : *, callback : Function) : void
		{
			
			var keycode : int = getKeyCode(key); 
			
			var callBackArray : Array = keyListeners[keycode];
			if(!callBackArray)
			{
				keyListeners[keycode] = callBackArray = [];
			}
			
			callBackArray.push(callback); 
		}
		
		static public function removeKeyListener(keycode : int, callback : Function) : void
		{
			var callBackArray : Array = keyListeners[keycode];
			if(!callBackArray) return; 
			var index : int = callBackArray.indexOf(callback); 
			
			if(index==-1) return; 
			
			ArrayUtils.removeItemFromArray(callback, callBackArray); 
			
		}
		
		static public function getKeyCode(key : *) : int
		{
		
			if(key is String)
			{
				return String(key).charCodeAt(0);
			}
			else if(key is int)
			{
				return key as int; 
			}	
			else
			{
				return Number.NaN; 
			}
		}
		
	}
}
