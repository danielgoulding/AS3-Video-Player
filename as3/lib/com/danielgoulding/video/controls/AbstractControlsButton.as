package com.danielgoulding.video.controls {

	import com.danielgoulding.components.button.ButtonStatesLabels;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;



	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class AbstractControlsButton extends AbstractControlsComponent {

		// ----------------------------------------------------------------------
		// VARIABLES:
		// ----------------------------------------------------------------------
		protected var isEnabled : Boolean;

		protected var isSelected : Boolean;

		protected var currentState : String;
		
		protected var buttonStatesLabels : ButtonStatesLabels = new ButtonStatesLabels();
		
		public var clicked : Signal = new Signal();
		
		// ----------------------------------------------------------------------
		// CONSTRUCTOR:
		// ----------------------------------------------------------------------
		public function AbstractControlsButton( skin:MovieClip=null, enabled:Boolean=true, labels:ButtonStatesLabels=null ):void{
			super( skin );
			if ( labels != null ) setButtonLabels( labels );
			init();
			enable( enabled );
			setDefaultState();
			skin.mouseChildren = false;
			skin.addEventListener( MouseEvent.CLICK, onClick, false, 0, true );
		}
		
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		/**
		 * Set the button labels:
		 */
		public function setButtonLabels( labels : ButtonStatesLabels ) : void {
			buttonStatesLabels = labels;
		}
		
		public function hide():void{
			skin.visible = false;
		}
		
		public function show():void{
			skin.visible = true;
		}
			
		/**
		 * Enable button
		 * @param value		: Boolean
		 * @return 			: void
		 */
		public function enable( value:Boolean=true ):void{
			if ( isEnabled != value ){
				isEnabled = value;
				skin.buttonMode = isEnabled;
				if ( isEnabled ){
					addListeners();
					currentState = buttonStatesLabels.out;
					skin.gotoAndStop( currentState );
				}else{
					removeListeners();
					currentState = buttonStatesLabels.inactive;
					skin.gotoAndStop( currentState );
				}
			}
		}
		
		/**
		 * Set the selected state of the button
		 * @param value		: Boolean
		 * @return			: void
		 */
		public function setSelected( value:Boolean ):void {
			isSelected = value;
			currentState = isSelected ? buttonStatesLabels.selected : buttonStatesLabels.out;
			skin.gotoAndPlay( currentState );
		}
		
		/**
		 * Dispose of button component
		 * @return			: void;
		 */
		override public function dispose():void{
			removeListeners();
			removeEventListener( MouseEvent.CLICK, onClick );
			if ( contains( skin ) ){
				removeChild( skin );
			}
			skin = null;
		}
		
		//----------------------------------------------------------------------
		//  PRIVATE:
		//----------------------------------------------------------------------
		
		protected function addListeners():void {
			skin.addEventListener( MouseEvent.MOUSE_OVER, onOver, false, 0, true );
			skin.addEventListener( MouseEvent.MOUSE_OUT, onOut, false, 0, true );
			skin.addEventListener( MouseEvent.MOUSE_DOWN, onDown, false, 0, true );
			skin.addEventListener( MouseEvent.MOUSE_UP, onUp, false, 0, true );
		}

		protected function removeListeners():void {
			skin.removeEventListener( MouseEvent.MOUSE_OVER, onOver );
			skin.removeEventListener( MouseEvent.MOUSE_OUT, onOut );
			skin.removeEventListener( MouseEvent.MOUSE_DOWN, onDown );
			skin.removeEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function setDefaultState() : void {
			currentState = isEnabled ? buttonStatesLabels.out : buttonStatesLabels.inactive;
		}
		
		//----------------------------------------------------------------------
		//  HANDLERS:
		//----------------------------------------------------------------------
		
		protected function onClick( event:MouseEvent ):void{
			event.stopImmediatePropagation();
			if ( isEnabled ){
				dispatchSignal();
			}
		}
		
		protected function onOver( event:MouseEvent ):void{
			event.stopImmediatePropagation();
			if ( !isSelected ) {
				currentState = buttonStatesLabels.over;
				skin.gotoAndStop( currentState );
			}
		}
		
		protected function onDown( event:MouseEvent ):void{
			event.stopImmediatePropagation();
			if ( !isSelected ) {
				currentState = buttonStatesLabels.down;
				skin.gotoAndPlay( currentState );
			}
		}
		
		protected function onUp( event:MouseEvent ):void{
			event.stopImmediatePropagation();
		}
		
		protected function onOut(event:MouseEvent):void{
			event.stopImmediatePropagation();
			if ( !isSelected ) {
				currentState = buttonStatesLabels.out;
				skin.gotoAndPlay( currentState );
			}
		}
		
	}
}
