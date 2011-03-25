package com.danielgoulding.vo {	/**	 * @author danielgoulding	 */	public class KeyVO {		// ---------------------------------------------------------------------		// VARIABLES:		// ---------------------------------------------------------------------		private var _key : Object;		private var _value : Object;		// ---------------------------------------------------------------------		// CONSTRUCTOR:		// ---------------------------------------------------------------------		public function KeyVO( properties : Object = null ) {			if ( properties ) {				setProperties( properties );			}		}		// ---------------------------------------------------------------------		// PUBLIC:		// ---------------------------------------------------------------------		public function setProperties( properties : Object ) : void {			if ( properties['key'] != null) {				key = properties['key'];			}			if ( properties['value'] != null) {				value = properties['value'];			}		}		public function toString() : String {			var output : String = "<KeyVO:";			output += getOutputString();			output += " />";			return output;		}				// ---------------------------------------------------------------------		//  PROTECTED:		// ---------------------------------------------------------------------				protected function getOutputString() : String {			var output : String = "";			output += " key='" + key + "'";			output += " value='" + value + "'";			return output;		}				// ---------------------------------------------------------------------		// GET / SET:		// ---------------------------------------------------------------------		
		public function get key() : Object {
			return _key;
		}

		public function set key( key : Object ) : void {
			_key = key;
		}

		public function get value() : Object {
			return _value;
		}

		public function set value( value : Object ) : void {
			_value = value;
		}	}}