
package
{
	public class RoundData
	{
		public var state : int = GameModel.STATE_PRE_PLAY; 
		public var question : String =""; 
		public var items :  Vector.<ItemData>; 
		public var wrongCounts : Array; 
		public var total : int; 
		
		public var lastRevealed : ItemData;
		public var revealCount : int; 
		//public var inPlay : Boolean = true; 
		
		
		public function RoundData()
		{
			items = new Vector.<ItemData>(); 
			reset(); 
		
			
		}
		public function addLabel(shortAnswer : String, num : int, longAnswer : String ="") : void
		{
			var itemData : ItemData = new ItemData(shortAnswer, num, longAnswer) ;
			
			itemData.index = items.length;
			
			items.push(itemData); 
			
			
		}
		
		public function reset() : void
		{
			wrongCounts = [0,0]; 
			total = 0; 
			state = GameModel.STATE_PRE_PLAY;
			lastRevealed = null; 
			revealCount = 0; 
			// not sure about this - keep an eye on it... 
			
			for each(var item : ItemData in items) 
			{
				item.revealed = false; 
			}
		}
		public function wrongCount(team: int) : int
		{
			return wrongCounts[team]; 		
		}
		public function incWrongCount(team : int) : int
		{
			wrongCounts[team]++; 
			
			return wrongCounts[team]; 
		}
		public function resetWrongs(team : int) : void
		{
			wrongCounts[team] = 0; 
		}
		
		public function get inPlay() : Boolean
		{
			return !((state==GameModel.STATE_PRE_PLAY) || (state == GameModel.STATE_ROUND_OVER));
			
		}
	}
}