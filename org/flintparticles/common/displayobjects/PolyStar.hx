package org.flintparticles.common.displayobjects;

import openfl.display.BlendMode;
import openfl.display.Shape;

/**
 * Author: Drew Martin
 */
class PolyStar extends Shape {
	public var outerRadius(get, set):Float;
	public var innerRadius(get, set):Float;
	public var numPoints(get, set):Int;
	public var color(get, set):Int;

	private var _outerRadius:Float;
	private var _innerRadius:Float;
	private var _numPoints:Int;
	private var _color:Int;

	/**
	 * The PolyStar is a many-sided star shape.
	 *
	 * @param OuterRadius: The outer radius for the tip of the star points.
	 * @param InnerRadius: The inner radius for the base of the star points.
	 * @param NumPoints: How many points the star should have.
	 * @param Color: An optional color for the star. Defaults to white.
	 */
	public function new(outerRadius:Float, innerRadius:Float, numPoints:Int, color:Int = 0xFFFFFF) {
		super();
		this._outerRadius = outerRadius;
		this._innerRadius = innerRadius;
		this._numPoints = numPoints;
		this._color = color;
		this.blendMode = BlendMode.NORMAL;

		this.draw();
	}

	private function draw():Void {
		// Usually both are multiplied by 2 to simulate a full 360 degrees, but this works too!
		var offset:Float = Math.PI / this._numPoints;

		var radians:Float = 0;
		var x:Float;
		var y:Float;

		graphics.beginFill(this._color);
		graphics.moveTo(0, this._outerRadius);
		var i:Int = 0;
		while (i < this._numPoints) {
			radians += offset;
			x = this._innerRadius * Math.sin(radians);
			y = this._innerRadius * Math.cos(radians);
			graphics.lineTo(x, y);
			radians += offset;
			x = this._outerRadius * Math.sin(radians);
			y = this._outerRadius * Math.cos(radians);
			graphics.lineTo(x, y);
			i++;
		}
		graphics.endFill();
	}

	private function get_outerRadius():Float {
		return this._outerRadius;
	}

	private function set_outerRadius(outerRadius:Float):Float {
		if (this._outerRadius == outerRadius) {
			return outerRadius;
		}

		this._outerRadius = outerRadius;
		this.draw();
		return outerRadius;
	}

	private function get_innerRadius():Float {
		return this._innerRadius;
	}

	private function set_innerRadius(innerRadius:Float):Float {
		if (this._innerRadius == innerRadius) {
			return innerRadius;
		}

		this._innerRadius = innerRadius;
		this.draw();
		return innerRadius;
	}

	private function get_numPoints():Int {
		return this._numPoints;
	}

	private function set_numPoints(numPoints:Int):Int {
		if (this._numPoints == numPoints) {
			return numPoints;
		}

		this._numPoints = numPoints;
		this.draw();
		return numPoints;
	}

	private function get_color():Int {
		return this._color;
	}

	private function set_color(color:Int):Int {
		if (this._color == color) {
			return color;
		}

		this._color = color;
		this.draw();
		return color;
	}
}
