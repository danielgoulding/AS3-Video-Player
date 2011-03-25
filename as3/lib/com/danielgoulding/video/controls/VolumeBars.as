package com.danielgoulding.video.controls {

	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.enum.ControlsEvents;
	import com.danielgoulding.video.vo.ControlsVO;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class VolumeBars extends AbstractControlsComponent {
		
		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		protected var volumeIndicator : MovieClip;

		protected var volumeBarLabel : String;

		private var isVertical : Boolean;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function VolumeBars( skin : MovieClip, isVertical : Boolean = false, label : String = 'volume_bar_mc' ) {
			this.isVertical = isVertical;
			volumeBarLabel = label;
			super( skin );
		}
		
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		override public function getUpdateContexts() : Array {
			return [ ControlUpdateContext.VOLUME ];
		}

		override public function updateVolume( value : Number ) : void {
			var obj : Object = isVertical ? { height:( value * skin.height ) } : { width:( value * skin.width ) };
			TweenLite.to( volumeIndicator, 0.3, obj );
		}
		
		override public function dispose() : void {
			volumeIndicator = null;
			removeEventListener( MouseEvent.CLICK, onClicked );
		}
		
		// ---------------------------------------------------------------------
		//  PROTECTED:
		// ---------------------------------------------------------------------
		
		override protected function createChildren() : void {
			volumeIndicator = skin[ volumeBarLabel ];
			mouseChildren = false;
			buttonMode = true;
			addEventListener( MouseEvent.CLICK, onClicked );
		}

		protected function getVolumeLevel() : Number {
			return isVertical ? skin.mouseY / skin.height : skin.mouseX / skin.width;
		}
		
		// ---------------------------------------------------------------------
		// HANDLERS:
		// ---------------------------------------------------------------------
		
		private function onClicked( event : MouseEvent ) : void {
			controlsEventSignal.dispatch( new ControlsVO( { type:ControlsEvents.SET_VOLUME, volume:getVolumeLevel() } ) );
		}

	}
}
