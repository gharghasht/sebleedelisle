
package
{
	public class ItemData
	{
		
		public var answerText : String; 
		public var answerTextLong : String; 
		public var num : int; 
		public var revealed : Boolean; 
		public var index : int; 
		
		public function ItemData(answerShort : String, num : int, answerLong :String = "")
		{
			this.answerText = answerShort; 
			this.answerTextLong = (answerLong=="") ? answerShort : answerLong; 
			this.num = num; 
			revealed = false;
		}
	}
}