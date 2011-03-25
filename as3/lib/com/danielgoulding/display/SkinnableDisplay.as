package com.danielgoulding.display {

	import com.danielgoulding.display.displayer.AbstractDisplayer;
	import com.danielgoulding.display.displayer.VisibilityDisplayer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;


	/**
	 * @author danielgoulding
	 */
	public class SkinnableDisplay extends Sprite {

		// ----------------------------------------------------------------------
		// VARIABLES:
		// ----------------------------------------------------------------------
		public var skin : DisplayObject;

		protected var isShowing : Boolean;

		protected var displayer : AbstractDisplayer = new VisibilityDisplayer();

		protected var display : DisplayObject = this as DisplayObject;

		protected var isInit : Boolean;

		protected var isDisposed : Boolean;

		// ----------------------------------------------------------------------
		// CONSTRUCTOR:
		// ----------------------------------------------------------------------
		public function SkinnableDisplay( skin : DisplayObject = null, autoInit : Boolean = true ) : void {
			setSkin( skin );
			if ( autoInit ) init();
		}

		// ----------------------------------------------------------------------
		// PUBLIC API:
		// ----------------------------------------------------------------------
		public function setSkin( displayObject : DisplayObject ) : void {
			skin = displayObject;
			if ( skin && !skin.parent ) {
				addChild( skin );
			} else if ( skin ) {
				display = skin;
			}
		}

		public function setDisplayer( displayer : AbstractDisplayer ) : void {
			this.displayer = displayer;
			displayer.hidden.add( onHidden );
		}

		public function show() : void {
			if ( isShowing ) {
				return;
			}
			isShowing = true;
			displayer.show( display );
		}

		public function hide() : void {
			if ( !isShowing ) {
				return;
			}
			isShowing = false;
			displayer.hide( display );
		}

		public function init() : void {
		}

		public function dispose() : void {
			display = null;

			if (contains( skin )) {
				removeChild( skin );
			}

			isDisposed = true;
		}

		// ---------------------------------------------------------------------
		// HANDLERS:
		// ---------------------------------------------------------------------
		protected function onHidden() : void {
		}
	}
}
