package com.danielgoulding.display {

	import com.danielgoulding.utils.GeomUtil;
	import com.danielgoulding.utils.ImageUtil;
	import com.greensock.TweenNano;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;


	/**
	 * @author danielgoulding
	 */
	public class ImageLoader extends Sprite{

		//----------------------------------------------------------------------
		//  CONSTANTS:
		//----------------------------------------------------------------------

		public static const	TOP					: String = "ImageLoader.top";
		public static const	MIDDLE				: String = "ImageLoader.middle";
		public static const	BOTTOM				: String = "ImageLoader.bottom";
		public static const	LEFT				: String = "ImageLoader.left";
		public static const	CENTER				: String = "ImageLoader.center";
		public static const	RIGHT				: String = "ImageLoader.right";

		//----------------------------------------------------------------------
		//  VARIABLES:
		//----------------------------------------------------------------------

		private var loader						: Loader;
		private var image						: Bitmap;
		private var url							: String;
		private var loaderContext				: LoaderContext;
		private var isSet						: Boolean;
		private var imageHeight					: Number;
		private var imageWidth					: Number;
		private var isSizeSet 					: Boolean;
		private var isAreaSet					: Boolean;
		private var areaHeight					: Number;
		private var areaWidth					: Number;
		private var isPositionSet				: Boolean;

		private var horizontalPosition			: String = CENTER;
		private var verticalPosition			: String = MIDDLE;

		private var isHidden : Boolean = false;

		private var isSmoothing : Boolean = true;

		//----------------------------------------------------------------------
		//  CONSTRUCTOR:
		//----------------------------------------------------------------------

		public function ImageLoader( url:String=null ):void {
			//trace( "ImageLoader: ", url );
			setURL( url );
			init();
		}

		//----------------------------------------------------------------------
		//  PUBLIC API:
		//----------------------------------------------------------------------

		public function setImage( bitmap:Bitmap ) : void {
 			image = bitmap;
 			isSet = true;
 			arrange();
 			addChild( image );
 			if ( !isHidden ){
 				show();
 			}else{
 				image.visible = false;
 			}
		}

		public function getBitmapData():BitmapData{
			return image.bitmapData;
		}

		public function loadBytes( byteData:ByteArray ) : void {
			loader.loadBytes( byteData );
		}

		public function load( url:String=null ) : void {
			if ( !url ){
				return;
			}

			setURL( url );

			try{
				loader.load( new URLRequest( url ), loaderContext );
			}catch ( error:TypeError ){
		        trace( error.message );
			}
		}

		/**
		 * Remove all references
		 */
		public function dispose():void {
			try{
				removeChild( image );
			}catch( error:Error ){}

			image = null;

			try{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				loader.unload();
				loader.close();
			}catch(error:Error){}
			loader = null;
		}

		public function position( newHorizontalPosition:String=null, newVerticalPosition:String=null ) : void {
			switch( newHorizontalPosition ){
				case LEFT:
				case RIGHT:
					horizontalPosition = newHorizontalPosition;
					break;
				case CENTER:
				default:
					newHorizontalPosition = CENTER;
					break;
			}
			switch( newVerticalPosition ){
				case TOP:
				case BOTTOM:
					verticalPosition = newVerticalPosition;
					break;
				case MIDDLE:
				default:
					verticalPosition = CENTER;
					break;
			}
		}

		public function fitArea( width:Number, height:Number ) : void {
			areaWidth = width;
			areaHeight = height;
			isAreaSet = true;
			arrange();
		}

		public function setSize( width:Number, height:Number ) : void {
			imageWidth = width;
			imageHeight = height;
			isSizeSet = true;
			arrange();
		}

		public function show( time:Number=0.5 ) : void {
			time = Math.abs( time );
			image.alpha = time == 0 ? 1 : 0;
			image.visible = true;
			TweenNano.to( image, time, { alpha:1 } );
			isHidden = false;
		}

		public function hide( time:Number=0.2 ) : void {
			time = Math.abs( time );
			isHidden = true;
			if( isSet && image ){
				TweenNano.to( image, time, { alpha:0, onComplete:function():void{ image.visible=false; } } );
			}
		}

		//----------------------------------------------------------------------
		//  GET / SET:
		//----------------------------------------------------------------------

		public function setURL( url:String ) : void {
			this.url = url;
		}

		public function getImage() : Bitmap {
			return image;
		}

		//----------------------------------------------------------------------
		//  PROTECTED:
		//----------------------------------------------------------------------

		private function arrange() : void {

			if ( !isSet ){
				return;
			}

 			if ( isSizeSet ){
				var newImage : Bitmap = ImageUtil.getResampledBitmap( image, imageWidth, imageHeight );
				image = newImage;
 				
// 				image.width = imageWidth;
// 				image.height = imageHeight;
 			}

			image.smoothing = isSmoothing;

			if ( isAreaSet ){
				GeomUtil.ResizeToArea( image, areaWidth, areaHeight );

				switch( horizontalPosition ){
					case LEFT:
						image.x = 0;
						break;
					case RIGHT:
						image.x = areaWidth - image.width;
						break;
					case CENTER:
					default:
						image.x = ( areaWidth - image.width ) / 2;
						break;
				}

				switch( verticalPosition ){
					case TOP:
						image.y = 0;
						break;
					case BOTTOM:
						image.y = areaHeight - image.height;
						break;
					case MIDDLE:
					default:
						image.y = ( areaHeight - image.height ) / 2;
						break;
				}
			}
		}

		protected function init() : void {
			createLoader();
			createLoaderContext();
			if ( url ){
				load( url );
			}
		}

		protected function createLoaderContext() : void {
			loaderContext = new LoaderContext();
			loaderContext.checkPolicyFile = true;
		}

		protected function createLoader() : void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete, false, 0, true );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onLoadError, false, 0, true );
		}

		//----------------------------------------------------------------------
		//  HANDLERS:
		//----------------------------------------------------------------------

		public function onLoadComplete( event:Event ):void {
			loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onLoadError );
 			try{
	 			setImage( LoaderInfo( event.target ).content as Bitmap );
 			}catch( error:Error ) {
 				trace( error.message );
			}
			dispatchEvent( event );
		}

		protected function onLoadError( error:IOErrorEvent ):void{
			trace( error.type, error.text );
		}

		public function setSmoothing( value : Boolean ) : void {
			isSmoothing = value;
		}

	}
}
