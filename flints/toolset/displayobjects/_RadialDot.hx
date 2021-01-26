package flints.common.displayobjects;

import openfl.display.GradientType;
import openfl.display.Shape;
import openfl.geom.Matrix;
import openfl.display.BlendMode;

/**
 * The RadialDot class is a DisplayObject that is a circle shape with a gradient 
 * fill that fades to transparency at the edge of the dot. The registration point
 * of this diaplay object is in the center of the Dot.
 */

class RadialDot extends Shape 
{
	public var radius(get, set):Float;
	public var color(get, set):Int;
	
	private var _radius:Float;
	private var _color:Int;
	
	/**
	 * The constructor creates a RadialDot with the  specified radius.
	 * 
	 * @param radius The radius, in pixels, of the RadialDot.
	 * @param color The color of the RadialDot
	 * @param bm The blendMode of the RadialDot
	 */
	public function new( radius:Float = 1, color:Int = 0xFFFFFF, bm:Dynamic = null )
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
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox( _radius * 2, _radius * 2, 0, -_radius, -_radius );
		graphics.beginGradientFill( GradientType.RADIAL, [_color,_color], [1,0], [0,255], matrix );
		graphics.drawCircle( 0, 0, _radius );
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
