/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2011
 * http://flintparticles.org/
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
import flints.common.actions.Age;
import flints.common.actions.ColorChange;
import flints.common.actions.ScaleImage;
import flints.common.counters.Steady;
import flints.common.easing.TwoWay;
import flints.common.initializers.ImageClass;
import flints.common.initializers.Lifetime;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.actions.RotateToDirection;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.BitmapDataZone;
import flints.twod.zones.DiscSectorZone;
import openfl.display.BitmapData;
import openfl.geom.Point;

class LogoFire extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(600);
		addInitializer(new Lifetime(0.8));
		addInitializer(new Velocity(new DiscSectorZone(new Point(0, 0), 10, 5, -Math.PI * 0.75, -Math.PI * 0.25)));
		var bitmap : BitmapData = new Logo(265, 80);
		addInitializer(new Position(new BitmapDataZone(bitmap)));
		addInitializer(new ImageClass(FireBlob));
		addAction(new Age(TwoWay.quadratic));
		addAction(new Move());
		addAction(new LinearDrag(1));
		addAction(new Accelerate(0, -20));
		addAction(new ColorChange(0xFFFF9900, 0x00FFDD66));
		addAction(new ScaleImage(1.4, 2));
		addAction(new RotateToDirection());
	}

}

