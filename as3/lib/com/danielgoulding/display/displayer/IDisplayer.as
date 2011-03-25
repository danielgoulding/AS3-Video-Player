package com.danielgoulding.display.displayer {

	import flash.display.DisplayObject;

	/**
	 * @author danielgoulding
	 */
	public interface IDisplayer {

		function show( display : DisplayObject ) : void;

		function hide( display : DisplayObject ) : void;
	}
}
