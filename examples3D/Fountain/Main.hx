import flints.threed.emitters.Emitter3D;
import flints.threed.renderers.PixelRenderer;
import flints.threed.renderers.controllers.OrbitCamera;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Rectangle;
import openfl.geom.Vector3D;

@:meta(SWF(width="500",height="500",frameRate="61",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter3D;
	var renderer : PixelRenderer;
	var orbitter : OrbitCamera;
	public function new()
	{
		emitter = new Fountain();
		renderer = new PixelRenderer(new Rectangle(-250, -250, 500, 500), false);
		renderer.camera.dolly(-300);
		renderer.camera.lift(100);
		renderer.camera.target = new Vector3D(0, -100, 0);
		renderer.addFilter(new BlurFilter(2, 2, 1), true);
		renderer.addFilter(new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.99, 0]), true);
		renderer.addEmitter(emitter);
		renderer.x = 250;
		renderer.y = 250;
		addChild(renderer);
		emitter.start();
		orbitter = new OrbitCamera(stage, renderer.camera);
		orbitter.start();
	}

}

