package com.danielgoulding.utils {

	import flash.utils.Dictionary;
	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class RegExpUtil {
		
		/**
		 * formatLinks( text:String )
		 * Adds "event:" to HTML href tags
		 * @param text	: the text to use
		 * @return		: the text with formatted links
		 */
		public static function formatHrefLinks( text:String ):String{
			var regExp:RegExp = new RegExp( RegularExpressions.HREF_LINK, "g" );
			return text.replace( regExp, "$1event:$2$3" );
		}
		
		/**
		 * formatLineBreaks( text:String )
		 * group multiple line breaks and convert to \n
		 * @param text	: the text to use
		 * @param n		: the number of consecutive breaks
		 * @return		: the text with formatted line breaks
		 */
		public static function formatLineBreaks( text:String, n:int=2 ):String{
			var replacement:String = "";
			var i:int = 0;
			do {
				replacement += "\n";
				i++;
			} while ( i < n );
			var regExp : RegExp = new RegExp( RegularExpressions.MULTIPLE_LINE_BREAKS, "gi" );
			return text.replace( regExp, replacement );
		}
		
		public static function stripHTMLTags( string : String ) : String {
			var regExp : RegExp = new RegExp( RegularExpressions.HTML_TAG, "g" );
			return string.replace( regExp, "" );
		}
		
		/**
		 * tests string for match on pattern
		 * @param string	: string to test
		 * @param pattern	: the regexp pattern string
		 * @return			: Boolean on match result
		 */
		public static function isMatch( string:String, pattern:String ):Boolean{
			var regExp : RegExp = new RegExp( pattern );
			var match:Array = string.match( regExp );
			return match != null;
		}
		
		public static function getTagIndexes( string : String ) : Array {
			var dictionary:Dictionary = new Dictionary( true );
			var regExp : RegExp = new RegExp( RegularExpressions.HTML_TAG );
			var index:int;
			var replaceFunction:Function = function():String {
				dictionary[ index ] = arguments[0];
				return "";
			};
			do {
				index = string.search( regExp );
				if ( index != -1 ){
					string = string.replace( regExp, replaceFunction );
				}
			} while ( index != -1 );
			return DictionaryUtil.sortOnKeys( dictionary, Array.NUMERIC );
		}
	}
}
