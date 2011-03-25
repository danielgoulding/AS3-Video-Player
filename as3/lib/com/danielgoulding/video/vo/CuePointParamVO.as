package  com.danielgoulding.video.vo{

	/**
	 * @author danielgoulding
	 */
	public class CuePointParamVO {
		
		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------
		
		private var _name				: String;
		private var _value				: String;
		
		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------
		
		public function CuePointParamVO( properties:Object=null ):void {
			if ( properties )
				setProperties( properties );
		}
		
		//----------------------------------------------------------------------
		//  PUBLIC API:
		//----------------------------------------------------------------------
		
		public function setProperties( properties:Object ):void{
			if ( properties['name'] != null )
				name = properties['name'];
			
			if ( properties['value'] != null )
				value = properties['value'];
		}
		
		public function toString():String{
			return "<CuePointParamVO: name='" + name + "' value='" + value + "' />";
		}
		
		//----------------------------------------------------------------------
		//  GET / SET:
		//----------------------------------------------------------------------
		
		public function get name() : String {
			return _name;
		}
		public function set name(name : String) : void {
			_name = name;
		}
		
		public function get value() : String {
			return _value;
		}
		public function set value(value : String) : void {
			_value = value;
		}
		
	}
}
