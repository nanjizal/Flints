import flints.common.actions.Age;
import flints.common.easing.Quadratic;
import flints.common.initializers.Lifetime;
import flints.twod.actions.TweenToZone;
import flints.twod.emitters.Emitter2D;
import flints.twod.zones.BitmapDataZone;

class TweenToFlint extends Emitter2D
{

	public function new()
	{
    super ();

		addInitializer(new Lifetime(6));
		addAction(new Age(Quadratic.easeInOut));
		addAction(new TweenToZone(new BitmapDataZone(new FlintImage(320, 80), 40, 60)));
	}

}

