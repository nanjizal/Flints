package flints.common.displayobjects;

import openfl.display.Shape;
import openfl.display.BlendMode;
import openfl.geom.Point;

/**
 * The Star class is a DisplayObject that is the shape of a five point star. 
 * The registration point of this display object is in the middle of the star.
 */

class Star extends Shape 
{
	public var radius(get, set):Float;
	public var color(get, set):Int;
	
	private var _radius:Float;
	private var _color:Int;
	
	/**
	 * The constructor creates a Star with the specified radius.
	 * 
	 * @param radius The radius, in pixels, of the Star.
	 * @param color The color of the Star
	 * @param bm The blendMode for the Star
	 */
	public function new( radius:Float, color:Int = 0xFFFFFF, bm:Dynamic = null )
	{
		super();
		_radius = radius;
		_color = color;
		draw();
		if (bm == null) bm = BlendMode.NORMAL;
		blendMode = bm;
	}
	
	private function draw():Void
	{
		graphics.clear();
		var point:Point;
		var rotStep:Float = Math.PI / 5;
		var innerRadius:Float = _radius * Math.cos( rotStep * 2 );
		var halfPi:Float = Math.PI * 0.5;
		
		graphics.beginFill( _color );
		graphics.moveTo( 0, -_radius );
		point = Point.polar( innerRadius, rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( _radius, 2 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( innerRadius, 3 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( _radius, 4 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( innerRadius, 5 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( _radius, 6 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( innerRadius, 7 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( _radius, 8 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		point = Point.polar( innerRadius, 9 * rotStep - halfPi );
		graphics.lineTo( point.x, point.y );
		graphics.lineTo( 0, -_radius );
		graphics.endFill();
	}
	
	private function get_radius():Float
	{
		return _radius;
	}
	private function set_radius( value:Float ):Float
	{
		_radius = value;
		draw();
		return _radius;
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
