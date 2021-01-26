package flints.displayobjects;

import openfl.display.Shape;

class Boomerang extends Shape {
    public var size(get, set):Float;
    public var color(get, set):Int;

    public function new(size:Float, color:Int = 0xFFFFFF) {
        super();
        _size = size;
        _color = color;
        draw();
    }
    
    public function draw():Void {
        graphics.clear();
        graphics.beginFill(color);
        graphics.cubicCurveTo(_size * .15, -_size * .9, _size * .85, -_size * .9, _size, 0);
        graphics.cubicCurveTo(_size * .85, -_size * .4, _size * .15, -_size * .4, 0, 0);
        graphics.endFill();
    }
    
    private function get_size():Float {
        return _size;
    }
    
    private function set_size(value:Float):Float {
        _size = value;
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
    
    private var _size:Float;
    private var _color:Int;
}
