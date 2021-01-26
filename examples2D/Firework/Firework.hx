import flints.common.actions.Age;
import flints.common.actions.Fade;
import flints.common.counters.Blast;
import flints.common.displayobjects.Dot;
import flints.common.easing.Quadratic;
import flints.common.events.EmitterEvent;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscZone;
import openfl.geom.Point;

class Firework extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(700);
		addInitializer(new SharedImage(new Dot(2)));
		addInitializer(new ColorInit(0xFFFFFF00, 0xFFFF6600));
		addInitializer(new Velocity(new DiscZone(new Point(0, 0), 200, 120)));
		addInitializer(new Lifetime(5));
		addAction(new Age(Quadratic.easeIn));
		addAction(new Move());
		addAction(new Fade());
		addAction(new Accelerate(0, 50));
		addAction(new LinearDrag(0.5));
		addEventListener(EmitterEvent.EMITTER_EMPTY, restart, false, 0, true);
	}

	public function restart(ev : EmitterEvent) : Void
	{
		start();
	}

}

