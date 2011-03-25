package com.danielgoulding.video {

	import com.danielgoulding.functions.addProperties;
	import com.danielgoulding.video.clients.AbstractNetStreamClient;
	import com.danielgoulding.video.clients.NetStreamClient;
	import com.danielgoulding.video.vo.AsyncErrorVO;
	import com.danielgoulding.video.vo.CuePointVO;
	import com.danielgoulding.video.vo.StatusVO;
	import com.danielgoulding.video.vo.VideoMetaDataVO;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import org.osflash.signals.Signal;



	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class VideoDisplay extends Sprite {

		// ----------------------------------------------------------------------
		// CONSTANTS:
		// ----------------------------------------------------------------------
		
		public static const DEFAULT_VOLUME : Number = 0.6;

		// ----------------------------------------------------------------------
		// VARIABLES:
		// ----------------------------------------------------------------------
		
		protected var video : Video;

		protected var netStream : NetStream;

		protected var netConnection : NetConnection;

		protected var videoPath : String;

		protected var videoWidth : Number;

		protected var videoHeight : Number;

		protected var volume : Number = DEFAULT_VOLUME;
		
		protected var bufferTime : Number;

		protected var smoothing : Boolean = true;
		
		protected var isLoading : Boolean;

		protected var isInit : Boolean;
		
		protected var isSizeSet : Boolean;
		
		protected var netStreamClient : AbstractNetStreamClient = new NetStreamClient();
		
		public var metaDataVO : VideoMetaDataVO;

		public var isStarted : Boolean;

		public var isPaused : Boolean;
		
		// ----------------------------------------------------------------------
		// SIGNALS:
		// ----------------------------------------------------------------------
		
		public var lastSecondSignal : Signal = new Signal( Object );
		
		public var netConnectionStatusSignal : Signal = new Signal( StatusVO );
		
		public var netStreamStatusSignal : Signal = new Signal( StatusVO );
		
		public var asyncErrorSignal : Signal = new Signal( AsyncErrorVO );
		
		public var sizeSignal : Signal = new Signal( Number, Number );
		
		public var cuePointSignal : Signal = new Signal( CuePointVO );
		
		public var imageDataSignal : Signal = new Signal( Object );
		
		public var playStatusSignal : Signal = new Signal( Object );
		
		public var seekPointSignal : Signal = new Signal( Object );
		
		public var textDataSignal : Signal = new Signal( Object );
		
		public var xmpDataSignal : Signal = new Signal( Object );
		
		// ----------------------------------------------------------------------
		// CONSTRUCTOR:
		// ----------------------------------------------------------------------
		
		public function VideoDisplay( autoInit:Boolean=true ) {
			if ( autoInit ) init();
		}

		// ---------------------------------------------------------------------
		// PUBLIC API:
		// ---------------------------------------------------------------------
		
		public function init() : void {
			if ( isInit ){
				return;
			}
			createNetConnection();
			createNetStream();
			createVideo();
			addNetStreamListeners();
			setInitialProperties();
			isInit = true;
		}

		public function play() : void {
			if ( !isStarted ){
				start();
			}
			if ( isPaused ) {
				netStream.resume();
				isPaused = false;
			}
		}

		public function pause() : void {
			if ( isPaused ) {
				return;
			}
			netStream.pause();
			isPaused = true;
		}

		public function seek( value : Number ) : void {
			netStream.seek( value );
		}

		public function load() : void {
			if ( isStarted ) {
				return;
			}
			isLoading = true;
			start();
			// TODO: 
		}

		public function dispose() : void {
			disposeVideo();
			disposeNetConnection();
			disposeNetStream();
			metaDataVO = null;
		}

		public function setVideoPath( value : String ) : void {
			videoPath = value;
			reset();
		}

		public function setSize( width : Number, height : Number ) : void {
			videoWidth = width;
			videoHeight = height;
			isSizeSet = true;
			setVideoSize();
		}
		
		public function setVolume( value : Number ) : void {
			volume = value;
			setNetStreamVolume();
		}

		public function setSmoothing( value : Boolean ) : void {
			smoothing = value;
			setVideoSmoothing();
		}

		public function setBufferTime( value : Number ) : void {
			bufferTime = value;
			setNetStreamBufferTime();
		}
		
		public function setClient( client : AbstractNetStreamClient ) : void {
			netStreamClient = client;
			setNetStreamClient();
		}
		
		public function setMetaData( metaDataObject : Object ) : void {
			addProperties( metaDataVO, metaDataObject );
			if ( !isSizeSet ){
				sizeSignal.dispatch( metaDataVO.width, metaDataVO.height );
			}
		}
		
		// ---------------------------------------------------------------------
		//  GET / SET:
		// ---------------------------------------------------------------------
		
		public function get percentLoaded() : Number {
			return netStream ? netStream.bytesLoaded / netStream.bytesTotal : 0;
		}

		public function get playheadTime():Number{
			return netStream ? netStream.time : 0;
		}
		
		public function get bufferLength() : Number {
			return netStream.bufferLength;
		}
		
		// ---------------------------------------------------------------------
		//  PROTECTED:
		// ---------------------------------------------------------------------
		
		protected function reset():void{
			dispose();
			isLoading = false;
			isInit = false;
			isStarted = false;
			isPaused = false;
			init();
		}
		
		protected function start() : void {
			if ( isStarted ){
				return;
			}
			netStream.play( videoPath );
			isStarted = true;
		}
		
		protected function setInitialProperties() : void {
			setNetStreamVolume();
			setNetStreamBufferTime();
			setNetStreamClient();
			setVideoSmoothing();
			setVideoSize();
			metaDataVO = new VideoMetaDataVO();
		}
		
		protected function setVideoSize() : void {
			if ( !video ){
				return;
			}
			video.width = videoWidth;
			video.height = videoHeight;
		}
		
		protected function setVideoSmoothing() : void {
			if ( !video ){
				return;
			}
			video.smoothing = smoothing;
		}
		
		protected function setNetStreamBufferTime() : void {
			if ( !netStream ){
				return;
			}
			netStream.bufferTime = bufferTime;
		}
		
		protected function setNetStreamVolume() : void {
			if ( !netStream ){
				return;
			}
			netStream.soundTransform = new SoundTransform( volume );
		}
		
		protected function setNetStreamClient() : void {
			if ( !netStream ){
				return;
			}
			netStreamClient.setVideoDisplay( this );
			netStream.client = netStreamClient;
		}
		
		// ---------------------------------------------------------------------
		//  DISPOSAL:
		// ---------------------------------------------------------------------
		
		protected function disposeVideo():void{
			if ( !video ){
				return;
			}
			if ( contains( video ) ){
				removeChild( video );
			}
			video.attachNetStream( null );
			video = null;
		}

		protected function disposeNetStream():void{
			if ( !netStream ){
				return;
			}
			if ( netStream.hasEventListener( NetStatusEvent.NET_STATUS ) ){
				netStream.removeEventListener( NetStatusEvent.NET_STATUS, onNetStreamStatus );
			}
			if ( netStream.hasEventListener( AsyncErrorEvent.ASYNC_ERROR ) ){
				netStream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsyncError );
			}
			netStream.close();
			netStream = null;
		}

		protected function disposeNetConnection():void{
			if ( !netConnection ){
				return;
			}
			if ( netConnection.hasEventListener( NetStatusEvent.NET_STATUS ) ){
				netConnection.removeEventListener( NetStatusEvent.NET_STATUS, onNetConnectionStatus );
			}
			netConnection.close();
			netConnection = null;
		}
		
		// ---------------------------------------------------------------------
		//  ASSET CREATION:
		// ---------------------------------------------------------------------
		
		protected function createNetConnection() : void {
			netConnection = new NetConnection();
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, onNetConnectionStatus, false, 0, true );
			netConnection.connect( null );
		}

		protected function createNetStream() : void {
			netStream = new NetStream( netConnection );
		}

		protected function addNetStreamListeners() : void {
			netStream.addEventListener( NetStatusEvent.NET_STATUS, onNetStreamStatus, false, 0, true );
			netStream.addEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsyncError, false, 0, true );
		}

		protected function createVideo() : void {
			video = new Video();
			video.attachNetStream( netStream );
			addChild( video );
		}
		
		// ---------------------------------------------------------------------
		//  HANDLERS:
		// ---------------------------------------------------------------------
		
		public function onNetConnectionStatus( event : NetStatusEvent ) : void {
			netConnectionStatusSignal.dispatch( new StatusVO( event.info ) );
		}

		public function onNetStreamStatus( event : NetStatusEvent ) : void {
			netStreamStatusSignal.dispatch( new StatusVO( event.info ) );
		}

		protected function onAsyncError( event : AsyncErrorEvent ) : void {
			asyncErrorSignal.dispatch( new AsyncErrorVO( { error:event.error, text:event.text } ) );
		}

	}
}
