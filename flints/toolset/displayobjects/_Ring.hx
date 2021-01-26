package flints.common.displayobjects;

import openfl.display.Shape;
import openfl.display.BlendMode;

/**
 * The Ring class is a DisplayObject with a circle shape that contains a hole. 
 * The registration point of this diaplay object is in the center of the Ring.
 */

class Ring extends Shape
{
	public var outerRadius(get, set):Float;
	public var innerRadius(get, set):Float;
	public var color(get, set):Int;
	
	private var _outerRadius:Float;
	private var _innerRadius:Float;
	private var _color:Int;

	/**
	 * The constructor creates a Ring with the specified inner and outer radius.
	 * @param inner Inner radius of the ring
	 * @param outer Outer radius of the ring
	 * @param color Color of the ring
	 * @param bm    Blend mode of the ring
	 */
	public function new( inner:Float = 1, outer:Float = 2, color:Int = 0xFFFFFF, bm:Dynamic = null )
	{
		super();
		_outerRadius = outer;
		_innerRadius = inner;
		_color = color;
		draw();
		if (bm == null) bm = BlendMode.NORMAL;
		blendMode = bm;
	}

	private function draw():Void
	{
		graphics.clear();
		graphics.beginFill( _color );
		graphics.drawCircle( 0, 0, _outerRadius );
		graphics.drawCircle( 0, 0, _innerRadius );
		graphics.endFill();
	}

	private function get_outerRadius():Float
	{
		return _outerRadius;
	}
	private function set_outerRadius( value:Float ):Float
	{
		_outerRadius = value;
		draw();
		return _outerRadius;
	}

	private function get_innerRadius():Float
	{
		return _innerRadius;
	}
	private function set_innerRadius( value:Float ):Float
	{
		_innerRadius = value;
		draw();
		return _innerRadius;
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
