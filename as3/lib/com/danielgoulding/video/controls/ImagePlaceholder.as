package com.danielgoulding.video.controls {

	import com.danielgoulding.display.ImageLoader;
	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.enum.NetStreamStatus;
	import com.danielgoulding.video.vo.StatusVO;
	import flash.display.MovieClip;
	
	/**
	 * @author danielgoulding
	 */
	public class ImagePlaceholder extends AbstractControlsComponent{
		
		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------
		
		private var imagePath					: String;
		private var imageLoader					: ImageLoader;
		private var isStarted					: Boolean;

		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------
		
		public function ImagePlaceholder( imagePath:String ):void {
			this.imagePath = imagePath;
			super( new MovieClip() );
		}
		
		//----------------------------------------------------------------------
		//  PUBLIC API:
		//----------------------------------------------------------------------
		
		override public function reset() : void {
			
		}
		
		override public function getUpdateContexts():Array{
			return [
				ControlUpdateContext.STREAM_STATUS,
				ControlUpdateContext.RESIZE
			];
		}
		
		override public function updateStreamStatus( status : StatusVO ) : void {
			trace( status .code );
			switch( status.code ){
				case NetStreamStatus.BUFFER_FULL:
					imageLoader.hide();
					
					if ( !isStarted ){
						isStarted = true;
						trace("hide");
					}
					break;
				case NetStreamStatus.PLAY_STOPPED:
					imageLoader.show();
						trace("show");
					
					break;
			}
		}
		
		override public function updateSize( width : Number, height : Number ) : void {
			trace( "set size ", width, height );
			imageLoader.setSize( width, height );
		}
		
		
		override public function dispose():void{
			imagePath = null;
			imageLoader.dispose();
		}
		
		//----------------------------------------------------------------------
		//  GET / SET:
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//  PRIVATE:
		//----------------------------------------------------------------------
		
		override protected function createChildren() : void {
			imageLoader = new ImageLoader( imagePath );
			addChild( imageLoader );
		}
		
		//----------------------------------------------------------------------
		//  HANDLERS:
		//----------------------------------------------------------------------
		
	}
}
