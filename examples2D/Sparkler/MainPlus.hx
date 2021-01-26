import flints.common.debug.Stats;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.events.Event;
import openfl.Lib;

@:meta(SWF(width="400",height="400",frameRate="60",backgroundColor="#000000"))
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

		var txt : TextField = new TextField();
		txt.text = "Move the mouse over this box.";
		txt.autoSize = TextFieldAutoSize.LEFT;
		txt.textColor = 0xFFFFFF;
		txt.y = 380;
		addChild(txt);
		addChild(new Stats());
	}

}

