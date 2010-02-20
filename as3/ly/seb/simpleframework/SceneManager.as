package  
ly.seb.simpleframework{
	import flash.display.Sprite;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class SceneManager extends Sprite 
	{
		
		public var currentScene : Scene; 
		
		public function SceneManager()
		{
			
			
		}
		
		
		public function gotoScene(nextscene : Scene) : void
		{
			if(currentScene)
			{
				currentScene.stop(); 
				removeChild(currentScene); 
			}
			
			nextscene.start(); 
			addChild(nextscene); 
			currentScene = nextscene; 
		}
	}
}
