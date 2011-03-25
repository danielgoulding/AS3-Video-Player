package com.danielgoulding.display.displayer {

	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;

	/**
	 * @author danielgoulding
	 */
	public class AbstractDisplayer implements IDisplayer {

		public var hidden : Signal = new Signal();
		
		// ---------------------------------------------------------------------
		// CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function AbstractDisplayer() {
		}

		// ---------------------------------------------------------------------
		// PUBLIC API:
		// ---------------------------------------------------------------------
		
		public function show( display : DisplayObject ) : void {
		}

		public function hide( display : DisplayObject ) : void {
		}
	}
}
