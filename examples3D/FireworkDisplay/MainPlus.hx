import flints.common.debug.Stats;
import openfl.text.TextField;

@:meta(SWF(width="800",height="600",frameRate="60",backgroundColor="#000000"))
class MainPlus extends Main
{

	public function new()
	{
		super();
		var txt : TextField = new TextField();
		txt.text = "Use arrow keys to pan/tilt the camera. Use W,S,D,L to move the camera. Use page up/ page down to raise and lower the camera.";
		txt.autoSize = "left";
		txt.textColor = 0xFFFFFF;
		txt.y = 580;
		addChild(txt);
		addChild(new Stats());
	}

}

