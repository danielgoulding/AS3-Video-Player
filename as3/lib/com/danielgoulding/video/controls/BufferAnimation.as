package com.danielgoulding.video.controls {

	import com.danielgoulding.utils.DrawUtil;
	import com.danielgoulding.video.enum.ControlUpdateContext;
	import com.danielgoulding.video.enum.NetStreamStatus;
	import com.danielgoulding.video.vo.StatusVO;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;


	/**
	 * @author Daniel Goulding <daniel.goulding@yeahlove.co.uk>
	 */
	public class BufferAnimation extends AbstractControlsComponent {
		
		// ---------------------------------------------------------------------
		//  VARIABLES:
		// ---------------------------------------------------------------------
		
		protected var background : Sprite;

		private var isSizeSet : Boolean;

		private var isShowing : Boolean;
		
		// ---------------------------------------------------------------------
		//  CONSTRUCTOR:
		// ---------------------------------------------------------------------
		
		public function BufferAnimation( skin : MovieClip ) {
			super( skin );
		}
		
		// ---------------------------------------------------------------------
		//  PUBLIC:
		// ---------------------------------------------------------------------
		
		public function hide():void{
			isShowing = false;
			TweenLite.to( skin, 0.3, { alpha:0, onComplete:function():void{ skin.visible = false; } } );
			TweenLite.to( background, 0.3, { alpha:0, onComplete:function():void{ background.visible = false; } } );
		}

		public function show():void{
			isShowing = true;
			showSkin();
			showBackground();
		}
		
		override public function reset():void{
			hide();
		}
		
		override public function getUpdateContexts():Array{
			return [
				ControlUpdateContext.STREAM_STATUS,
				ControlUpdateContext.RESIZE
			];
		}
		
		override public function updateSize( width:Number, height:Number ):void{
			background.width = width;
			background.height = height;
			isSizeSet = true;
			if ( isShowing && !background.visible ){
				showBackground();
			}
		}

		override public function updateStreamStatus( status:StatusVO ):void{
			switch( status.code ){
				case NetStreamStatus.BUFFER_EMPTY:
				case NetStreamStatus.WAITING_START:
				case NetStreamStatus.PLAY_STARTED:
					show();
					break;
				case NetStreamStatus.BUFFER_FULL:
				case NetStreamStatus.PLAY_STOPPED:
				case NetStreamStatus.WAITING_STOP:
					hide();
					break;
			}
		}

		override public function dispose() : void {
			removeChild( background );
			background = null;
			if ( skin.parent ){
				skin.parent.removeChild( skin );
			}
			skin = null;
		}
		
		// ---------------------------------------------------------------------
		//  PROTECTED:
		// ---------------------------------------------------------------------
		
		protected function showSkin() : void {
			skin.visible = true;
			TweenLite.to( skin, 0.3, { alpha:1 } );
		}

		protected function showBackground() : void {
			background.visible = isSizeSet;
			TweenLite.to( background, 0.3, { alpha:1 } );
		}
		
		override protected function createChildren() : void {
			createBackground();
		}

		protected function createBackground() : void {
			background = new Sprite();
			background.addChild( DrawUtil.Rectangle( 0x000000, 100, 100, 0.5 ) );
			addChildAt( background, 0 );
		}

		override protected function arrange() : void {
			skin.visible = true;
			background.visible = false;
			skin.alpha = 0;
			background.alpha = 0;
		}

	}
}
