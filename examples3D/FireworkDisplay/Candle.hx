import flints.common.actions.Age;
import flints.common.counters.Steady;
import flints.common.displayobjects.Dot;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.threed.actions.Accelerate;
import flints.threed.actions.Move;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Position;
import flints.threed.initializers.Velocity;
import flints.threed.zones.DiscZone;
import flints.threed.zones.PointZone;
import openfl.geom.Vector3D;

class Candle extends Emitter3D
{

	public function new(position : Vector3D)
	{
		counter = new Steady(30);
		addInitializer(new SharedImage(new Dot(1)));
		addInitializer(new ColorInit(0xFFFFFF00, 0xFFFF6600));
		addInitializer(new Position(new PointZone(position)));
		addInitializer(new Velocity(new DiscZone(new Vector3D(0, -80, 0), new Vector3D(0, 1, 0), 30)));
		addInitializer(new Lifetime(2));
		addAction(new Move());
		addAction(new Accelerate(new Vector3D(0, 50, 0)));
		addAction(new Age());
	}

}

