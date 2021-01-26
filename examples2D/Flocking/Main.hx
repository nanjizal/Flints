import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.DisplayObjectRenderer;
import openfl.display.Sprite;

@:meta(SWF(width="700",height="500",frameRate="60",backgroundColor="#CCCCCC"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();

		emitter = new Flock();
		var renderer : DisplayObjectRenderer = new DisplayObjectRenderer();
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.start();
	}

}

