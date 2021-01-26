import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.BitmapRenderer;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Rectangle;

@:meta(SWF(width="400",height="400",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();

		var renderer : BitmapRenderer = new BitmapRenderer(new Rectangle(0, 0, 400, 400));
		renderer.addFilter(new BlurFilter(2, 2, 1));
		renderer.addFilter(new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.95, 0]));
		addChild(renderer);
		emitter = new Sparkler(renderer);
		renderer.addEmitter(emitter);
		emitter.start();
	}

}

