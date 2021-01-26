import flints.common.actions.Age;
import flints.common.actions.Fade;
import flints.common.counters.Blast;
import flints.common.displayobjects.Dot;
import flints.common.easing.Quadratic;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.threed.actions.Accelerate;
import flints.threed.actions.LinearDrag;
import flints.threed.actions.Move;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Position;
import flints.threed.initializers.Velocity;
import flints.threed.zones.PointZone;
import flints.threed.zones.SphereZone;
import openfl.geom.Vector3D;

class SphereBang extends Emitter3D
{

	public function new(position : Vector3D)
	{
		counter = new Blast(200);
		addInitializer(new SharedImage(new Dot(1)));
		addInitializer(new ColorInit(0xFFFFFF00, 0xFFFF6600));
		addInitializer(new Position(new PointZone(position)));
		addInitializer(new Velocity(new SphereZone(new Vector3D(), 100)));
		addInitializer(new Lifetime(3));
		addAction(new Age(Quadratic.easeIn));
		addAction(new Move());
		addAction(new Fade());
		addAction(new Accelerate(new Vector3D(0, 50, 0)));
		addAction(new LinearDrag(0.5));
	}

}

