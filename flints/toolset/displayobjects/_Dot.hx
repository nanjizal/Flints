package flints.common.displayobjects;

//import openfl.display.Shape;
//import openfl.display.BlendMode;

/**
 * The Dot class is a DisplayObject with a circle shape. The registration point
 * of this diaplay object is in the center of the Dot.
 */

class Dot extends Shape 
{
	public var radius(get, set):Float;
	public var color(get, set):Int;
	
	private var _radius:Float;
	private var _color:Int;
	
	/**
	 * The constructor creates a Dot with a specified radius.
	 * @param radius The radius, in pixels, of the Dot.
	 * @param color The color of the Dot.
	 * @param bm The blendMode for the Dot.
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
		graphics.beginFill( _color );
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