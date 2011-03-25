package com.danielgoulding.functions {

	/**
	 * Return object from object array if matches attribute value
	 * @param value		: the value of attribute to be matched
	 * @param attribute	: the attribute to be used
	 * @param objArray	: the object array to search
	 * @return the object found in the array
	 */
    public function getObjectByAttribute( value:*, objArray:Array, attribute:String="id", defaultObj:Object=null ):Object{
    	var i:int;
    	var n:int = objArray.length;
    	for ( i=0; i<n; i++){
    		if ( value == objArray[ i ][ attribute ] ){
    			return objArray[ i ];
    		}
    	}
    	return defaultObj;
    }
}
