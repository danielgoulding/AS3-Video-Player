package com.danielgoulding.video {

	import com.danielgoulding.utils.MathUtil;
	import com.danielgoulding.video.enum.ControlsEvents;
	import com.danielgoulding.video.enum.NetStreamStatus;
	import com.danielgoulding.video.interfaces.IVideoControlsComponent;
	import com.danielgoulding.video.vo.AsyncErrorVO;
	import com.danielgoulding.video.vo.ControlsVO;
	import com.danielgoulding.video.vo.CuePointVO;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class VideoPlayer extends Sprite {
		
		// ---------------------------------------------------------------------
		//  CONSTANTS:
		// ---------------------------------------------------------------------
		
		public static const TIMER_INTERVAL : Number = 50;

		public static const DEFAULT_BUFFER_TIME : Number = 2;

		// ---------------------------------------------------------------------
		// VARIABLES:
		// ---------------------------------------------------------------------
		
		protected var videoDisplayContainer : Sprite;
		
		protected var videoDisplay : VideoDisplay;

		protected var videoControls : VideoControls;

		protected var controlsSkin : MovieClip;

		protected var isInit : Boolean;

		protected var isAutoRewind : Boolean = true;
		
		protected var useManualCuePoints : Boolean;

		protected var manualCuePoints : Array = [];
		
		protected var timer : Timer;

		protected var scrubPosition : Number;

		protected var bufferTime : Number = DEFAULT_BUFFER_TIME;
		
		protected var borderWidth : Number = 0;
		
		protected var isScrubbing : Boolean;

		protected var isScrubPaused : Boolean;

		protected var isWaiting : Boolean;
		
		// ---------------------------------------------------------------------
		// SIGNALS:
		// ---------------------------------------------------------------------
		
		public var lastSecondSignal : Signal = new Signal( Object );
		
		public var netConnectionStatusSignal : Signal = new Signal( StatusVO );
		
		public var netStreamStatusSignal : Signal = new Signal( StatusVO );
		
		public var asyncErrorSignal : Signal = new Signal( AsyncErrorVO );
		
		public var cuePointSignal : Signal = new Signal( CuePointVO );

		public var imageDataSignal : Signal = new Signal( Object );
		
		public var metaDataSignal : Signal = new Signal( Object );
		
		public var playStatusSignal : Signal = new Signal( Object );
		
		public var seekPointSignal : Signal = new Signal( Object );
		
		public var textDataSignal : Signal = new Signal( Object );
		
		public var xmpDataSignal : Signal = new Signal( Object );

		// ---------------------------------------------------------------------
		// CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function VideoPlayer( controlsSkin:MovieClip = null, autoInit:Boolean=true ) {
			setControlsSkin( controlsSkin );
			if ( autoInit ) init();
		}

		// ---------------------------------------------------------------------
		// PUBLIC API:
		// ---------------------------------------------------------------------
		
		/**
		 * initialize VideoPlayer
		 * @return : void
		 */
		public function init() : void {
			if ( isInit ){
				return;
			}
			createVideoDisplay();
			createVideoControls();
			createTimer();
			isInit = true;
		}

		/**
		 * pause video
		 * @return : void
		 */
		public function pause() : void {
			videoDisplay.pause();
			videoControls.netStreamStatusSignal.dispatch( new StatusVO( { code:NetStreamStatus.PLAY_PAUSED } ) );
		}

		/**
		 * play video
		 * @return : void
		 */
		public function play() : void {
			videoDisplay.play();
			videoControls.netStreamStatusSignal.dispatch( new StatusVO( { code:NetStreamStatus.PLAY_RESUMED } ) );
			if ( !timer.running ) {
				timer.start();
				startWaiting();
			}
		}

		/**
		 * Load video ( without playing )
		 * @return : void
		 */
		public function load() : void {
			videoDisplay.load();
		}

		/**
		 * seek
		 * @param value : the time to seek to in seconds
		 * @return : void
		 */
		public function seek( value : Number ) : void {
			videoDisplay.seek( value );
		}

		/**
		 * addCuePoint:
		 * @param cuePointVO : CuePoint value object
		 * @return : void
		 */
		public function addCuePoint( cuePointVO : CuePointVO ) : void {
			useManualCuePoints = true;
			manualCuePoints.push( cuePointVO );
		}

		/**
		 * addControlComponent
		 * @param component : the video controls component 
		 * @param childIndex : the child index of the component
		 * @return : void
		 */
		public function addControlComponent( component : IVideoControlsComponent, childIndex : int = -1 ) : void {
			videoControls.addControlComponent( component, childIndex );
		}

		/**
		 * dispose of VideoPlayer
		 * @return : void
		 */
		public function dispose() : void {
			disposeVideoDisplay();
			disposeVideoControls();
			disposeTimer();
			manualCuePoints = null;
		}

		// ---------------------------------------------------------------------
		// SET VIDEO PROPERTIES:
		// ---------------------------------------------------------------------
		
		/**
		 * setControlsSkin:
		 * @param controlsSkin : video controls skin
		 * @return : void
		 */
		public function setControlsSkin( movieClip : MovieClip = null ) : void {
			controlsSkin = movieClip;
		}

		/**
		 * setVideoPath
		 * Set path of video file:
		 * @param value : the path to the video
		 * @return : void
		 */
		public function setVideoPath( value : String ) : void {
			videoDisplay.setVideoPath( value );
			videoControls.reset();
		}

		/**
		 * setBorderWidth
		 * Mask edges of video - to eliminate borders/erroneaous lines
		 * @param value : the border width to hide
		 * @return : void
		 */
		public function setBorderWidth( value : Number ) : void {
			var originalWidth:Number = videoDisplay.width - borderWidth * 2;
			var originalHeight:Number = videoDisplay.height - borderWidth * 2;
			borderWidth = value;
			videoDisplay.width = originalWidth + borderWidth * 2;
			videoDisplay.height = originalHeight + borderWidth * 2;
			videoDisplay.x = -borderWidth;
			videoDisplay.y = -borderWidth;
			videoDisplayContainer.scrollRect = new Rectangle( 0, 0, originalWidth, originalHeight );
		}

		/**
		 * setSize
		 * Set video dimensions:
		 * @param height	: height of video
		 * @param width		: width of video
		 * @return : void
		 */
		public function setSize( width : Number, height : Number ) : void {
			videoDisplay.setSize( width, height );
			videoControls.setSize( width, height );
		}

		/**
		 * setAutoRewind
		 * Set auto-rewind value
		 * @param value : auto-rewind value (Boolean)
		 * @return : void
		 */
		public function setAutoRewind( value : Boolean = true ) : void {
			isAutoRewind = value;
		}

		/**
		 * Set volume of stream
		 * @param value : volume (0-1)
		 * @return : void
		 */
		public function setVolume( value : Number ) : void {
			videoDisplay.setVolume( value );
			videoControls.updateVolume( value );
		}

		/**
		 * setSmoothing
		 * Set video smoothing
		 * @param value : smoothing true or false
		 * @return : void
		 */
		public function setSmoothing( value : Boolean ) : void {
			videoDisplay.setSmoothing( value );
		}

		/**
		 * setBufferTime
		 * Set net stream buffer time
		 * @param value : buffer time
		 * @return : void
		 */
		public function setBufferTime( value : Number ) : void {
			bufferTime = value;
			videoDisplay.setBufferTime( bufferTime );
		}
		
		// ---------------------------------------------------------------------
		// PROTECTED:
		// ---------------------------------------------------------------------
		
		protected function dispatchManualCuePoints() : void {
			if ( !useManualCuePoints ) {
				return;
			}
			var i:int;
			var n:int = manualCuePoints.length;
			var timeNow : Number = videoDisplay.playheadTime;
			var timePrevious:Number = timeNow - TIMER_INTERVAL/1000;
			var cuePointTime:Number;
			for ( i=0; i<n; i++ ) {
				cuePointTime = CuePointVO( manualCuePoints[i] ).time;
				if( timeNow >= cuePointTime && timePrevious < cuePointTime ){
					cuePointSignal.dispatch( CuePointVO( manualCuePoints[i] ) );
				}
			}
		}
		
		protected function startScrub() : void {
			isScrubbing = true;
			if ( !videoDisplay.isPaused ){
				videoDisplay.pause();
				isScrubPaused = true;
			}
		}

		protected function updateScrub( scrubPos : Number ) : void {
			scrubPosition = scrubPos;
			seek( scrubPosition * videoDisplay.metaDataVO.duration );
		}

		protected function stopScrub( scrubPos:Number ) : void {
			scrubPosition = scrubPos;
			isScrubbing = false;
			seek( scrubPosition * videoDisplay.metaDataVO.duration );
			if ( isScrubPaused ){
				videoDisplay.play();
				isScrubPaused = false;
			}
			startWaiting();
		}
		
		protected function startWaiting() : void {
			isWaiting = true;
			videoControls.updateStreamStatus( new StatusVO( { code:NetStreamStatus.WAITING_START } ) );
		}
		
		protected function stopWaiting() : void {
			isWaiting = false;
			videoControls.updateStreamStatus( new StatusVO( { code:NetStreamStatus.WAITING_STOP } ) );
		}
		
		protected function isBuffered() : Boolean {
			var duration:Number = videoDisplay.metaDataVO.duration;
			var scrubTime:Number = scrubPosition * duration;
			var activeBufferTime : Number = MathUtil.Clamp( duration-scrubTime, 0, bufferTime );
			return ( videoDisplay.bufferLength > activeBufferTime );
		}
		
		// ---------------------------------------------------------------------
		//  ASSET CREATION:
		// ---------------------------------------------------------------------
		
		protected function createTimer():void{
			timer = new Timer( TIMER_INTERVAL );
			timer.addEventListener( TimerEvent.TIMER, onTimer, false, 0, true );
		}
		
		protected function createVideoDisplay() : void {
			videoDisplayContainer = new Sprite();
			addChild( videoDisplayContainer );
			
			videoDisplay = new VideoDisplay();
			videoDisplay.setBufferTime( bufferTime );
			videoDisplay.lastSecondSignal = lastSecondSignal;
			videoDisplay.netConnectionStatusSignal = netConnectionStatusSignal;
			videoDisplay.netStreamStatusSignal = netStreamStatusSignal;
			videoDisplay.asyncErrorSignal = asyncErrorSignal;
			videoDisplay.cuePointSignal = cuePointSignal;
			videoDisplay.imageDataSignal = imageDataSignal;
			videoDisplay.playStatusSignal = playStatusSignal;
			videoDisplay.seekPointSignal = seekPointSignal;
			videoDisplay.textDataSignal = textDataSignal;
			videoDisplay.xmpDataSignal = xmpDataSignal;
			videoDisplay.sizeSignal.add( setSize );
			netStreamStatusSignal.add( onNetStreamStatus );
			videoDisplayContainer.addChild( videoDisplay );
		}

		protected function createVideoControls() : void {
			videoControls = new VideoControls( controlsSkin );
			videoControls.controlsEventSignal.add( onControlsEvent );
			videoControls.setNetStreamStatusSignal( netStreamStatusSignal );
			addChild( videoControls );
		}

		// ---------------------------------------------------------------------
		//  DISPOSAL:
		// ---------------------------------------------------------------------
		
		protected function disposeTimer() : void {
			if ( !timer ){
				return;
			}
			if ( timer.hasEventListener( TimerEvent.TIMER ) ) {
				timer.removeEventListener( TimerEvent.TIMER, onTimer );
			}
			timer.stop();
			timer = null;
		}
		
		protected function disposeVideoDisplay() : void {
			if ( !videoDisplay ){
				return;
			}
			if ( videoDisplayContainer.contains( videoDisplay ) ) {
				videoDisplayContainer.removeChild( videoDisplay );
			}
			videoDisplay.dispose();
			videoDisplay = null;
		}

		protected function disposeVideoControls() : void {
			if ( !videoControls ){
				return;
			}
			if ( contains( videoControls ) ){
				removeChild( videoControls );
			}
			videoControls.dispose();
			videoControls = null;
		}
		
		// ---------------------------------------------------------------------
		//  HANDLERS:
		// ---------------------------------------------------------------------
		
		protected function onTimer( event : TimerEvent ) : void {
			if ( !videoDisplay.metaDataVO.duration ){
				return;
			}
			   
			// update controls loading:
			videoControls.updateLoading( videoDisplay.percentLoaded );
			
			// update controls playhead time:
			var time:Number = ( isScrubbing || isWaiting ) ? scrubPosition * videoDisplay.metaDataVO.duration : videoDisplay.playheadTime;
			videoControls.updatePlayhead( time, videoDisplay.metaDataVO.duration );
			
			// check for manual cuepoints:
			dispatchManualCuePoints();
			
			// stop waiting if buffered:
			if ( isWaiting && isBuffered() ) {
				stopWaiting();
			}
		}

		protected function onNetStreamStatus( status : StatusVO ) : void {
			//trace( status.code );
			switch( status.code ){
				case NetStreamStatus.PLAY_STOPPED:
					pause();
					if( isAutoRewind ) seek( 0 );
					break;
				case NetStreamStatus.BUFFER_FULL:
					isWaiting = false;
					break;
				default:
			}
		}
		
		protected function onControlsEvent( controlsVO:ControlsVO ) : void {
			switch( controlsVO.type ){
				case ControlsEvents.PLAY:
				case ControlsEvents.PLAY_AGAIN:
					play();
					break;
				case ControlsEvents.PAUSE:
					pause();
					break;
				case ControlsEvents.REWIND:
					seek( 0 );
					break;
				case ControlsEvents.START_SCRUB:
					startScrub();
					break;
				case ControlsEvents.SCRUB_UPDATE:
					updateScrub( controlsVO.scrubPosition );
					break;
				case ControlsEvents.STOP_SCRUB:
					stopScrub( controlsVO.scrubPosition );
					break;
				case ControlsEvents.SET_VOLUME:
					setVolume( controlsVO.volume );
					break;
			}
		}
		
	}
}
