import flints.common.actions.Age;
import flints.common.actions.Fade;
import flints.common.actions.ScaleImage;
import flints.common.counters.Steady;
import flints.common.displayobjects.RadialDot;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.threed.actions.LinearDrag;
import flints.threed.actions.Move;
import flints.threed.actions.RandomDrift;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Velocity;
import flints.threed.zones.ConeZone;
import openfl.geom.Vector3D;

class Smoke extends Emitter3D
{

	public function new()
	{
		counter = new Steady(10);
		addInitializer(new Lifetime(11, 12));
		addInitializer(new Velocity(new ConeZone(new Vector3D(0, 0, 0), new Vector3D(0, -1, 0), 0.5, 40, 30)));
		addInitializer(new SharedImage(new RadialDot(6)));
		addAction(new Age());
		addAction(new Move());
		addAction(new LinearDrag(0.01));
		addAction(new ScaleImage(1, 15));
		addAction(new Fade(0.15, 0));
		addAction(new RandomDrift(15, 15, 15));
	}

}

