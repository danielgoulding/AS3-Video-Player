package com.danielgoulding.display.displayer {

	import com.greensock.TweenLite;

	import flash.display.DisplayObject;

	/**
	 * @author danielgoulding
	 */
	public class AlphaFadeDisplayer extends AbstractDisplayer implements IDisplayer {

		// ---------------------------------------------------------------------
		//  CONSTANTS:
		// ---------------------------------------------------------------------
		
		private static const DEFAULT_SHOW_DURATION : Number = 0.4;

		private static const DEFAULT_HIDE_DURATION : Number = 0.4;

		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		public var showDuration : Number;

		public var hideDuration : Number;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function AlphaFadeDisplayer( showDur:Number=DEFAULT_SHOW_DURATION, hideDur:Number=DEFAULT_HIDE_DURATION ) {
			showDuration = showDur;
			hideDuration = hideDur;
		}
		
		// ---------------------------------------------------------------------
		//  PUBLIC API:
		// ---------------------------------------------------------------------
		
		override public function show( display : DisplayObject ) : void {
			display.visible = true;
			TweenLite.to( display, showDuration, { alpha:1 } );
		}
		
		override public function hide( display : DisplayObject ) : void {
			TweenLite.to( display, hideDuration, { alpha:0, onComplete:function() : void {
				display.visible = false;
				hidden.dispatch();
			} } );
		}
	}
}
