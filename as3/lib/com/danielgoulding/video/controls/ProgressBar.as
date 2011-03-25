package com.danielgoulding.video.controls {

	import com.danielgoulding.video.enum.ControlUpdateContext;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class ProgressBar extends AbstractControlsComponent {
		
		protected var progressBar : DisplayObject;
		
		protected var progressBarLabel : String;

		private var progressBarLength : Number;
		
		public function ProgressBar( skin : MovieClip, label:String="progress_bar_mc" ) {
			progressBarLabel = label;
			super( skin );
		}
		
		override public function reset() : void {
			updateTime( 0 );
		}
		
		override public function getUpdateContexts():Array{
			return [ 
				ControlUpdateContext.TIME
			];
		}
		
		override public function updateTime( time:Number, duration:Number=1 ):void{
			progressBar.width = ( time/duration ) * progressBarLength;
		}
		
		override protected function createChildren() : void {
			progressBar = skin[ progressBarLabel ];
			progressBarLength = skin.width;
		}
		
		override protected function arrange() : void {
			updateTime( 0 );
		}
		
	}
}
