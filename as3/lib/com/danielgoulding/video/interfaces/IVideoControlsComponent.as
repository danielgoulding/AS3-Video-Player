package com.danielgoulding.video.interfaces {

	import com.danielgoulding.video.vo.StatusVO;
	import org.osflash.signals.Signal;

	/**
	 * @author danielgoulding
	 */
	public interface IVideoControlsComponent {

		function reset() : void;

		function getUpdateContexts():Array;

		function updateTime( time:Number, duration:Number=1 ):void;

		function updateLoading( value:Number ):void;

		function updateVolume( value:Number ):void;

		function updateStreamStatus( value:StatusVO ):void;

		function updateSize( width:Number, height:Number ):void;

		function dispose() : void;

		function setControlsEventSignal( signal : Signal ) : void;

	}
}
