package com.danielgoulding.components.button {
	import flash.display.MovieClip;
	import flash.text.TextField;


	/**
	 * @author danielgoulding
	 */
	public class LabelButton extends Button{

		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------

		protected var textfield				: TextField;
		protected var label					: MovieClip;

		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------

		public function LabelButton( skin:MovieClip, labelContainerName:String=null, enabled:Boolean=true ):void{
			super( skin, enabled );
			labelContainerName = labelContainerName ? labelContainerName : "label_mc";
			label = skin[ labelContainerName ];
			textfield = label['tf'];
		}

		//----------------------------------------------------------------------
		//  PUBLIC:
		//----------------------------------------------------------------------

		public function setLabel( value:String ):void{
			textfield.htmlText = value;
		}

		public function setLabelPosition( x:Number, y:Number ):void{
			label.x = x;
			label.y = y;
		}

	}
}
