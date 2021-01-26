import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.PixelRenderer;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

@:meta(SWF(width="600",height="400",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();

		emitter = new Rain();
		addChild(new Bitmap(new Image1(600, 400)));
		var renderer : PixelRenderer = new PixelRenderer(new Rectangle(0, 0, 600, 400));
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.start();
		emitter.runAhead(4, 30);
	}

}

