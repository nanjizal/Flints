import flints.common.actions.Age;
import flints.common.counters.Steady;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.threed.actions.Accelerate;
import flints.threed.actions.Move;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Velocity;
import flints.threed.zones.DiscZone;
import openfl.geom.Vector3D;

class Fountain extends Emitter3D
{

	public function new()
	{
		counter = new Steady(2500);
		addInitializer(new ColorInit(0xFFCCCCFF, 0xFF6666FF));
		addInitializer(new Velocity(new DiscZone(new Vector3D(0, -250, 0), new Vector3D(0, 1, 0), 60)));
		addInitializer(new Lifetime(3.2));
		addAction(new Move());
		addAction(new Accelerate(new Vector3D(0, 150, 0)));
		addAction(new Age());
	}

}

