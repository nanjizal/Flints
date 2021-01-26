import flints.common.debug.Stats;
import openfl.text.TextField;

@:meta(SWF(width="500",height="500",frameRate="60",backgroundColor="#000000"))
class MainPlus extends Main
{

	public function new()
	{
		super();
		var txt : TextField = new TextField();
		txt.text = "Use arrow keys to track in/out and orbit around the fountain.";
		txt.autoSize = "left";
		txt.textColor = 0xFFFFFF;
		txt.y = 480;
		addChild(txt);
		addChild(new Stats());
	}

}

