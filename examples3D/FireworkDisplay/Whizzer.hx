import flints.common.actions.Age;
import flints.common.counters.Steady;
import flints.common.displayobjects.Dot;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.threed.actions.Accelerate;
import flints.threed.actions.LinearDrag;
import flints.threed.actions.Move;
import flints.threed.actions.RandomDrift;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Position;
import flints.threed.initializers.Velocity;
import flints.threed.zones.ConeZone;
import flints.threed.zones.Zone3D;
import openfl.geom.Vector3D;

class Whizzer extends Emitter3D
{

	public function new(zone : Zone3D)
	{
		counter = new Steady(0.5);
		addInitializer(new SharedImage(new Dot(4)));
		addInitializer(new ColorInit(0xFFFFFF00, 0xFFFF6600));
		addInitializer(new Position(zone));
		addInitializer(new Velocity(new ConeZone(new Vector3D(), new Vector3D(0, -1, 0), 0.1, 350, 330)));
		addInitializer(new Lifetime(3.3));
		addAction(new Age());
		addAction(new Move());
		addAction(new Accelerate(new Vector3D(0, 50, 0)));
		addAction(new LinearDrag(0.5));
		addAction(new RandomDrift(10, 10, 10));
	}

}

