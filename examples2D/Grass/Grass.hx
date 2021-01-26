import flints.common.actions.Age;
import flints.common.actions.ScaleImage;
import flints.common.counters.Blast;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.twod.actions.Accelerate;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscSectorZone;
import flints.twod.zones.DiscZone;
import openfl.geom.Point;

class Grass extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Blast(100);
		addInitializer(new Position(new DiscZone(new Point(0, 0), 40)));
		addInitializer(new Velocity(new DiscSectorZone(new Point(0, 0), 80, 40, -5 * Math.PI / 8, -3 * Math.PI / 8)));
		addInitializer(new ColorInit(0xFF006600, 0xFF009900));
		addInitializer(new Lifetime(7));
		addAction(new Move());
		addAction(new Age());
		addAction(new ScaleImage(4, 1));
		addAction(new Accelerate(0, 10));
	}

}

