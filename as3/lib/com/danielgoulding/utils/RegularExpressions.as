package com.danielgoulding.utils {
	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class RegularExpressions {
		
		public static const VALID_URL : String = "^http(s)?:\\/\\/((\\d+\\.\\d+\\.\\d+\\.\\d+)|(([\\w-]+\\.)+([a-z,A-Z][\\w-]*)))(:[1-9][0-9]*)?(\\/([\\w-.\\/:%+@&=]+[\\w- .\\/?:%+@&=]*)?)?(#(.*))?$";
		
		public static const MULTIPLE_LINE_BREAKS : String = "(\\r|\\n|<br\\s*\\/?>)+";

		public static const HREF_LINK : String = "(href\\s*=\\s*[\"'])([\\w\\?\\/\\.\\$\\*\\(\\):#-;@=&%]+)([\"'])";
		
		public static const HTML_TAG : String = "(<.*?>)";
		
		public static const HTML_OPENING_TAG : String = "<([^\\/][^>]*)>";
		
		public static const HTML_CLOSING_TAG : String = "<\\/([^>]+)>";
		
		
	}
}
