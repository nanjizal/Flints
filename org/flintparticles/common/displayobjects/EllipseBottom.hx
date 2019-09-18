/*
 * FLINT PARTICLE SYSTEM
 * .....................
 *
 * Author: Xor (Adrian Stutz) for Nothing GmbH
 * Copyright (c) Richard Lord 2008-2011
 * http://flintparticles.org
 *
 *
 * Licence Agreement
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.flintparticles.common.displayObjects;

import openfl.display.Shape;

/**
 * The Ellipse class is a DisplayObject with a oval shape. The registration point
 * of this diaplay object is in the center of the Ellipse.
 */
class EllipseBottom extends Shape {
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
    public function new(width:Float = 1, height:Float = 1, minScale:Float = 1.0, color:Int = 0xFFFFFF, bm:String = "normal") {
        super();
        var random:Float = minScale + Math.random() * (1 - minScale);
        _ellipseWidth = width * random;
        _ellipseHeight = height * random;
        _color = color;
        draw();
        blendMode = bm;
    }
    
    private function draw():Void {
        if (_ellipseWidth > 0 && _ellipseHeight > 0) {
            graphics.clear();
            graphics.beginFill(_color);
            graphics.drawEllipse(-_ellipseWidth / 2, -ellipseHeight, _ellipseWidth, _ellipseHeight);
            graphics.endFill();
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
