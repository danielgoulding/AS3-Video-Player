package com.danielgoulding.video.interfaces {

	import com.danielgoulding.video.VideoDisplay;

	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public interface INetStreamClient {

		function setVideoDisplay( display : VideoDisplay ) : void;

		function onCuePoint( data : Object ) : void;

		function onImageData( data : Object ) : void;

		function onMetaData( data : Object ) : void;

		function onPlayStatus( data : Object ) : void;

		function onSeekPoint( data : Object ) : void;

		function onTextData( data : Object ) : void;

		function onXMPData( data : Object ) : void;
	}
}
