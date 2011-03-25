package com.danielgoulding.utils {
	import flash.display.Shape;
	import flash.geom.Point;

	/**
	 * @author danielgoulding
	 */
	public class DrawUtil {
		
		/**
		 * Draws a rectangle
		 * 
		 * @param color		: the rectangle fill color
		 * @param width		: the rectangle width
		 * @param height	: the rectangle height
		 * @param alpha		: the rectangle alpha
		 * @return Shape
		 * @example 
		 * 			var rectangle:Shape = DrawUtil.Rectangle( 0xFF0000, 200, 300 );
		 */
		public static function Rectangle( color:uint=0x000000, width:Number=100, height:Number=100, alpha:Number=1 ):Shape{
			var rectangle:Shape = new Shape();
			rectangle.graphics.beginFill( color );
			rectangle.graphics.drawRect(0, 0, width, height);
			rectangle.graphics.endFill();
			rectangle.alpha = alpha;
			return rectangle;
		}
		
		/**
		 * Draws a square
		 * 
		 * @param color		: the rectangle fill color
		 * @param size		: the square size
		 * @return Shape
		 * @example 
		 * 			var square:Shape = DrawUtil.Square( 0xFF0000, 200 );
		 */
		public static function Square( color:uint=0x000000, size:Number=100 ):Shape{
			return Rectangle( color, size, size );
		}
		
		/**
		 * Draws a straight line
		 * @param start		: the start point
		 * @param finsh		: the finish point
		 * @param thickness	: the linr thickness
		 * @param color		: the line color
		 * @param alpha		: the line alpha
		 * @example 
		 * 			var line:Shape = DrawUtil.Line( new Point( 0, 0 ),  new Point( 100, 100 ) );
		 */
		public static function Line( start:Point, finsh:Point, thickness:Number=1, color:uint=0x000000, alpha:Number=1 ):Shape{
			var target:Shape = new Shape();
			target.graphics.lineStyle( thickness, color, alpha );
			target.graphics.moveTo( start.x, start.y);
			target.graphics.lineTo( finsh.x, finsh.y );
			return target;
		}
		
		/**
		 * Draws a curved line
		 * @param start		: the start point
		 * @param control	: the curve control point
		 * @param finsh		: the finish point
		 * @param thickness	: the linr thickness
		 * @param color		: the line color
		 * @param alpha		: the line alpha
		 * @example 
		 * 			var line:Shape = DrawUtil.CurvedLine( new Point( 0, 0 ),  new Point( 100, 100 ),  new Point( 200, 0 ) );
		 */
		public static function CurvedLine( start:Point, control:Point, finsh:Point, thickness:Number=1, color:uint=0x000000, alpha:Number=1 ):Shape{
			var target:Shape = new Shape();
			target.graphics.lineStyle( thickness, color, alpha );
			target.graphics.moveTo( start.x, start.y);
			target.graphics.curveTo( control.x, control.y, finsh.x, finsh.y );
			return target;
		}
		
	}
}
