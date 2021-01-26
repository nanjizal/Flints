import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.BitmapRenderer;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

@:meta(SWF(width="500",height="200",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();

		var bitmap : Bitmap = new Bitmap(new Logo(265, 80));
		addChild(bitmap);
		bitmap.x = 118;
		bitmap.y = 70;
		emitter = new LogoFire();
		var renderer : BitmapRenderer = new BitmapRenderer(new Rectangle(0, 0, 500, 200));
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.x = 118;
		emitter.y = 70;
		emitter.start();
	}

}

