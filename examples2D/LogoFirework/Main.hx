import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.PixelRenderer;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Rectangle;

@:meta(SWF(width="500",height="300",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();

		emitter = new LogoFirework();
		var renderer : PixelRenderer = new PixelRenderer(new Rectangle(0, 0, 500, 300));
		renderer.addFilter(new BlurFilter(2, 2, 1));
		renderer.addFilter(new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.96, 0]));
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.x = 250;
		emitter.y = 300;
		emitter.start();
	}

}

