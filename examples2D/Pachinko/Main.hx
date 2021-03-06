import flints.common.events.EmitterEvent;
import flints.twod.renderers.BitmapRenderer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFormat;

@:meta(SWF(width="480",height="425",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Pachinko;
	var startButton : TextField;
	public function new()
	{
    super ();

		drawBackground();
		emitter = new Pachinko();
		var renderer : BitmapRenderer = new BitmapRenderer(new Rectangle(0, 0, 500, 425));
		renderer.addEmitter(emitter);
		addChild(renderer);
		addPins();
		addStartButton();
		emitter.start();
	}

	function drawBackground() : Void
	{
		graphics.beginFill(0x666666);
		graphics.drawRect(0, 0, 500, 500);
		graphics.endFill();
		graphics.beginFill(0);
		graphics.drawCircle(240, 205, 240);
		graphics.endFill();
	}

	function addStartButton() : Void
	{
		var tf : TextFormat = new TextFormat();
		tf.font = "Helvetica";
		tf.size = 18;
		tf.color = 0xFFFF00;
		startButton = new TextField();
		startButton.defaultTextFormat = tf;
		startButton.text = "START";
		startButton.selectable = false;
		startButton.visible = false;
		startButton.x = 207;
		startButton.y = 194;
		addChild(startButton);
		startButton.addEventListener(MouseEvent.CLICK, dropBalls);
		emitter.addEventListener(EmitterEvent.EMITTER_EMPTY, showStartButton);
	}

	function showStartButton(event : Event) : Void
	{
		emitter.stop();
		startButton.visible = true;
	}

	function dropBalls(event : Event) : Void
	{
		if(!emitter.running) 
		{
			startButton.visible = false;
			emitter.start();
		}
	}

	function addPins() : Void
	{
		var pins : Array<Dynamic> = [241, 81, 222, 81, 213, 88, 208, 94, 202, 100, 198, 106, 195, 113, 187, 93, 182, 98, 178, 103, 175, 109, 173, 114, 172, 120, 171, 127, 149, 128, 149, 120, 147, 113, 145, 108, 142, 103, 137, 98, 132, 94, 127, 90, 121, 86, 242, 123, 238, 127, 234, 131, 230, 135, 226, 139, 214, 151, 132, 124, 114, 124, 96, 124, 123, 140, 105, 140, 87, 140, 114, 156, 96, 156, 78, 156, 123, 172, 105, 172, 87, 172, 69, 172, 114, 188, 96, 188, 78, 188, 60, 188, 105, 204, 87, 204, 69, 204, 96, 220, 78, 220, 135, 202, 130, 206, 126, 210, 122, 215, 118, 220, 115, 226, 113, 232, 111, 238, 20, 191, 24, 193, 28, 196, 32, 200, 36, 204, 39, 208, 42, 211, 44, 215, 47, 219, 50, 224, 52, 228, 54, 233, 56, 238, 151, 202, 157, 206, 162, 211, 166, 216, 169, 221, 172, 227, 174, 233, 175, 239, 196, 169, 232, 169, 250, 169, 169, 185, 187, 185, 205, 185, 223, 185, 241, 185, 178, 201, 196, 201, 232, 201, 250, 201, 187, 217, 241, 217, 250, 233, 143, 220, 134, 236, 152, 236, 143, 252, 55, 280, 73, 280, 91, 280, 109, 280, 127, 280, 46, 296, 64, 296, 82, 296, 100, 296, 118, 296, 136, 296, 55, 312, 73, 312, 91, 312, 109, 312, 127, 312, 64, 330, 82, 330, 100, 330, 118, 330, 136, 330, 164, 314, 164, 320, 164, 326, 164, 332, 164, 338, 164, 344, 164, 350, 163, 356, 161, 362, 158, 367, 154, 370, 149, 372, 186, 314, 208, 314, 186, 400, 208, 400, 176, 414, 218, 414, 186, 340, 186, 346, 186, 352, 186, 358, 185, 364, 183, 370, 180, 375, 176, 378, 171, 380, 208, 340, 208, 346, 208, 352, 208, 358, 209, 364, 211, 370, 214, 375, 218, 378, 223, 380, 223, 264, 241, 264, 232, 282, 250, 282, 241, 298, 232, 314, 250, 314, 241, 330, 232, 346, 250, 346, 241, 362, 250, 378];
		var i : Int = 0;
		while(i < pins.length)
		{
			addPin(pins[i], pins[i + 1]);
			if(x < 250) 
			{
				addPin(500 - pins[i], pins[i + 1]);
			}
			i += 2;
		}
	}

	function addPin(x : Float, y : Float) : Void
	{
		graphics.beginFill(0x999999);
		graphics.drawCircle(x - 10, y - 45, 1);
		graphics.endFill();
		emitter.addPin(x - 10, y - 45);
	}

}

