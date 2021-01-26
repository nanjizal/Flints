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

