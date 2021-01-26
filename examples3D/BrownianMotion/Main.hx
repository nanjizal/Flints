import flints.threed.emitters.Emitter3D;
import flints.threed.renderers.DisplayObjectRenderer;
import flints.threed.renderers.controllers.OrbitCamera;
import openfl.display.Sprite;
import openfl.geom.Vector3D;

@:meta(SWF(width="400",height="400",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter3D;
	var orbitter : OrbitCamera;
	public function new()
	{
		emitter = new BrownianMotion(stage);
		var renderer : DisplayObjectRenderer = new DisplayObjectRenderer();
		renderer.x = 200;
		renderer.y = 200;
		renderer.addEmitter(emitter);
		addChild(renderer);
		renderer.camera.position = new Vector3D(0, 0, -400);
		renderer.camera.target = new Vector3D(0, 0, 0);
		renderer.camera.projectionDistance = 400;
		orbitter = new OrbitCamera(stage, renderer.camera);
		orbitter.start();
		emitter.start();
	}

}

