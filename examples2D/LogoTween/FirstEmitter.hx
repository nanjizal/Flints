import flints.common.actions.Age;
import flints.common.counters.Blast;
import flints.common.easing.Quadratic;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.twod.actions.TweenToZone;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.zones.BitmapDataZone;

class FirstEmitter extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(5000);
		addInitializer(new ColorInit(0xFFFFFF00, 0xCC6600));
		addInitializer(new Lifetime(6));
		addInitializer(new Position(new BitmapDataZone(new FlintImage(320, 80), 40, 60)));
		addAction(new Age(Quadratic.easeInOut));
		addAction(new TweenToZone(new BitmapDataZone(new ParticlesImage(320, 80), 40, 60)));
	}

}

