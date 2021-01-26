import flints.common.actions.Age;
import flints.common.actions.ColorChange;
import flints.common.actions.ScaleImage;
import flints.common.counters.Steady;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.threed.actions.Accelerate;
import flints.threed.actions.LinearDrag;
import flints.threed.actions.Move;
import flints.threed.actions.RotateToDirection;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Position;
import flints.threed.initializers.Velocity;
import flints.threed.zones.DiscZone;
import openfl.geom.Vector3D;

class Fire extends Emitter3D
{

	public function new()
	{
		counter = new Steady(60);
		addInitializer(new Lifetime(2, 3));
		addInitializer(new Velocity(new DiscZone(new Vector3D(0, 0, 0), new Vector3D(0, 1, 0), 20)));
		addInitializer(new Position(new DiscZone(new Vector3D(0, 0, 0), new Vector3D(0, 1, 0), 3)));
		addInitializer(new SharedImage(new FireBlob()));
		addAction(new Age());
		addAction(new Move());
		addAction(new LinearDrag(1));
		addAction(new Accelerate(new Vector3D(0, -40, 0)));
		addAction(new ColorChange(0xFFFFCC00, 0x00CC0000));
		addAction(new ScaleImage(1, 1.5));
		addAction(new RotateToDirection());
	}

}

