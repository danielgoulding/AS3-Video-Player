package com.danielgoulding.video.controls {

	import com.danielgoulding.components.button.ButtonStatesLabels;
	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.enum.ControlsEvents;
	import com.danielgoulding.video.enum.NetStreamStatus;
	import com.danielgoulding.video.vo.ControlsVO;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class PauseButton extends AbstractControlsButton {

		public function PauseButton( skin : MovieClip, enabled : Boolean = true, labels : ButtonStatesLabels = null ) {
			super( skin, enabled, labels );
		}
		
		override public function getUpdateContexts():Array{
			return [
				ControlUpdateContext.STREAM_STATUS
			];
		}
		
		override public function reset() : void {
			enable( false );
		}
		
		override public function updateStreamStatus( status:StatusVO ):void{
			switch( status.code ){
				case NetStreamStatus.PLAY_STARTED:
				case NetStreamStatus.PLAY_RESUMED:
					enable( true );
					break;
				case NetStreamStatus.PLAY_STOPPED:
				case NetStreamStatus.PLAY_PAUSED:
					enable( false );
					break;
			}
		}
		
		override protected function dispatchSignal() : void {
			controlsEventSignal.dispatch( new ControlsVO( { type:ControlsEvents.PAUSE } ) );
		}
		
	}
}
