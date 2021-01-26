package flints.common.displayobjects;

import openfl.display.BlendMode;
import openfl.display.Shape;

/**
 * The LineShape class is a DisplayObject with a simple line shape. The line is
 * horizontal and the registration point of this display object is in the center
 * of the line.
 */

class Line extends Shape
{
	public var length(get, set):Float;
	public var color(get, set):Int;
	
	private var _length:Float;
	private var _color:Int;
	
	/**
	 * The constructor creates a Line with the specified length.
	 * 
	 * @param lineLength The length, in pixels, of the line.
	 * @param color the color of the Line
	 * @param bm The blendMode for the Line
	 */
	public function new( lineLength : Float = 1, color:Int = 0xFFFFFF, bm:Dynamic = null )
	{
		super();
		_length = lineLength;
		_color = color;
		draw();
		if (bm == null) bm = BlendMode.NORMAL;
		blendMode = bm;
	}
	
	private function draw():Void
	{
		graphics.clear();
		graphics.lineStyle( 1, _color );
		graphics.moveTo( -_length * 0.5, 0 );
		graphics.lineTo( _length * 0.5, 0 );
	}
	
	private function get_length():Float
	{
		return _length;
	}
	private function set_length( value:Float ):Float
	{
		_length = value;
		draw();
		return _length;
	}
	
	private function get_color():Int
	{
		return _color;
	}
	private function set_color( value:Int ):Int
	{
		_color = value;
		draw();
		return _color;
	}
}
