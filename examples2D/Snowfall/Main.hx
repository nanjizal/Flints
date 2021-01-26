import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.DisplayObjectRenderer;
import openfl.display.Bitmap;
import openfl.display.Sprite;

@:meta(SWF(width="600",height="400",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();

		emitter = new Snowfall();
		addChild(new Bitmap(new SnowBackground(600, 400)));
		var renderer : DisplayObjectRenderer = new DisplayObjectRenderer();
		renderer.addEmitter(emitter);
		addChild(renderer);
		addChild(new Bitmap(new SnowForeground(600, 400)));
		emitter.start();
		emitter.runAhead(10);
	}

}

