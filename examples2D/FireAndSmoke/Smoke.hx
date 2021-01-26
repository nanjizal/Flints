import flints.common.actions.Age;
import flints.common.actions.Fade;
import flints.common.actions.ScaleImage;
import flints.common.counters.Steady;
import flints.common.displayobjects.RadialDot;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.actions.RandomDrift;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscSectorZone;
import openfl.geom.Point;

class Smoke extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(10);
		addInitializer(new Lifetime(11, 12));
		addInitializer(new Velocity(new DiscSectorZone(new Point(0, 0), 40, 30, -4 * Math.PI / 7, -3 * Math.PI / 7)));
		addInitializer(new SharedImage(new RadialDot(6)));
		addAction(new Age());
		addAction(new Move());
		addAction(new LinearDrag(0.01));
		addAction(new ScaleImage(1, 15));
		addAction(new Fade(0.15, 0));
		addAction(new RandomDrift(15, 15));
	}

}

