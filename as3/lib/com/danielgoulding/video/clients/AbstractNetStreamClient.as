package com.danielgoulding.video.clients {

	import com.danielgoulding.video.VideoDisplay;
	import com.danielgoulding.video.interfaces.INetStreamClient;

	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class AbstractNetStreamClient extends Object implements INetStreamClient {
		
		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		protected var videoDisplay : VideoDisplay;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function AbstractNetStreamClient() {
		}
		
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		public function setVideoDisplay( display : VideoDisplay ) : void {
			videoDisplay = display;
		}
		
		public function onCuePoint( data : Object ) : void {
		}

		public function onImageData( data : Object ) : void {
		}

		public function onMetaData( data : Object ) : void {
		}

		public function onPlayStatus( data : Object ) : void {
		}

		public function onSeekPoint( data : Object ) : void {
		}

		public function onTextData( data : Object ) : void {
		}

		public function onXMPData( data : Object ) : void {
		}
	}
}
