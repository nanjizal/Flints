import flints.common.actions.Age;
import flints.common.counters.Steady;
import flints.common.displayobjects.Line;
import flints.common.initializers.ColorInit;
import flints.common.initializers.Lifetime;
import flints.common.initializers.SharedImage;
import flints.twod.actions.Move;
import flints.twod.actions.RotateToDirection;
import flints.twod.activities.FollowMouse;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscZone;
import openfl.display.DisplayObject;
import openfl.geom.Point;

class Sparkler extends Emitter2D
{

	public function new(renderer : DisplayObject)
	{
    super ();

		counter = new Steady(150);
		addInitializer(new SharedImage(new Line(8)));
		addInitializer(new ColorInit(0xFFFFCC00, 0xFFFFCC00));
		addInitializer(new Velocity(new DiscZone(new Point(0, 0), 350, 200)));
		addInitializer(new Lifetime(0.2, 0.4));
		addAction(new Age());
		addAction(new Move());
		addAction(new RotateToDirection());
		addActivity(new FollowMouse(renderer));
	}

}

