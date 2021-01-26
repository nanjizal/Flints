import flints.common.counters.Blast;
import flints.common.displayobjects.Dot;
import flints.common.initializers.ChooseInitializer;
import flints.common.initializers.CollisionRadiusInit;
import flints.common.initializers.ColorInit;
import flints.common.initializers.ImageClass;
import flints.common.initializers.InitializerGroup;
import flints.common.initializers.MassInit;
import flints.threed.actions.BoundingBox;
import flints.threed.actions.Collide;
import flints.threed.actions.Move;
import flints.threed.emitters.Emitter3D;
import flints.threed.initializers.Position;
import flints.threed.initializers.Velocity;
import flints.threed.zones.BoxZone;
import flints.threed.zones.SphereZone;
import openfl.display.DisplayObject;
import openfl.geom.Vector3D;

class BrownianMotion extends Emitter3D
{

	public function new(stage : DisplayObject)
	{
		counter = new Blast(400);
		var air : InitializerGroup = new InitializerGroup();
		air.addInitializer(new ImageClass(Dot, [2]));
		air.addInitializer(new ColorInit(0xFF666666, 0xFF666666));
		air.addInitializer(new MassInit(1));
		air.addInitializer(new CollisionRadiusInit(2));
		var smoke : InitializerGroup = new InitializerGroup();
		smoke.addInitializer(new ImageClass(Dot, [10]));
		smoke.addInitializer(new ColorInit(0xFFFFFFFF, 0xFFFFFFFF));
		smoke.addInitializer(new MassInit(5));
		smoke.addInitializer(new CollisionRadiusInit(10));
		addInitializer(new Position(new BoxZone(280, 280, 280, new Vector3D(0, 0, 0), new Vector3D(0, 1, 0), new Vector3D(0, 0, 1))));
		addInitializer(new Velocity(new SphereZone(new Vector3D(0, 0, 0), 150, 100)));
		addInitializer(new ChooseInitializer([air, smoke], [30, 1]));
		addAction(new Move());
		addAction(new Collide(1));
		addAction(new BoundingBox(-150, 150, -150, 150, -150, 150, 1));
		addAction(new ShowAirAction(stage));
	}

}

