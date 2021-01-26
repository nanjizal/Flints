import flints.common.counters.Blast;
import flints.common.displayobjects.Dot;
import flints.common.initializers.ColorInit;
import flints.common.initializers.SharedImage;
import flints.twod.actions.BoundingBox;
import flints.twod.actions.Move;
import flints.twod.actions.MutualGravity;
import flints.twod.actions.SpeedLimit;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.zones.RectangleZone;

class MutualG extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(40);
		addInitializer(new SharedImage(new Dot(2)));
		addInitializer(new ColorInit(0xFFFF00FF, 0xFF00FFFF));
		addInitializer(new Position(new RectangleZone(10, 10, 380, 380)));
		addAction(new MutualGravity(10, 500, 3));
		addAction(new BoundingBox(0, 0, 400, 400));
		addAction(new SpeedLimit(150));
		addAction(new Move());
	}

}

