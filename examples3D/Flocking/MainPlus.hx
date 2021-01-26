import flints.common.debug.Stats;

@:meta(SWF(width="700",height="500",frameRate="60",backgroundColor="#CCCCCC"))
class MainPlus extends Main
{

	public function new()
	{
		super();
		addChild(new Stats(0, 0xCCCCCC));
	}

}

