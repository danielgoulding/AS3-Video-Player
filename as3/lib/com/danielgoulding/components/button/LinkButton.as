package com.danielgoulding.components.button {
	import com.danielgoulding.vo.LinkVO;
	import flash.display.MovieClip;


	/**
	 * @author danielgoulding
	 */
	public class LinkButton extends LabelButton {

		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------

		public var linkVO						: LinkVO;

		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------

		public function LinkButton( skin:MovieClip, lVO:LinkVO, labelContainerName:String=null, enabled:Boolean=true ):void{
			super( skin, labelContainerName, enabled );
			linkVO = lVO;
			setLabel( linkVO.title );
		}

	}
}
