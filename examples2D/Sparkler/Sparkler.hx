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
import flints.common.counters.Steady;
import flints.common.displayobjects.Line;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.twod.actions.Move;
import flints.twod.actions.RotateToDirection;
import flints.twod.activities.FollowMouse;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscZone;
import openfl.display.DisplayObject;
import openfl.geom.Point;

class Sparkler extends Emitter2D
{

	public function new(renderer : DisplayObject)
	{
    super ();

		counter = new Steady(150);
		addInitializer(new SharedImage(new Line(8)));
		addInitializer(new ColorInit(0xFFFFCC00, 0xFFFFCC00));
		addInitializer(new Velocity(new DiscZone(new Point(0, 0), 350, 200)));
		addInitializer(new Lifetime(0.2, 0.4));
		addAction(new Age());
		addAction(new Move());
		addAction(new RotateToDirection());
		addActivity(new FollowMouse(renderer));
	}

}

