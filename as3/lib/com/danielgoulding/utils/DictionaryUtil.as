package com.danielgoulding.utils {

	import com.danielgoulding.vo.KeyVO;
	import flash.utils.Dictionary;

	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class DictionaryUtil {
		
		public static function sortOnKeys( dictionary:Dictionary, sortOption:int=1 ):Array{
			var keys:Array = [];
			for ( var key:Object in dictionary ) {
				keys.push( key );
			}
			keys = keys.sort( sortOption );
			var i:int;
			var n:int = keys.length;
			var sortedItems:Array = [];
			for ( i = 0; i < n; i++ ) {
				sortedItems.push( new KeyVO( { key:keys[i], value:dictionary[ keys[i] ] } ) );
			}
			return sortedItems;
		}
	}
}
