import flints.common.actions.Age;
import flints.common.actions.ColorChange;
import flints.common.actions.ScaleImage;
import flints.common.counters.Steady;
import flints.common.easing.TwoWay;
import flints.common.initializers.ImageClass;
import flints.common.initializers.Lifetime;
import flints.twod.actions.Accelerate;
import flints.twod.actions.LinearDrag;
import flints.twod.actions.Move;
import flints.twod.actions.RotateToDirection;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.BitmapDataZone;
import flints.twod.zones.DiscSectorZone;
import openfl.display.BitmapData;
import openfl.geom.Point;

class LogoFire extends Emitter2D
{

	public function new()
	{
    super ();

		counter = new Steady(600);
		addInitializer(new Lifetime(0.8));
		addInitializer(new Velocity(new DiscSectorZone(new Point(0, 0), 10, 5, -Math.PI * 0.75, -Math.PI * 0.25)));
		var bitmap : BitmapData = new Logo(265, 80);
		addInitializer(new Position(new BitmapDataZone(bitmap)));
		addInitializer(new ImageClass(FireBlob));
		addAction(new Age(TwoWay.quadratic));
		addAction(new Move());
		addAction(new LinearDrag(1));
		addAction(new Accelerate(0, -20));
		addAction(new ColorChange(0xFFFF9900, 0x00FFDD66));
		addAction(new ScaleImage(1.4, 2));
		addAction(new RotateToDirection());
	}

}

