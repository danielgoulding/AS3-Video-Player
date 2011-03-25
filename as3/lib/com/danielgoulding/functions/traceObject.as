package com.danielgoulding.functions {

	/**
	 * traceObject
	 * trace object to string
	 *  @author danielgoulding
	 */
	public function traceObject( object:Object, prefix:String="" ):void{
		for ( var p:String in object ){
			if ( typeof( object[p] ) == "object" ){
				trace( prefix + p + ": [Object]");
				traceObject( Object( object[p] ), prefix + "	" );
			}else{
				trace( prefix + p + ": " + object[p] );
			}
		}
	}
}
