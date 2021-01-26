package flints.common.displayobjects;

import openfl.display.Shape;
import openfl.display.BlendMode;

/**
 * The Rect class is a DisplayObject that is a rectangle shape. The 
 * registration point of this display object is in the center of the
 * rectangle.
 */

class Rect extends Shape 
{
	override public var width(get, set):Float;
	//override public var width(nmeGetWidth, nmeSetWidth):Float;
	override public var height(get, set):Float;
	public var color(get, set):Int;
	
	private var _width:Float;
	private var _height:Float;
	private var _color:Int;

	/**
	 * The constructor creates a Rect with the specified width and height.
	 * 
	 * @param width The width, in pixels, of the rectangle.
	 * @param height The height, in pixels, of the rectangle.
	 * @param color the color of the rectangle
	 * @param bm The blendMode for the rectangle
	 */
	public function new( width:Float = 1, height:Float = 1, color:Int = 0xFFFFFF, bm:Dynamic = null )
	{
		super();
		_width = width;
		_height = height;
		_color = color;
		draw();
		if (bm == null) bm = BlendMode.NORMAL;
		blendMode = bm;
	}
	
	private function draw():Void
	{
		graphics.clear();
		graphics.beginFill( _color );
		graphics.drawRect( - _width * 0.5, - _height * 0.5, _width, _height );
		graphics.endFill();
	}
	
	private function get_width():Float
	{
		return _width;
	}
	private function set_width( value:Float ):Float
	{
		_width = value;
		draw();
		return _width;
	}
	
	public function get_height():Float
	{
		return _height;
	}
	public function set_height( value:Float ):Float
	{
		_height = value;
		draw();
		return _height;
	}

	public function get_color():Int
	{
		return _color;
	}
	public function set_color( value:Int ):Int
	{
		_color = value;
		draw();
		return _color;
	}
}
