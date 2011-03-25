package com.danielgoulding.video.controls {

	import com.danielgoulding.video.interfaces.IVideoControlsComponent;
	import com.danielgoulding.video.vo.ControlsVO;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;



	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class AbstractControlsComponent extends Sprite implements IVideoControlsComponent {
		
		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		public var controlsEventSignal : Signal = new Signal( ControlsVO );
		
		protected var skin : MovieClip;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function AbstractControlsComponent( skin:MovieClip ) {
			setSkin( skin );
			init();
		}

		// ---------------------------------------------------------------------
		//  PUBLIC API:
		// ---------------------------------------------------------------------
		
		public function setSkin( movieClip:MovieClip ):void{
			skin = movieClip;
			addChild( skin );
		}
		
		public function init() : void {
			createChildren();
			arrange();
		}

		public function reset() : void {
		}

		public function getUpdateContexts() : Array {
			return [];
		}

		public function updateTime( time : Number, duration : Number=1 ) : void {
		}

		public function updateLoading( value : Number ) : void {
		}

		public function updateVolume( value : Number ) : void {
		}

		public function updateStreamStatus( value : StatusVO ) : void {
		}

		public function updateSize( width : Number, height : Number ) : void {
		}

		public function dispose() : void {
		}

		public function setControlsEventSignal( signal : Signal ) : void {
			controlsEventSignal = signal;
		}
		
		// ---------------------------------------------------------------------
		//  PROTECTED:
		// ---------------------------------------------------------------------
		
		protected function dispatchSignal() : void {
		}
		
		protected function createChildren() : void {
		}

		protected function arrange() : void {
		}
		
	}
}
