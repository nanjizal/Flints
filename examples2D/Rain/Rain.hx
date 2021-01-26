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
import flints.common.initializers.AlphaInit;
import flints.twod.actions.Accelerate;
import flints.twod.actions.CollisionZone;
import flints.twod.actions.DeathZone;
import flints.twod.actions.Move;
import flints.twod.actions.SpeedLimit;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscZone;
import flints.twod.zones.LineZone;
import flints.twod.zones.RectangleZone;
import openfl.geom.Point;

class Rain extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(1000);
		addInitializer(new Position(new LineZone(new Point(-55, -5), new Point(605, -5))));
		addInitializer(new Velocity(new DiscZone(new Point(60, 400), 20)));
		addInitializer(new AlphaInit(0.5));
		addAction(new Move());
		addAction(new CollisionZone(new DiscZone(new Point(245, 275), 150), 0.3));
		addAction(new DeathZone(new RectangleZone(-60, -10, 610, 410), true));
		addAction(new Accelerate(0, 500));
		addAction(new SpeedLimit(500));
	}

}

