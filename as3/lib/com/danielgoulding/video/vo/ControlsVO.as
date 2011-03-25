package com.danielgoulding.video.vo {

	/**
	 * @author danielgoulding
	 */
	public class ControlsVO {
		
		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		private var _scrubPosition				: Number;
		private var _volume						: Number;
		private var _type						: String;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function ControlsVO( params:Object=null ):void {
			if (params)
				setProperties(params);
		}
        
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		public function setProperties(params:Object):void{
			if ( params['scrubPosition'] != null )
				scrubPosition = params['scrubPosition'];
				
			if ( params['volume'] != null )
				volume = params['volume'];
				
			if ( params['type'] != null )
				type = params['type'];
		}
		
		public function toString():String{
			return "<ControlsVO: type='" + type + "' scrubPosition='" + scrubPosition + "' volume='" + volume + "' />";
		}
		
		// ---------------------------------------------------------------------
		//  GET / SET:
		// ---------------------------------------------------------------------
		
		public function get scrubPosition():Number {
			return _scrubPosition;
		}
		public function set scrubPosition( value:Number ):void {
			_scrubPosition = value;
		}
		
		public function get volume() : Number {
			return _volume;
		}
		public function set volume( value:Number ) : void {
			_volume = value;
		}

		public function get type() : String {
			return _type;
		}

		public function set type( type : String ) : void {
			_type = type;
		}
		
	}
}
