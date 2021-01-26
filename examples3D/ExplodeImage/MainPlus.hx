import flints.common.debug.Stats;
import openfl.text.TextField;

@:meta(SWF(width="500",height="350",frameRate="60",backgroundColor="#000000"))
class MainPlus extends Main
{

	public function new()
	{
		super();
		var txt : TextField = new TextField();
		txt.text = "Click on the image.";
		txt.autoSize = "left";
		txt.textColor = 0xFFFFFF;
		txt.y = 330;
		addChild(txt);
		addChild(new Stats());
	}

}

