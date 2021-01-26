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
import flints.common.counters.Steady;
import flints.common.displayobjects.RadialDot;
import flints.common.initializers.ImageClass;
import flints.common.initializers.ScaleImageInit;
import flints.twod.actions.DeathZone;
import flints.twod.actions.Move;
import flints.twod.actions.RandomDrift;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.LineZone;
import flints.twod.zones.PointZone;
import flints.twod.zones.RectangleZone;
import openfl.geom.Point;

class Snowfall extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(150);
		addInitializer(new ImageClass(RadialDot, [2]));
		addInitializer(new Position(new LineZone(new Point(-5, -5), new Point(605, -5))));
		addInitializer(new Velocity(new PointZone(new Point(0, 65))));
		addInitializer(new ScaleImageInit(0.75, 2));
		addAction(new Move());
		addAction(new DeathZone(new RectangleZone(-10, -10, 620, 420), true));
		addAction(new RandomDrift(20, 20));
	}

}

