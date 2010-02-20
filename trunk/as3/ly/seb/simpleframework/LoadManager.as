package ly.seb.simpleframework 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class LoadManager extends EventDispatcher
	{
		public var queue : Array; 
		public var onLoadComplete : Function ;
		
		public function LoadManager() 
		{
			queue = new Array(); 	
			
		}
		
		public function loadSwfs(...args) : void
		{
			
			for each(var item : * in args)
			{
				if(item is String)
				{
					queue.push(item);
				}
				else if(item is Function)
				{
					onLoadComplete = item as Function; 				
				}
			}
			
			startLoading(queue[0]);

		}
		
		public function startLoading(swfURL : String) : void
		{
			var loader : Loader = new Loader(); 
			loader.addEventListener(Event.INIT, swfLoadComplete); 
			
			var urlRequest : URLRequest = new URLRequest(swfURL); 
			loader.load(urlRequest);
		}
		
		public function swfLoadComplete(e : Event) : void
		{
			var loadedItem : String = queue.shift(); 
			trace("LOADED", loadedItem); 
			
			if(queue.length>0)
			{
				startLoading(queue[0]); 
			}
			else
			{
				if(onLoadComplete!=null) onLoadComplete(); 
			}
		}
		
		
	}
}
