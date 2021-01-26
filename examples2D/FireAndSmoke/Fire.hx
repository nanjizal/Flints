import flints.common.actions.Age;
import flints.common.actions.ColorChange;
import flints.common.actions.ScaleImage;
import flints.common.counters.Steady;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.actions.RotateToDirection;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscSectorZone;
import flints.twod.zones.DiscZone;
import openfl.geom.Point;

class Fire extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(60);
		addInitializer(new Lifetime(2, 3));
		addInitializer(new Velocity(new DiscSectorZone(new Point(0, 0), 20, 10, -Math.PI, 0)));
		addInitializer(new Position(new DiscZone(new Point(0, 0), 3)));
		addInitializer(new SharedImage(new FireBlob()));
		addAction(new Age());
		addAction(new Move());
		addAction(new LinearDrag(1));
		addAction(new Accelerate(0, -40));
		addAction(new ColorChange(0xFFFFCC00, 0x00CC0000));
		addAction(new ScaleImage(1, 1.5));
		addAction(new RotateToDirection());
	}

}

