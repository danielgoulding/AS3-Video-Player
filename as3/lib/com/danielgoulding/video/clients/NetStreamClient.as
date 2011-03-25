package com.danielgoulding.video.clients {

	import com.danielgoulding.video.vo.CuePointVO;

	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class NetStreamClient extends AbstractNetStreamClient {

		public function NetStreamClient() {}

		override public function onMetaData( metaDataObject : Object ) : void {
			videoDisplay.setMetaData( metaDataObject );
		}

		override public function onCuePoint( cuePointObject : Object ) : void {
			videoDisplay.cuePointSignal.dispatch( new CuePointVO( cuePointObject ) );
		}
		
	}
}
