import flints.common.counters.Blast;
import flints.common.initializers.ImageClass;
import flints.threed.actions.ApproachNeighbours;
import flints.threed.actions.BoundingBox;
import flints.threed.actions.MatchVelocity;
import flints.threed.actions.MinimumDistance;
import flints.threed.actions.Move;
import flints.threed.actions.RotateToDirection;
import flints.threed.actions.SpeedLimit;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Position;
import flints.threed.initializers.Velocity;
import flints.threed.zones.BoxZone;
import flints.threed.zones.SphereZone;
import openfl.geom.Vector3D;

class Flock extends Emitter3D
{

	public function new()
	{
		counter = new Blast(300);
		addInitializer(new ImageClass(Bird));
		addInitializer(new Position(new BoxZone(580, 380, 580, new Vector3D(0, 0, 0), new Vector3D(0, 1, 0), new Vector3D(0, 0, 1))));
		addInitializer(new Velocity(new SphereZone(new Vector3D(0, 0, 0), 150, 100)));
		addAction(new ApproachNeighbours(200, 100));
		addAction(new MatchVelocity(40, 200));
		addAction(new MinimumDistance(20, 600));
		addAction(new RotateToDirection());
		addAction(new BoundingBox(-300, 300, -200, 200, -300, 300));
		addAction(new SpeedLimit(100, true));
		addAction(new SpeedLimit(200));
		addAction(new Move());
	}

}

