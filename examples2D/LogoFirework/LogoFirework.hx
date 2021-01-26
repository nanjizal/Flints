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
import flints.common.actions.Fade;
import flints.common.counters.Blast;
import flints.common.easing.Quadratic;
import flints.common.events.EmitterEvent;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.BitmapDataZone;
import flints.twod.zones.DiscZone;
import openfl.geom.Point;

class LogoFirework extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(4000);
		addInitializer(new ColorInit(0xFFFF3300, 0xFFFFFF00));
		addInitializer(new Lifetime(6));
		addInitializer(new Position(new DiscZone(new Point(0, 0), 10)));
		addInitializer(new Velocity(new BitmapDataZone(new Logo(265, 80), -132, -300)));
		addAction(new Age(Quadratic.easeIn));
		addAction(new Fade(1.0, 0));
		addAction(new Move());
		addAction(new LinearDrag(0.5));
		addAction(new Accelerate(0, 70));
		addEventListener(EmitterEvent.EMITTER_EMPTY, restart, false, 0, true);
	}

	public function restart(ev : EmitterEvent) : Void
	{
		cast((ev.target), Emitter2D).start();
	}

}

