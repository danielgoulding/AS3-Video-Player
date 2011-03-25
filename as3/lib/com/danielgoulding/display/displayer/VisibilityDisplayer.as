package com.danielgoulding.display.displayer {

	import flash.display.DisplayObject;

	/**
	 * @author danielgoulding
	 */
	public class VisibilityDisplayer extends AbstractDisplayer implements IDisplayer {

		public function VisibilityDisplayer() {
		}

		// ---------------------------------------------------------------------
		// PUBLIC API:
		// ---------------------------------------------------------------------
		override public function show( display : DisplayObject ) : void {
			display.visible = true;
		}

		override public function hide( display : DisplayObject ) : void {
			display.visible = false;
			hidden.dispatch();
		}
	}
}
