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

