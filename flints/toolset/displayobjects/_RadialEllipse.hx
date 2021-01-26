package flints.common.displayobjects;

import openfl.display.GradientType;
import openfl.display.Shape;
import openfl.geom.Matrix;

class RadialEllipse extends Shape {
	public var ellipseWidth(get, set):Float;
	public var ellipseHeight(get, set):Float;
	public var color(get, set):Int;

	private var _ellipseWidth:Float;
	private var _ellipseHeight:Float;
	private var _color:Int;

	public function new(width:Float = 1, height:Float = 1, color:Int = 0xFFFFFF, bm:String = "normal") {
		super();
		_ellipseWidth = width;
		_ellipseHeight = height;
		_color = color;
		draw();
		blendMode = bm;
	}

	private function draw():Void {
		graphics.clear();
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(_ellipseWidth, _ellipseHeight, 0, -_ellipseWidth * 0.5, -_ellipseHeight * 0.5);
		graphics.beginGradientFill(GradientType.RADIAL, [_color, _color], [0.5, 0], [0, 255], matrix);
		graphics.drawEllipse(-_ellipseWidth * 0.5, -_ellipseHeight * 0.5, _ellipseWidth, _ellipseHeight);
		graphics.endFill();
	}

	private function get_ellipseWidth():Float {
		return _ellipseWidth;
	}

	private function set_ellipseWidth(width:Float):Float {
		if (width <= 0) {
			_ellipseWidth = 1;
		} else {
			_ellipseWidth = width;
		}
		draw();
		return width;
	}

	private function get_ellipseHeight():Float {
		return _ellipseHeight;
	}

	private function set_ellipseHeight(height:Float):Float {
		if (height <= 0) {
			_ellipseHeight = 1;
		} else {
			_ellipseHeight = height;
		}
		draw();
		return height;
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
