package com.danielgoulding.utils {

	import com.danielgoulding.functions.traceObject;
	import flash.text.Font;
	import mx.core.FontAsset;


	/**
	 * @author danielgoulding
	 */
	public class FontUtil {

		public static function initFonts() : void {
			FontAsset;
		}

		public static function showFonts() : void {
			if ( !Font.enumerateFonts().length ) {
				return;
			}
			var i:int;
			var n:int = Font.enumerateFonts().length;
			trace("-- <EMBEDDED FONTS> --");
			for ( i=0; i<n; i++ ) {
				trace( " + ", Font.enumerateFonts()[i]['fontName'] );
			}
			trace("-- </EMBEDDED FONTS> --");
		}
		
		public static function registerFonts():void{
			if ( !Font.enumerateFonts().length ) {
				return;
			}
			var i:int;
			var n:int = Font.enumerateFonts().length;
			for ( i=0; i<n; i++ ) {
				
			}
			
		}
	}
}
