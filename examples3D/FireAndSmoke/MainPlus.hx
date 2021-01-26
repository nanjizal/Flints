import flints.common.debug.Stats;
import openfl.text.TextField;

@:meta(SWF(width="400",height="400",frameRate="60",backgroundColor="#000000"))
class MainPlus extends Main
{

	public function new()
	{
		super();
		var txt : TextField = new TextField();
		txt.text = "Use arrow keys to track in/out and orbit around the fire.";
		txt.autoSize = "left";
		txt.textColor = 0xFFFFFF;
		txt.y = 380;
		addChild(txt);
		addChild(new Stats());
	}

}

