package com.danielgoulding.video.controls {

	import com.danielgoulding.components.button.Button;
	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.enum.ControlsEvents;
	import com.danielgoulding.video.enum.NetStreamStatus;
	import com.danielgoulding.video.vo.ControlsVO;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class ScrubbingBar extends AbstractControlsComponent {
		
		// ---------------------------------------------------------------------
		//  CONSTANTS:
		// ---------------------------------------------------------------------
		
		protected static const SCRUB_INTERVAL : Number = 20;
		
		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		protected var scrubber : Button;
		
		protected var scrubberLabel : String;

		protected var scrubberLength : Number;

		protected var scrubberWidth : Number;

		protected var isScrubbing : Boolean;
		
		protected var timer : Timer;

		private var isWaiting : Boolean;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function ScrubbingBar( skin : MovieClip, width:Number, label:String="scrubber_mc" ) {
			scrubberWidth = width;
			scrubberLabel = label;
			super( skin );
		}
		
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		override public function reset() : void {
			updateTime( 0 );
			scrubber.enable( false );
		}
		
		override public function updateTime( time:Number, duration:Number=1 ):void{
			if ( isScrubbing || isWaiting ){
				return;
			}
			scrubber.x = ( time/duration ) * scrubberLength;
		}
		
		override public function getUpdateContexts():Array{
			return [ 
				ControlUpdateContext.TIME, 
				ControlUpdateContext.STREAM_STATUS
			];
		}
		
		override public function updateStreamStatus( value : StatusVO ) : void {
			switch( value.code ) {
				case NetStreamStatus.PLAY_STARTED:
					scrubber.enable();
					isWaiting = false;
					break;
				case NetStreamStatus.WAITING_START:
					isWaiting = true;
					break;
				case NetStreamStatus.WAITING_STOP:
				case NetStreamStatus.BUFFER_FULL:
				case NetStreamStatus.PLAY_RESUMED:
					isWaiting = false;
					break;
			}
		}
		
		public function getScrubPosition() : Number {
			return scrubber.x / scrubberLength;
		}
		
		// ---------------------------------------------------------------------
		//  PROTECTED:
		// ---------------------------------------------------------------------
		
		override protected function createChildren() : void {
			createScrubber();
			createTimer();
		}

		private function createScrubber() : void {
			scrubber = new Button( skin[ scrubberLabel ] );
			scrubber.addEventListener( MouseEvent.MOUSE_DOWN, onScrubberDown, false, 0, true );
			scrubber.addEventListener( MouseEvent.MOUSE_UP, onScrubberUp, false, 0, true );
			scrubberLength = skin.width - scrubberWidth;
		}

		private function createTimer() : void {
			timer = new Timer( SCRUB_INTERVAL );
			timer.addEventListener( TimerEvent.TIMER, onTimer, false, 0, true );
		}
		
		override protected function arrange() : void {
			updateTime( 0 );
		}
		
		// ---------------------------------------------------------------------
		//  HANDLERS:
		// ---------------------------------------------------------------------
		
		private function onTimer( event : TimerEvent ) : void {
			controlsEventSignal.dispatch( new ControlsVO( { type:ControlsEvents.SCRUB_UPDATE, scrubPosition:getScrubPosition() } ) );
		}

		private function onScrubberDown( event : MouseEvent ) : void {
			scrubber.addEventListener( MouseEvent.MOUSE_UP, onScrubberUp, false, 0, true );
			scrubber.stage.addEventListener( MouseEvent.MOUSE_UP, onScrubberUp, false, 0, true );
			scrubber.startDrag( false, new Rectangle( 0, scrubber.y, scrubberLength, 0 ) );
			timer.start();
			isScrubbing = true;
			controlsEventSignal.dispatch( new ControlsVO( { type:ControlsEvents.START_SCRUB, scrubPosition:getScrubPosition() } ) );
		}

		private function onScrubberUp( event : MouseEvent ) : void {
			isScrubbing = false;
			scrubber.removeEventListener( MouseEvent.MOUSE_UP, onScrubberUp );
			scrubber.stage.removeEventListener( MouseEvent.MOUSE_UP, onScrubberUp );
			scrubber.stopDrag();
			timer.stop();
			controlsEventSignal.dispatch( new ControlsVO( { type:ControlsEvents.STOP_SCRUB, scrubPosition:getScrubPosition() } ) );
		}
		
	}
}