/*
	Created by Jordan Leary to extend flint display objects
 */

package flints.displayobjects;

import openfl.display.Shape;
import openfl.display.BlendMode;

/**
 * The Ellipse class is a DisplayObject with a oval shape. The registration point
 * of this diaplay object is in the center of the Ellipse.
 */
class Blob extends Shape {
	public var radius(get, set):Float;

	public var color(get, set):Int;

	private var _radius:Float;
	private var _startRadius:Float;
	private var _color:Int;

	/**
	 * The constructor creates a randomly-shaped Blob with a specified target radius.
	 * @param radius The radius, in pixels, of the Blob.
	 * @param color The color of the Blob.
	 * @param bm The blendMode for the Blob.
	 */
	public function new(radius:Float = 1, color:Int = 0xFFFFFF, bm:BlendMode = BlendMode.NORMAL) {
		super();
		_radius = radius;
		_startRadius = radius;
		_color = color;
		draw();
		blendMode = bm;
	}

	private function draw():Void {
		var tanValue:Float = Math.tan(Math.PI / 8);
		var sinValue:Float = Math.sin(Math.PI / 4);

		graphics.clear();
		graphics.beginFill(_color);
		graphics.moveTo(_radius, 0);
		offsetRadius();
		graphics.curveTo(_radius, tanValue * _radius, sinValue * _radius, sinValue * _radius);
		offsetRadius();
		graphics.curveTo(tanValue * _radius, _radius, 0, _radius);
		offsetRadius();
		graphics.curveTo(-tanValue * _radius, _radius, -sinValue * _radius, sinValue * _radius);
		offsetRadius();
		graphics.curveTo(-_radius, tanValue * _radius, -_radius, 0);
		offsetRadius();
		graphics.curveTo(-_radius, -tanValue * _radius, -sinValue * _radius, -sinValue * _radius);
		offsetRadius();
		graphics.curveTo(-tanValue * _radius, -_radius, 0, -_radius);
		offsetRadius();
		graphics.curveTo(tanValue * _radius, -_radius, sinValue * _radius, -sinValue * _radius);
		_radius = _startRadius;
		graphics.curveTo(_radius, -tanValue * _radius, _radius, 0);
		graphics.endFill();
	}

	private function offsetRadius():Void {
		_radius = _startRadius + Math.random() * (_startRadius / 2) - _startRadius / 4;
	}

	private function get_radius():Float {
		return _radius;
	}

	private function set_radius(value:Float):Float {
		_radius = value;
		draw();
		return value;
	}

	private function get_color():Int {
		return _color;
	}

	private function set_color(value:Int):Int {
		_color = value;
		draw();
		return value;
	}
}
