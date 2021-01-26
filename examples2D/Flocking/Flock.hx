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

