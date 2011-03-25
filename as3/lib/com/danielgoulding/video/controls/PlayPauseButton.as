package com.danielgoulding.video.controls {

	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.enum.NetStreamStatus;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;
	import org.osflash.signals.Signal;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class PlayPauseButton extends AbstractControlsComponent {
		
		// ---------------------------------------------------------------------
		//  DIVIDER:
		// ---------------------------------------------------------------------
		
		protected var pauseButton : AbstractControlsButton;

		protected var playButton : AbstractControlsButton;
		
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		override public function setControlsEventSignal( signal : Signal ) : void {
			super.setControlsEventSignal( signal );
			playButton.setControlsEventSignal( signal );
			pauseButton.setControlsEventSignal( signal );
		}
		
		public function PlayPauseButton( skin : MovieClip ) {
			super( skin );
		}
		
		override public function reset() : void {
			playButton.show();
			pauseButton.hide();
			playButton.enable();
			pauseButton.enable( false );
		}
		
		override public function getUpdateContexts():Array{
			return [
				ControlUpdateContext.STREAM_STATUS
			];
		}
		
		override public function updateStreamStatus( status : StatusVO ) : void {
			playButton.updateStreamStatus( status );
			pauseButton.updateStreamStatus( status );
			
			switch( status.code ){

				case NetStreamStatus.PLAY_STARTED:
				case NetStreamStatus.PLAY_RESUMED:
				case NetStreamStatus.BUFFER_EMPTY:
					playButton.hide();
					pauseButton.show();
					break;

				case NetStreamStatus.PLAY_STOPPED:
				case NetStreamStatus.PLAY_PAUSED:
					playButton.show();
					pauseButton.hide();
					break;
			}
		}
		
		// ---------------------------------------------------------------------
		//  PROTECTED:
		// ---------------------------------------------------------------------
		
		
		override protected function createChildren() : void {
			createPlayButton();
			createPauseButton();
		}

		private function createPlayButton() : void {
			playButton = new PlayButton( skin['play_mc'] );
			playButton.x = skin.x;
			playButton.y = skin.y;
			addChild( playButton );
		}

		private function createPauseButton() : void {
			pauseButton = new PauseButton( skin['pause_mc'] );
			pauseButton.x = skin.x;
			pauseButton.y = skin.y;
			addChild( pauseButton );
		}
		
		override protected function arrange() : void {
			playButton.show();
			pauseButton.hide();
		}
		
	}
}
