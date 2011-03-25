package {

	import com.danielgoulding.display.SkinnableDisplay;
	import com.danielgoulding.utils.ArrayUtil;
	import com.danielgoulding.utils.DrawUtil;
	import com.danielgoulding.video.VideoPlayer;
	import com.danielgoulding.video.controls.BufferAnimation;
	import com.danielgoulding.video.controls.LoadingBar;
	import com.danielgoulding.video.controls.PlayButton;
	import com.danielgoulding.video.controls.PlayPauseButton;
	import com.danielgoulding.video.controls.ProgressBar;
	import com.danielgoulding.video.controls.ScrubbingBar;
	import com.danielgoulding.video.controls.VolumeBars;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	/**
	 * @author danielgoulding <daniel.goulding@yeahlove.co.uk>
	 */
	[SWF(backgroundColor="#000000", frameRate="31", width="469", height="335")]
	public class Main extends MovieClip {

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		private const VIDEO_PATH : String = "http://marcsylvan.yeahlove.co.uk/video/";
		
		// ---------------------------------------------------------------------
		//  DIVIDER:
		// ---------------------------------------------------------------------
		
		private var videoPlayer : VideoPlayer;

		private var button : SkinnableDisplay;

		private var videos : Array = [ "58_playingnervousrant_066a.mp4", "57_amberloungeabudhabi_beeb.mp4", "47_segarallyrevo_aae6.mp4", "36_nikaiwillnever_8b2f.mp4", "31_rollosdream_21d9.mp4" ];

		private var videoIndex : int = 0;

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		public function Main() {
			createVideoPlayer();
			createButton();
		}

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		private function createVideoPlayer() : void {
			var skin : MovieClip = new video_controls();
			videoPlayer = new VideoPlayer( skin );
			
			videoPlayer.addControlComponent( new BufferAnimation( skin['buffer_mc'] ) );
			videoPlayer.addControlComponent( new PlayPauseButton( skin['play_pause_mc'] ) );
			videoPlayer.addControlComponent( new LoadingBar( skin['loading_bar_mc'] ) );
			videoPlayer.addControlComponent( new ProgressBar( skin['progress_bar_mc'] ) );
			videoPlayer.addControlComponent( new ScrubbingBar( skin['scrubbing_bar_mc'], 10 ) );
			videoPlayer.addControlComponent( new VolumeBars( skin['volume_controls_mc'] ) );
			
			videoPlayer.setVolume( 0.1 );
			videoPlayer.setBufferTime( 5 );
			videoPlayer.setSize( 469, 265 );
			videoPlayer.setBorderWidth( 1 );
			
			videoPlayer.y = 21;
			setVideoPath();
			addChild( videoPlayer );
		}

		private function createButton() : void {
			button = new SkinnableDisplay( DrawUtil.Rectangle( 0x555555, 469, 20 ) );
			button.buttonMode = true;
			button.addEventListener( MouseEvent.CLICK, onClick );
			addChild( button );
		}

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		private function setVideoPath() : void {
			videoPlayer.setVideoPath( VIDEO_PATH + videos[ videoIndex ] );
		}

		// ---------------------------------------------------------------------
		// DIVIDER:
		// ---------------------------------------------------------------------
		
		private function onClick( event : MouseEvent ) : void {
			videoIndex = ArrayUtil.LimitIndex( ++videoIndex, videos );
			setVideoPath();
		}
	}
}