package com.danielgoulding.functions {
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;

	/**
	 * getMovieClip
	 * Get movieClip from Library
	 */
	public function getMovieClip( name:String, domain:ApplicationDomain=null ):MovieClip {
		var TypeClass:Class = domain ? domain.getDefinition( name ) as Class : getDefinitionByName( name ) as Class;
		return new TypeClass() as MovieClip;
	}
}
