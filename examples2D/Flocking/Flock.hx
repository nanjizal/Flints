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
import flints.common.counters.Blast;
import flints.common.initializers.ImageClass;
import flints.twod.actions.ApproachNeighbours;
import flints.twod.actions.BoundingBox;
import flints.twod.actions.MatchVelocity;
import flints.twod.actions.MinimumDistance;
import flints.twod.actions.Move;
import flints.twod.actions.RotateToDirection;
import flints.twod.actions.SpeedLimit;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscZone;
import flints.twod.zones.RectangleZone;
import openfl.geom.Point;

class Flock extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(250);
		addInitializer(new ImageClass(Bird));
		addInitializer(new Position(new RectangleZone(10, 10, 680, 480)));
		addInitializer(new Velocity(new DiscZone(new Point(0, 0), 150, 100)));
		addAction(new ApproachNeighbours(150, 100));
		addAction(new MatchVelocity(20, 200));
		addAction(new MinimumDistance(10, 600));
		addAction(new SpeedLimit(100, true));
		addAction(new RotateToDirection());
		addAction(new BoundingBox(0, 0, 700, 500));
		addAction(new SpeedLimit(200));
		addAction(new Move());
	}

}

