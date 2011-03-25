package com.danielgoulding.video.controls {

	import com.danielgoulding.video.enum.ControlUpdateContext;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class LoadingBar extends AbstractControlsComponent {
		
		protected var loadingBar : DisplayObject;
		
		protected var loadingBarLabel : String;

		private var loadingBarLength : Number;
		
		public function LoadingBar( skin : MovieClip, label:String="loading_bar_mc" ) {
			loadingBarLabel = label;
			super( skin );
		}
		
		override public function reset() : void {
			updateLoading( 0 );
		}
		
		override public function getUpdateContexts():Array{
			return [
				ControlUpdateContext.LOADING
			];
		}
		
		override public function updateLoading( value:Number ):void{
			loadingBar.width = Math.floor( value * loadingBarLength );
		}
		
		override protected function createChildren() : void {
			loadingBar = skin[ loadingBarLabel ];
			loadingBarLength = skin.width;
		}
		
		override protected function arrange() : void {
			updateLoading( 0 );
		}
		
	}
}
