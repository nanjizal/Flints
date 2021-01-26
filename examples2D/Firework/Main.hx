import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.BitmapRenderer;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Rectangle;

@:meta(SWF(width="500",height="400",frameRate="60",backgroundColor="#000000"))
/**
 * This example creates a firework like effect.
 * 
 * <p>This is the document class for the Flex project.</p>
 */
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();
		emitter = new Firework();
		var renderer : BitmapRenderer = new BitmapRenderer(new Rectangle(0, 0, 500, 400));
		renderer.addFilter(new BlurFilter(2, 2, 1));
		renderer.addFilter(new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.95, 0]));
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.x = 250;
		emitter.y = 150;
		emitter.start();
	}

}

