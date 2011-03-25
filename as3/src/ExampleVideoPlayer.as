package {

	import com.danielgoulding.video.VideoPlayer;
	import com.danielgoulding.video.controls.BufferAnimation;
	import com.danielgoulding.video.controls.ImagePlaceholder;
	import com.danielgoulding.video.controls.LoadingBar;
	import com.danielgoulding.video.controls.PlayPauseButton;
	import com.danielgoulding.video.controls.ProgressBar;
	import com.danielgoulding.video.controls.ScrubbingBar;
	import com.danielgoulding.video.controls.VolumeBars;
	import flash.display.MovieClip;
	import video_controls_fla.pausebutton_4;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	[SWF(backgroundColor="#000000", frameRate="31", width="613", height="395")]
	public class ExampleVideoPlayer extends MovieClip {

		// ---------------------------------------------------------------------
		//  DIVIDER:
		// ---------------------------------------------------------------------
		
		private var videoPlayer : VideoPlayer;

		private var imagepath : String = "http://danielgoulding.co.uk/testing/images/nikefullmoon.jpg";

		private var videopath : String = "http://danielgoulding.co.uk/testing/video/nikefullmoon.mp4";

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		public function ExampleVideoPlayer() {
			setFlashVars();
			createVideoPlayer();
			
		}

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		private function setFlashVars() : void {
			if ( loaderInfo.parameters['imagepath'] ){
				imagepath = loaderInfo.parameters['imagepath'];
			}
			if ( loaderInfo.parameters['videopath'] ){
				videopath = loaderInfo.parameters['videopath'];
			}
		}

		private function createVideoPlayer() : void {
			var skin : video_controls = new video_controls();
			videoPlayer = new VideoPlayer( skin );
			
			videoPlayer.addControlComponent( new ImagePlaceholder( imagepath ) );
			videoPlayer.addControlComponent( new BufferAnimation( skin.buffer_mc ) );
			videoPlayer.addControlComponent( new PlayPauseButton( skin.play_pause_mc ) );
			videoPlayer.addControlComponent( new LoadingBar( skin.loading_bar_mc ) );
			videoPlayer.addControlComponent( new ProgressBar( skin.progress_bar_mc ) );
			videoPlayer.addControlComponent( new ScrubbingBar( skin.scrubbing_bar_mc, 10 ) );
			videoPlayer.addControlComponent( new VolumeBars( skin.volume_controls_mc ) );
			
			videoPlayer.setVolume( 0.6 );
			videoPlayer.setBufferTime( 5 );
			videoPlayer.setSize( 613, 345 );
			//videoPlayer.setBorderWidth( 1 );
			
			videoPlayer.setVideoPath( videopath );
			addChild( videoPlayer );
		}

	}
}
