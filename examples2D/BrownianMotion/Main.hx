import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.DisplayObjectRenderer;
import openfl.display.Sprite;

@:meta(SWF(width="500",height="500",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	public function new()
	{
    super ();
  }

  function _init () : Void
  {
		emitter = new BrownianMotion(stage);
		var renderer : DisplayObjectRenderer = new DisplayObjectRenderer();
		renderer.addEmitter(emitter);
		addChild(renderer);
		emitter.start();
	}
}

