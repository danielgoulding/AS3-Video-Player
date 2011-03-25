package com.danielgoulding.functions {

	/**
	 * addProperties
	 * add properties to object
	 */
	public function addProperties( obj:Object, props:Object ):void {
		for( var p:String in props ) {
			try{
				obj[ p ] = props[ p ];
			}
			catch( error:Error ){}
		}
	}
}
