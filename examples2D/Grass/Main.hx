import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.BitmapLineRenderer;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

@:meta(SWF(width="500",height="500",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();
		emitter = new Grass();
		emitter.x = 250;
		emitter.y = 450;
		var renderer : BitmapLineRenderer = new BitmapLineRenderer(new Rectangle(0, 0, 500, 500));
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.start();
	}

}

