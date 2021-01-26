import flints.threed.emitters.Emitter3D;
import flints.threed.renderers.BitmapRenderer;
import flints.threed.renderers.controllers.OrbitCamera;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.geom.Vector3D;

@:meta(SWF(width="400",height="400",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var smoke : Emitter3D;
	var fire : Emitter3D;
	var orbitter : OrbitCamera;
	public function new()
	{
		smoke = new Smoke();
		smoke.start();
		fire = new Fire();
		fire.start();
		var renderer : BitmapRenderer = new BitmapRenderer(new Rectangle(-200, -200, 400, 400));
		renderer.x = 200;
		renderer.y = 200;
		renderer.addEmitter(smoke);
		renderer.addEmitter(fire);
		addChild(renderer);
		renderer.camera.position = new Vector3D(0, -150, -400);
		renderer.camera.target = new Vector3D(0, -150, 0);
		renderer.camera.projectionDistance = 400;
		orbitter = new OrbitCamera(stage, renderer.camera);
		orbitter.start();
	}

}

