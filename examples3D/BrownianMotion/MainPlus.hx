import flints.common.debug.Stats;
import openfl.text.TextField;

@:meta(SWF(width="400",height="400",frameRate="60",backgroundColor="#000000"))
class MainPlus extends Main
{

	public function new()
	{
		super();
		var txt : TextField = new TextField();
		txt.text = "Hold down the shift key to hide the air particles.";
		txt.autoSize = "left";
		txt.textColor = 0xFFFFFF;
		txt.y = 380;
		addChild(txt);
		addChild(new Stats());
	}

}

