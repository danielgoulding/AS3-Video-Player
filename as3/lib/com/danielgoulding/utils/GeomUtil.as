package com.danielgoulding.utils {
	import flash.display.DisplayObject;

	/**
	 * @author danielgoulding
	 */
	public class GeomUtil {
		
		public static const	TOP					: String = "ImageLoader.top";
		public static const	MIDDLE				: String = "ImageLoader.middle";
		public static const	BOTTOM				: String = "ImageLoader.bottom";
		public static const	LEFT				: String = "ImageLoader.left";
		public static const	CENTER				: String = "ImageLoader.center";
		public static const	RIGHT				: String = "ImageLoader.right";
		
		/**
		 * ResizeToArea
		 * resize object (with width & height properties) to fit within new width and height
		 * @param obj			: the object to resize
		 * @param newWidth		: the new width to fit into
		 * @param newHeight		: the new height to fit into
		 * @return				: the resized aspect ratio
		 */
		public static function ResizeToArea( obj:*, newWidth:Number, newHeight:Number ):Number{
			var objWidth:Number = obj['width'];
			var objHeight:Number = obj['height'];
			var objAspectRatio:Number = objWidth / objHeight;
			var areaAspectRatio:Number = newWidth / newHeight;
			var resizeRatio:Number;
			if ( objAspectRatio >= areaAspectRatio ){
				resizeRatio = newWidth / objWidth;
			}
			else {
				resizeRatio = newHeight / objHeight;
			}
			obj['width'] = objWidth * resizeRatio;
			obj['height'] = objHeight * resizeRatio;
			
			return resizeRatio;
		}
		
		
		/**
		 * Align
		 * Align display object with another element ( with width & height properties )
		 * @param obj			: the object to resize
		 * @param newWidth		: the new width to fit into
		 * @param newHeight		: the new height to fit into
		 */
		public static function Align( alignObj:DisplayObject, alignToObj:Object,  verticalAlignment:String=null, horizontalAlignment:String=null ):void{
			if ( 
				!( 
					( alignToObj['width'] != null ) && 
					( alignToObj['height'] != null ) && 
					( alignToObj['x'] != null ) && 
					( alignToObj['y'] != null ) 
				)
			){
				return;
			}
			
			switch( horizontalAlignment ){
				case LEFT:
					alignObj.x = alignToObj['x'];
					break;
				case RIGHT:
					alignObj.x = alignToObj['x'] + alignToObj['width'] - alignObj.width;
					break;
				case CENTER:
				default:
					alignObj.x = alignToObj['x'] + ( alignToObj['width'] - alignObj.width ) / 2;
					break;
			}
			
			switch( verticalAlignment ){
				case TOP:
					alignObj.y = alignToObj['y'];
					break;
				case BOTTOM:
					alignObj.y = alignToObj['y'] + alignToObj['height'] - alignObj['height'];
					break;
				case MIDDLE:
				default:
					alignObj.y = alignToObj['y'] + ( alignToObj['height'] - alignObj.height ) / 2;
					break;
			}
		}
		
	}
}
