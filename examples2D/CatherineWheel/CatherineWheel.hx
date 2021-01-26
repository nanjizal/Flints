import flints.common.actions.Age;
import flints.common.actions.Fade;
import flints.common.counters.Steady;
import flints.common.displayobjects.Line;
import flints.common.easing.Quadratic;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.activities.RotateEmitter;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscSectorZone;
import openfl.geom.Point;

class CatherineWheel extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(200);
		addActivity(new RotateEmitter(-7));
		addInitializer(new SharedImage(new Line(3)));
		addInitializer(new ColorInit(0xFFFFFF00, 0xFFFF6600));
		addInitializer(new Velocity(new DiscSectorZone(new Point(0, 0), 250, 170, 0, 0.2)));
		addInitializer(new Lifetime(1.3));
		addAction(new Age(Quadratic.easeIn));
		addAction(new Move());
		addAction(new Fade());
		addAction(new Accelerate(0, 50));
		addAction(new LinearDrag(0.5));
	}

}

