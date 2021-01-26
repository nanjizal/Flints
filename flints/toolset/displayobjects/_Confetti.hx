package flints.common.displayobjects;

import openfl.display.Shape;

/**
	 * The Rect class is a DisplayObject that is a rectangle shape. The 
	 * registration point of this display object is in the center of the
	 * rectangle.
	 */
class Confetti extends Shape {
    public var size(get, set):Float;
    public var color(get, set):Int;

    private var _size:Float;
    private var _color:Int;
    
    /**
		 * The constructor creates a Rect with the specified width and height.
		 * 
		 * @param width The width, in pixels, of the rectangle.
		 * @param height The height, in pixels, of the rectangle.
		 * @param color the color of the rectangle
		 * @param bm The blendMode for the rectangle
		 */
    public function new(size:Float, color:Int = 0xFFFFFF) {
        super();
        _size = size;
        _color = color;
        draw();
    }
    
    private function draw():Void {
        graphics.clear();
        graphics.beginFill(this._color);
        
        graphics.moveTo(-_size * .34, -_size * .18);
        graphics.lineTo(-_size * .16, -_size * .56);
        graphics.lineTo(_size * .37, _size * .4);
        graphics.lineTo(_size * .13, _size * .44);
        
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
}
