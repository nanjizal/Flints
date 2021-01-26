import flints.common.debug.Stats;
import openfl.events.Event;
import openfl.Lib;

@:meta(SWF(width="700",height="500",frameRate="60",backgroundColor="#CCCCCC"))
class MainPlus extends Main
{

	public function new()
	{
		super();
    addEventListener (Event.ADDED_TO_STAGE, _addedToStage);
    Lib.current.addChild (this);
  }

  static public function main () : Void
  {
    new MainPlus ();
  }

  function _addedToStage (e : Event) : Void
  {
    removeEventListener (Event.ADDED_TO_STAGE, _addedToStage);

		addChild(new Stats(0, 0xCCCCCC));
	}

}

