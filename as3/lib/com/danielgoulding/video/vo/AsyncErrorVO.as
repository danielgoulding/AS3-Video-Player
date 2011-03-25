package com.danielgoulding.video.vo {

	/**
	 * @author danielgoulding
	 */
	public class AsyncErrorVO {
		
		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------
		
		private var _error				: String;
		private var _text				: String;
		
		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------
		
		public function AsyncErrorVO( params:Object=null ):void {
			if ( params )
				setProperties( params );
		}
		
		//----------------------------------------------------------------------
		//  PUBLIC API:
		//----------------------------------------------------------------------
		
		public function setProperties( properties:Object ):void{
			if ( properties['error'] != null )
				error = properties['error'];
			
			if ( properties['text'] != null )
				text = properties['text'];
		}
		
		public function toString():String{
			return "<AsyncErrorVO: error='" + error + "' text='" + text + "' />";
		}
		
		//----------------------------------------------------------------------
		//  GET / SET:
		//----------------------------------------------------------------------
		
		public function get error() : String {
			return _error;
		}
		public function set error(error : String) : void {
			_error = error;
		}
		
		public function get text() : String {
			return _text;
		}
		public function set text(text : String) : void {
			_text = text;
		}
	}
}
