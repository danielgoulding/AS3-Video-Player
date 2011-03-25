package com.danielgoulding.video {

	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.interfaces.IVideoControlsComponent;
	import com.danielgoulding.video.vo.ControlsVO;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;




	/**
	 * @author danielgoulding
	 */
	public class VideoControls extends Sprite {

		// ----------------------------------------------------------------------
		// VARIABLES:
		// ----------------------------------------------------------------------
		
		private var skin : MovieClip;

		private var controlsComponents : Array;

		private var observers : Array;

		private var videoHeight : Number;

		private var videoWidth : Number;

		public var netStreamStatusSignal : Signal;

		public var controlsEventSignal : Signal = new Signal( ControlsVO );

		// ----------------------------------------------------------------------
		// CONSTRUCTOR:
		// ----------------------------------------------------------------------
		
		public function VideoControls( skin : MovieClip = null ) : void {
			setSkin( skin );
			init();
		}

		// ----------------------------------------------------------------------
		// PUBLIC API:
		// ----------------------------------------------------------------------
		
		public function setNetStreamStatusSignal( signal : Signal ) : void {
			netStreamStatusSignal = signal;
			netStreamStatusSignal.add( updateStreamStatus );
		}

		public function setControlsEventSignal( signal : Signal ) : void {
			controlsEventSignal = signal;
		}

		public function addControlComponent( component : IVideoControlsComponent, childIndex : int = -1 ) : void {
			var contexts : Array = component.getUpdateContexts();
			addObserver( component, contexts );
			component.setControlsEventSignal( controlsEventSignal );
			childIndex = childIndex != -1 ? childIndex : numChildren;
			addChildAt( component as Sprite, childIndex );
			controlsComponents.push( component );
			updateSize();
		}

		public function reset() : void {
			var i : int;
			var n : int = controlsComponents.length;
			for ( i = 0; i < n; i++ ) {
				IVideoControlsComponent( controlsComponents[i] ).reset();
			}
		}

		public function updatePlayhead( time : Number, duration : Number ) : void {
			var array : Array = observers[ ControlUpdateContext.TIME ] as Array;
			var i : int;
			var n : int = array.length;
			for ( i = 0; i < n; i++ ) {
				IVideoControlsComponent( array[i] ).updateTime( time, duration );
			}
		}

		public function updateLoading( value : Number ) : void {
			var array : Array = observers[ ControlUpdateContext.LOADING ] as Array;
			var i : int;
			var n : int = array.length;
			for ( i = 0; i < n; i++ ) {
				IVideoControlsComponent( array[i] ).updateLoading( value );
			}
		}

		public function updateVolume( value : Number ) : void {
			var array : Array = observers[ ControlUpdateContext.VOLUME ] as Array;
			var i : int;
			var n : int = array.length;
			for ( i = 0; i < n; i++ ) {
				IVideoControlsComponent( array[i] ).updateVolume( value );
			}
		}

		public function updateStreamStatus( value : StatusVO ) : void {
			var array : Array = observers[ ControlUpdateContext.STREAM_STATUS ] as Array;
			var i : int;
			var n : int = array.length;
			for ( i = 0; i < n; i++ ) {
				IVideoControlsComponent( array[i] ).updateStreamStatus( value );
			}
		}

		public function dispose() : void {
			var i : int;
			var n : int = controlsComponents.length;
			for ( i = 0; i < n; i++ ) {
				removeChild( controlsComponents[i] as Sprite );
				IVideoControlsComponent( controlsComponents[i] ).dispose();
				controlsComponents[i] = null;
			}
			controlsComponents.length = 0;
			observers.length = 0;

			if ( skin && contains( skin ) ) {
				removeChild( skin );
			}
			skin = null;
		}

		// ----------------------------------------------------------------------
		// GET / SET:
		// ----------------------------------------------------------------------
		
		public function setSize( width : Number, height : Number ) : void {
			videoWidth = width;
			videoHeight = height;
			updateSize();
		}

		private function updateSize() : void {
			var array : Array = observers[ ControlUpdateContext.RESIZE ] as Array;
			var i : int;
			var n : int = array.length;
			for ( i = 0; i < n; i++ ) {
				IVideoControlsComponent( array[i] ).updateSize( videoWidth, videoHeight );
			}
		}

		public function setSkin( skin : MovieClip ) : void {
			this.skin = skin;
			if ( skin ) {
				addChild( skin );
			}
		}

		// ----------------------------------------------------------------------
		// PRIVATE:
		// ----------------------------------------------------------------------
		
		private function addObserver( component : IVideoControlsComponent, contexts : Array ) : void {
			var i : int;
			var n : int = contexts.length;
			for ( i = 0; i < n; i++ ) {
				try {
					( observers[ contexts[i] ] as Array ).push( component );
				} catch( error : Error ) {
					trace( error.message );
				}
			}
		}

		private function init() : void {
			controlsComponents = [];
			observers = [];
			observers[ ControlUpdateContext.RESIZE ] = [];
			observers[ ControlUpdateContext.LOADING ] = [];
			observers[ ControlUpdateContext.TIME ] = [];
			observers[ ControlUpdateContext.STREAM_STATUS ] = [];
			observers[ ControlUpdateContext.VOLUME ] = [];
		}

	}
}

