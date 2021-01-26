package flints.displayobjects;

//import openfl.display.Shape;

/**
	 * Author: Drew Martin
	 */
class Droplet extends Shape {
    public var radius(get, set):Float;
    public var color(get, set):Int;

    private var _radius:Float;
    private var _color:Int;
    
    public function new(radius:Float = 1, color:Int = 0xFFFFFF, bm:String = "normal") {
        super();
        _radius = radius;
        _color = color;
        draw();
        blendMode = bm;
    }
    
    private function draw():Void {
        graphics.clear();
        graphics.beginFill(_color);
        graphics.moveTo(0, _radius);
        
        /**
			 * All (_radius * 3)'s could be replaced with a different variable. This value
			 * determines how long the droplet "tail" should be.
			 */
        
        //Front "C" Curve
        graphics.curveTo(_radius, _radius, _radius, 0);
        graphics.curveTo(_radius, -_radius, 0, -_radius);
        
        //Top "S" Curve
        graphics.curveTo(-(_radius * 3) * 0.5, -_radius, -(_radius * 3), -_radius * 0.5);
        graphics.curveTo(-(_radius * 3) * 1.5, 0, -(_radius * 3) * 2, 0);
        
        //Bottom "S" Curve
        graphics.curveTo(-(_radius * 3) * 1.5, 0, -(_radius * 3), _radius * 0.5);
        graphics.curveTo(-(_radius * 3) * 0.5, _radius, 0, _radius);
        
        graphics.lineTo(0, _radius);
        graphics.endFill();
    }
    
    private function get_radius():Float {
        return _radius;
    }
    private function set_radius(radius:Float):Float {
        _radius = radius;
        draw();
        return radius;
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
