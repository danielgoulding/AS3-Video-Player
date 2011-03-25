package com.danielgoulding.video.vo {

	/**
	 * @author danielgoulding
	 */
	public class StatusVO {
		
		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------
		
		private var _level				: String;
		private var _code				: String;
		private var _description		: String;
		private var _details			: String;
		
		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------
		
		public function StatusVO( params:Object=null ):void {
			if ( params )
				setProperties( params );
		}
		
		//----------------------------------------------------------------------
		//  PUBLIC API:
		//----------------------------------------------------------------------
		
		public function setProperties( properties:Object ):void{
			if ( properties['level'] != null )
				level = properties['level'];
			
			if ( properties['code'] != null )
				code = properties['code'];
			
			if ( properties['description'] != null )
				description = properties['description'];
			
			if ( properties['details'] != null )
				details = properties['details'];
		}
		
		public function toString():String{
			return "<StatusVO: code='" + code + "' level='" + level + "' description='" + description + "' details='" + details + "' />";
		}
		
		//----------------------------------------------------------------------
		//  GET / SET:
		//----------------------------------------------------------------------
		
		public function get level() : String {
			return _level;
		}
		public function set level( value:String ) : void {
			_level = value;
		}
		
		public function get code() : String {
			return _code;
		}
		public function set code( value:String ) : void {
			_code = value;
		}

		public function get description() : String {
			return _description;
		}

		public function set description( description : String ) : void {
			_description = description;
		}

		public function get details() : String {
			return _details;
		}

		public function set details( details : String ) : void {
			_details = details;
		}
		
	}
}
