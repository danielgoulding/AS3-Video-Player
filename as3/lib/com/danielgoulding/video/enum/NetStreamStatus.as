package com.danielgoulding.video.enum {

	/**
	 * @author danielgoulding
	 */
	public class NetStreamStatus {
		
		// ---------------------------------------------------------------------
		//  BUFFER STATUS:
		// ---------------------------------------------------------------------
		
		/**
		 * status
		 * Data is not being received quickly enough to fill the buffer. 
		 * Data flow is interrupted until the buffer refills, at which time 
		 * a NetStream.Buffer.Full message is sent and the stream begins playing again.
		 */
		public static const BUFFER_EMPTY				: String = "NetStream.Buffer.Empty";
		
		/**
		 * status
		 * The buffer is full and the stream begins playing.
		 */
		public static const BUFFER_FULL					: String = "NetStream.Buffer.Full";
		
		/**
		 * status
		 * Data has finished streaming, and the remaining buffer will be emptied.
		 */
		public static const BUFFER_FLUSH				: String = "NetStream.Buffer.Flush";
		
		// ---------------------------------------------------------------------
		//  WAITING STATUS:
		// ---------------------------------------------------------------------
		
		/**
		 * status
		 * Data has not been loaded to point requested and is waiting for buffer
		 * to be full before resuming 
		 */
		public static const WAITING_START				: String = "NetStream.Waiting.Start";
		
		/**
		 * status
		 * Data has been loaded to requested point
		 */
		public static const WAITING_STOP				: String = "NetStream.Waiting.Stop";
		
		// ---------------------------------------------------------------------
		//  PLAYBACK STATUS:
		// ---------------------------------------------------------------------
		
		/**
		 * status
		 * Playback has started. This information object also has a details 
		 * property, a string that provides the name of the stream currently 
		 * playing on the NetStream. If you are streaming a playlist that 
		 * contains multiple streams, this information object is sent each time 
		 * you begin playing a different stream in the playlist.
		 */
		public static const PLAY_STARTED				: String = "NetStream.Play.Start";
		
		/**
		 * status
		 * Playback has stopped. This message is sent from the server.
		 */
		public static const PLAY_STOPPED				: String = "NetStream.Play.Stop";
		
		/**
		 * status
		 * The subscriber has paused playback.
		 */
		public static const PLAY_PAUSED						: String = "NetStream.Pause.Notify";
		
		/**
		 * status
		 * The subscriber has resumed playback.
		 */
		public static const PLAY_RESUMED						: String = "NetStream.Unpause.Notify";
		
		/**
		 * status
		 * The subscriber has used the seek command to move to a particular 
		 * location in the recorded stream.
		 */
		public static const SEEK						: String = "NetStream.Seek.Notify";
		
		/**
		 * status
		 * The playlist has reset (pending play commands have been flushed).
		 */
		public static const RESET						: String = "NetStream.Play.Reset";
		
		// ---------------------------------------------------------------------
		//  PLACKBACK ERRORS:
		// ---------------------------------------------------------------------
		
		/**
		 * error
		 * The subscriber tried to use the seek command to move to a particular 
		 * location in the recorded stream, but failed.
		 */
		public static const SEEK_FAILED					: String = "NetStream.Seek.Failed";
		
		/**
		 * error
		 * Flash Player detects an invalid file structure and will not try to play 
		 * this type of file. Supported by Flash Player 9 Update 3 and later.
		 */
		public static const INVALID_FILE				: String = "NetStream.Play.FileStructureInvalid";
		
		/**
		 * error
		 * Flash Player does not detect any supported tracks (video, audio or data) 
		 * and will not try to play the file. Supported by Flash Player 9 Update 3 and later.
		 */
		public static const NO_SUPPORTED_TRACK_FOUND	: String = "NetStream.Play.NoSupportedTrackFound";
		
		/**
		 * error
		 * An error has occurred in playback for a reason other than those listed 
		 * elsewhere in this table, such as the subscriber not having read access.
		 * This information object also has a description property, which is 
		 * a string that provides a more specific reason for the failure.
		 */
		public static const PLAYBACK_FAILED				: String = "NetStream.Play.Failed";
		
		/**
		 * warning
		 * Data is playing behind the normal speed.
		 */
		public static const INSUFFICIENT_BANDWIDTH		: String = "NetSream.Play.InsufficientBW";
		
		/**
		 * error
		 * The client tried to play a live or recorded stream that does not exist.
		 */
		public static const STREAM_NOT_FOUND			: String = "NetStream.Play.StreamNotFound";
		
		// ---------------------------------------------------------------------
		//  PUBLISHING STATUS:
		// ---------------------------------------------------------------------
		
		/**
		 * status
		 * Publishing has begun; this message is sent to all subscribers.
		 */
		public static const PUBLISH_STARTED_NOTIFY		: String = "NetStream.Play.PublishNotify";
		
		/**
		 * status
		 * Publishing has stopped; this message is sent to all subscribers.
		 */
		public static const PUBLISH_STOPPED_NOTIFY		: String = "NetStream.Play.UnpublishNotify";
		
		/**
		 * error
		 * The client tried to publish a stream that is already being 
		 * published by someone else.
		 */
		public static const PUBLISH_BADNAME				: String = "NetStream.Publish.BadName";
		
		/**
		 * status
		 * The publisher of the stream has been idle for too long.
		 */
		public static const PUBLISN_IDLE				: String = "NetStream.Publish.Idle";
		
		/**
		 * status
		 * Publishing has started.
		 */
		public static const PUBLISH_START				: String = "NetStream.Publish.Start";
		
		/**
		 * status
		 * Publishing has stopped.
		 */
		public static const PUBLISH_STOPPED				: String = "NetStream.Unpublish.Success";
		
		// ---------------------------------------------------------------------
		//  RECORDING STATUS:
		// ---------------------------------------------------------------------
		
		/**
		 * error
		 * An error has occurred in recording for a reason other than those 
		 * listed elsewhere in this table; for example, the disk is full.
		 * This information object also has a description property, which is a 
		 * string that provides a more specific reason for the failure.
		 */
		public static const RECORD_FAILED				: String = "NetStream.Record.Failed";
		
		/**
		 * error
		 * The client tried to record a stream that is still playing, or the 
		 * client tried to record (overwrite) a stream that already exists on 
		 * the server with read-only status.
		 */
		public static const RECORD_NO_ACCESS			: String = "NetStream.Record.NoAccess";
		
		/**
		 * status
		 * Recording has started.
		 */
		public static const RECORD_START				: String = "NetStream.Record.Start";
		
		/**
		 * status
		 * Recording has stopped.
		 */
		public static const RECORD_STOP					: String = "NetStream.Record.Stop";
		
		// ---------------------------------------------------------------------
		//  MISCELLANEOUS STATUS:
		// ---------------------------------------------------------------------
		
		/**
		 * error
		 * An error has occurred for a reason other than those listed elsewhere 
		 * in this table, such as the subscriber trying to use the seek command 
		 * to move to a particular location in the recorded stream, but with invalid parameters.
		 */
		public static const FAILED : String = "NetStream.Failed";


		

	}
}
