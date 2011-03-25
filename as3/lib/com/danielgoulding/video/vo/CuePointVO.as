package com.danielgoulding.video.vo {

	/**
	 * @author danielgoulding
	 */
	public class CuePointVO {
		
		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------
		
		private var _name				: String;
		private var _type				: String;
		private var _time				: Number;
		private var _parameters			: Array;
		
		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------
		
		public function CuePointVO( properties:Object=null ):void {
			if ( properties )
				setProperties( properties );
		}
		
		//----------------------------------------------------------------------
		//  PUBLIC API:
		//----------------------------------------------------------------------
		
		public function setProperties( properties:Object ):void{
			if ( properties['name'] != null )
				name = properties['name'];
			
			if ( properties['type'] != null )
				type = properties['type'];
			
			if ( properties['time'] != null )
				time = properties['time'];
			
			if ( properties['parameters'] != null )
				parameters = properties['parameters'];
		}
		
		public function toString():String{
			return "<CuePointVO: name='" + name + "' time='" + time + "' type='" + type + "' parameters='" + parameters + "' />";
		}
		
		//----------------------------------------------------------------------
		//  GET / SET:
		//----------------------------------------------------------------------
		
		public function get name() : String {
			return _name;
		}
		public function set name( value:String ) : void {
			_name = value;
		}
		
		public function get time() : Number {
			return _time;
		}
		public function set time( value:Number ) : void {
			_time = value;
		}
		
		public function get parameters() : Array {
			return _parameters;
		}
		public function set parameters( value:Array ) : void {
			_parameters = value;
		}
		
		public function get type() : String {
			return _type;
		}
		public function set type(type : String) : void {
			_type = type;
		}
	}
}
