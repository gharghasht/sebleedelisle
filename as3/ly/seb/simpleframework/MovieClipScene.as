package ly.seb.simpleframework 
{
	import flash.events.MouseEvent;
	import ly.seb.simpleframework.Scene;

	import flash.display.MovieClip;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class MovieClipScene extends Scene 
	{
		public var clip : MovieClip;
		
		public function MovieClipScene(clip : MovieClip)
		{
			super();
			
			this.clip = clip; 
			addChild(clip); 
			
		}
		
		public function linkButton(buttonlabel : String, callback : Function) : void 
		{
			var buttonclip : MovieClip = clip[buttonlabel];
			buttonclip.gotoAndStop("_up");
			buttonclip.buttonMode = true; 
			buttonclip.addEventListener(MouseEvent.CLICK, callback); 	
			
		}
		
	}
}
