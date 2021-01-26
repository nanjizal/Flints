import flints.common.counters.Blast;
import flints.common.displayobjects.Dot;
import flints.common.initializers.ChooseInitializer;
import flints.common.initializers.CollisionRadiusInit;
import flints.common.initializers.ColorInit;
import flints.common.initializers.ImageClass;
import flints.common.initializers.InitializerGroup;
import flints.common.initializers.MassInit;
import flints.twod.actions.BoundingBox;
import flints.twod.actions.Collide;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.initializers.Velocity;
import flints.twod.zones.DiscZone;
import flints.twod.zones.RectangleZone;
import openfl.display.DisplayObject;
import openfl.geom.Point;

class BrownianMotion extends Emitter2D
{

	public function new(stage : DisplayObject)
	{
    super ();

		counter = new Blast(500);
		var air : InitializerGroup = new InitializerGroup([]);
		air.addInitializer(new ImageClass(Dot, [2]));
		air.addInitializer(new ColorInit(0xFF666666, 0xFF666666));
		air.addInitializer(new MassInit(1));
		air.addInitializer(new CollisionRadiusInit(2));
		var smoke : InitializerGroup = new InitializerGroup([]);
		smoke.addInitializer(new ImageClass(Dot, [10]));
		smoke.addInitializer(new ColorInit(0xFFFFFFFF, 0xFFFFFFFF));
		smoke.addInitializer(new MassInit(10));
		smoke.addInitializer(new CollisionRadiusInit(10));
		addInitializer(new Position(new RectangleZone(0, 0, 500, 500)));
		addInitializer(new Velocity(new DiscZone(new Point(0, 0), 150, 100)));
		addInitializer(new ChooseInitializer([air, smoke], [30, 1]));
		addAction(new Move());
		addAction(new Collide(1));
		addAction(new BoundingBox(0, 0, 500, 500, 1));
		addAction(new ShowAirAction(stage));
	}

}

