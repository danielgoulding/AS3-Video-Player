package com.danielgoulding.utils {
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * @author danielgoulding
	 */
	public class TextFieldUtil {
		
		/**
		 * 
		 */
		public static function SequenceText( tf:TextField, copy:String, delay:Number, numChars:int ):void{
			tf.text = "";
			var repeatCount:int = Math.ceil( copy.length / numChars );
			var timer:Timer = new Timer( delay*1000, repeatCount );
			var len:int = numChars;
			tf.appendText( copy.substr( 0 , len ) );
			var onTimer:Function = function( event:TimerEvent ):void {
				var newText:String = copy.substr( timer.currentCount*len , len );
				tf.appendText( newText );
			};
			var onComplete:Function = function( event:TimerEvent ):void{
				timer = null;
			};
			timer.addEventListener( TimerEvent.TIMER, onTimer, false, 0, true );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, onComplete, false, 0, true );
			timer.start();
		}
		
		
	}
}
