package com.danielgoulding.components.button {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.Stage;	import flash.events.MouseEvent;	import flash.geom.Rectangle;	/**	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>	 */	public class Button extends Sprite{				//----------------------------------------------------------------------		//  VARIABLES:		//----------------------------------------------------------------------				protected var isEnabled						: Boolean;		protected var isSelected					: Boolean;		protected var skin							: MovieClip;		protected var ButtonStates					: Class = StandardButtonStates;		protected var currentState					: String;						//----------------------------------------------------------------------		//  CONSTRUCTOR:		//----------------------------------------------------------------------				public function Button( skin:MovieClip=null, enabled:Boolean=true, ButtonStates:Class=null ):void{			setSkin( skin );			setStatesClass( ButtonStates );			skin.mouseChildren = false;			skin.addEventListener( MouseEvent.CLICK, onClick, false, 0, true );			enable( enabled );			setDefaultState();		}				//----------------------------------------------------------------------		//  PROXY OVERRIDES:		//----------------------------------------------------------------------				override public function get x():Number{			return skin.x;		}		override public function set x( value:Number ):void{			skin.x = value;		}				override public function get alpha():Number{			return skin.alpha;		}		override public function set alpha( value:Number ):void{			skin.alpha = value;		}				override public function get stage():Stage{			return skin ? skin.stage : null;		}				override public function get y():Number{			return skin.y;		}		override public function set y( value:Number ):void{			skin.y = value;		}				override public function startDrag( lockCenter:Boolean=false, bounds:Rectangle=null ):void{			skin.startDrag( lockCenter, bounds );		}		override public function stopDrag(  ):void{			skin.stopDrag( );		}				//----------------------------------------------------------------------		//  PUBLIC API:		//----------------------------------------------------------------------				public function hide():void{			skin.visible = false;		}				public function show():void{			skin.visible = true;		}				/**		 * Set the button skin:		 */		public function setSkin( skin:MovieClip ):void{			this.skin = skin;			if( skin && !skin.parent){				addChild( skin );			}		}				/**		 * Set the button skin:		 */		public function setStatesClass( ButtonStates:Class ):void{			this.ButtonStates = ButtonStates ? ButtonStates : StandardButtonStates;		}					/**		 * Enable button		 * @param value		: Boolean		 * @return 			: void		 */		public function enable( value:Boolean=true ):void{			if ( isEnabled != value ){				isEnabled = value;				skin.buttonMode = isEnabled;				if ( isEnabled ){					addListeners();					currentState = ButtonStates.OUT;					gotoAndStop( currentState );				}else{					removeListeners();					currentState = ButtonStates.INACTIVE;					gotoAndStop( currentState );				}			}		}				/**		 * Set the selected state of the button		 * @param value		: Boolean		 * @return			: void		 */		public function setSelected( value:Boolean ):void {			isSelected = value;			currentState = isSelected ? ButtonStates.SELECTED : ButtonStates.OUT;			gotoAndPlay( currentState );		}				/**		 * Dispose of button component		 * @return			: void;		 */		public function dispose():void{			removeListeners();			removeEventListener( MouseEvent.CLICK, onClick );			if ( contains( skin ) ){				removeChild( skin );			}			skin = null;		}				//----------------------------------------------------------------------		//  PRIVATE:		//----------------------------------------------------------------------				protected function addListeners():void {			skin.addEventListener( MouseEvent.MOUSE_OVER, onOver, false, 0, true );			skin.addEventListener( MouseEvent.MOUSE_OUT, onOut, false, 0, true );			skin.addEventListener( MouseEvent.MOUSE_DOWN, onDown, false, 0, true );			skin.addEventListener( MouseEvent.MOUSE_UP, onUp, false, 0, true );		}		protected function removeListeners():void {			skin.removeEventListener( MouseEvent.MOUSE_OVER, onOver );			skin.removeEventListener( MouseEvent.MOUSE_OUT, onOut );			skin.removeEventListener( MouseEvent.MOUSE_DOWN, onDown );			skin.removeEventListener( MouseEvent.MOUSE_UP, onUp );		}				private function setDefaultState() : void {			currentState = isEnabled ? ButtonStates.OUT : ButtonStates.INACTIVE;		}				protected function gotoAndPlay( frameLabel:String ):void {			try{				skin.gotoAndPlay( frameLabel );			}catch( e:Error ){}		}				protected function gotoAndStop( frameLabel:String ):void {			try{				skin.gotoAndStop( frameLabel );			}catch( e:Error ){}		}				//----------------------------------------------------------------------		//  HANDLERS:		//----------------------------------------------------------------------				protected function onClick( event:MouseEvent ):void{			event.stopImmediatePropagation();			if ( isEnabled ){				dispatchEvent( new MouseEvent( MouseEvent.CLICK ) );			}		}				protected function onOver( event:MouseEvent ):void{			event.stopImmediatePropagation();			if ( !isSelected ){				currentState = ButtonStates.OVER;				gotoAndPlay( currentState );				dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );			}		}				protected function onDown( event:MouseEvent ):void{			event.stopImmediatePropagation();			if ( !isSelected ){				currentState = ButtonStates.DOWN;				gotoAndPlay( currentState );				dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ) );			}		}				protected function onUp( event:MouseEvent ):void{			event.stopImmediatePropagation();			if ( !isSelected ){				dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );			}		}				protected function onOut(event:MouseEvent):void{			event.stopImmediatePropagation();			if ( !isSelected ){				currentState = ButtonStates.OUT;				gotoAndPlay( currentState );				dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );			}		}			}}