/*
 created by Jordan Leary to extend flint display objects
 */

package org.flintparticles.common.displayobjects;

import openfl.display.Shape;

/**
 * The Ellipse class is a DisplayObject with a oval shape. The registration point
 * of this diaplay object is in the center of the Ellipse.
 */
class MusicNote extends Shape {
    public var ellipseWidth(get, set):Float;
    public var ellipseHeight(get, set):Float;
    public var color(get, set):Int;

    private var _ellipseWidth:Float;
    private var _ellipseHeight:Float;
    private var _color:Int;
    
    /**
     * The constructor creates a Dot with a specified radius.
     * @param radius The radius, in pixels, of the Dot.
     * @param color The color of the Dot.
     * @param bm The blendMode for the Dot.
     */
    public function new(width:Float = 1, color:Int = 0xFFFFFF, bm:String = "normal") {
        super();
        _ellipseWidth = width;
        _ellipseHeight = width * 0.8;
        _color = color;
        draw();
        blendMode = bm;
    }
    
    private function draw():Void {
        if (_ellipseWidth > 0 && _ellipseHeight > 0) {
            graphics.clear();
            graphics.beginFill(_color);
            graphics.drawEllipse(0, 0, _ellipseWidth, _ellipseHeight);
            graphics.endFill();
            
            graphics.lineStyle(2, _color);
            if (Math.random() < 0.5) {
                graphics.moveTo(_ellipseWidth, _ellipseHeight / 2);
                graphics.lineTo(_ellipseWidth, -_ellipseWidth * 2);
            }
            else {
                graphics.moveTo(0, _ellipseHeight / 2);
                graphics.lineTo(0, _ellipseWidth * 2);
            }
        }
    }
    
    private function get_ellipseWidth():Float {
        return _ellipseWidth;
    }
    private function set_ellipseWidth(value:Float):Float {
        _ellipseWidth = value;
        draw();
        return value;
    }
    
    private function get_ellipseHeight():Float {
        return _ellipseHeight;
    }
    private function set_ellipseHeight(value:Float):Float {
        _ellipseHeight = value;
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
