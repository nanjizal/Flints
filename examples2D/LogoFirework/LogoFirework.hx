import flints.common.actions.Age;
import flints.common.actions.Fade;
import flints.common.counters.Blast;
import flints.common.easing.Quadratic;
import flints.common.events.EmitterEvent;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.BitmapDataZone;
import flints.twod.zones.DiscZone;
import openfl.geom.Point;

class LogoFirework extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(4000);
		addInitializer(new ColorInit(0xFFFF3300, 0xFFFFFF00));
		addInitializer(new Lifetime(6));
		addInitializer(new Position(new DiscZone(new Point(0, 0), 10)));
		addInitializer(new Velocity(new BitmapDataZone(new Logo(265, 80), -132, -300)));
		addAction(new Age(Quadratic.easeIn));
		addAction(new Fade(1.0, 0));
		addAction(new Move());
		addAction(new LinearDrag(0.5));
		addAction(new Accelerate(0, 70));
		addEventListener(EmitterEvent.EMITTER_EMPTY, restart, false, 0, true);
	}

	public function restart(ev : EmitterEvent) : Void
	{
		cast((ev.target), Emitter2D).start();
	}

}

