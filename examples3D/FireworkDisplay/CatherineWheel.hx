import flints.common.actions.Age;
import flints.common.counters.Steady;
import flints.common.displayobjects.Dot;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.threed.actions.Accelerate;
import flints.threed.actions.Move;
import flints.threed.activities.RotateEmitter;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Velocity;
import flints.threed.zones.ConeZone;
import openfl.geom.Vector3D;

class CatherineWheel extends Emitter3D
{

	public function new(position : Vector3D)
	{
		counter = new Steady(80);
		this.position = position;
		addActivity(new RotateEmitter(new Vector3D(0, 0, 1), 10));
		addInitializer(new SharedImage(new Dot(1)));
		addInitializer(new ColorInit(0xFFFFFF00, 0xFFFF6600));
		addInitializer(new Velocity(new ConeZone(new Vector3D(), new Vector3D(1, 0, 0), 0.5, 100, 80)));
		addInitializer(new Lifetime(0.5));
		addAction(new Move());
		addAction(new Accelerate(new Vector3D(0, 50, 0)));
		addAction(new Age());
	}

}

