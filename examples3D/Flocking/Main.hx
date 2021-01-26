import flints.threed.emitters.Emitter3D;
import flints.threed.renderers.DisplayObjectRenderer;
import flints.threed.renderers.controllers.FirstPersonCamera;
import openfl.display.Sprite;
import openfl.geom.Vector3D;

@:meta(SWF(width="700",height="500",frameRate="60",backgroundColor="#CCCCCC"))
class Main extends Sprite
{

	var emitter : Emitter3D;
	var controller : FirstPersonCamera;
	public function new()
	{
		emitter = new Flock();
		var renderer : DisplayObjectRenderer = new DisplayObjectRenderer(false);
		renderer.x = 350;
		renderer.y = 250;
		renderer.addEmitter(emitter);
		addChild(renderer);
		renderer.camera.position = new Vector3D(0, 0, -400);
		renderer.camera.target = new Vector3D(0, 0, 0);
		renderer.camera.projectionDistance = 400;
		controller = new FirstPersonCamera(stage, renderer.camera);
		controller.start();
		emitter.start();
	}

}

