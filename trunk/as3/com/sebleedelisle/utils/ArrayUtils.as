package com.sebleedelisle.utils 
{

	/**
	 * @author Seb Lee-Delisle
	 */
	public class ArrayUtils 
	{
		
		
		public static function removeItemFromArray(item : *, array : Array) : void
		{
			var index : int = array.indexOf(item); 
			if(index==-1)
			{
				trace("ArrayUtils.removeItemFromArray - item not found in array");
			}
			else
			{
				array.slice(index+1); 
				array.splice(index, 1); 	
			}
		}
	}
	
	
}
