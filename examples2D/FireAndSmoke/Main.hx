import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.BitmapRenderer;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

@:meta(SWF(width="300",height="400",frameRate="60",backgroundColor="#000000"))
/**
 * This example creates fire and smoke using two emitters.
 * 
 * <p>This is the document class for the Flex project.</p>
 */
class Main extends Sprite
{

	var smoke : Emitter2D;
	var fire : Emitter2D;
	public function new()
	{
    super ();
		smoke = new Smoke();
		smoke.x = 150;
		smoke.y = 380;
		smoke.start();
		fire = new Fire();
		fire.x = 150;
		fire.y = 380;
		fire.start();
		var renderer : BitmapRenderer = new BitmapRenderer(new Rectangle(0, 0, 300, 400));
		renderer.addEmitter(smoke);
		renderer.addEmitter(fire);
		addChild(renderer);
	}

}

