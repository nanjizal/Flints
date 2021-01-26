import flints.common.events.EmitterEvent;
import flints.common.particles.Particle;
import flints.twod.actions.DeathZone;
import flints.twod.actions.Explosion;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.particles.Particle2DUtils;
import flints.twod.renderers.DisplayObjectRenderer;
import flints.twod.zones.RectangleZone;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Point;

@:meta(SWF(width="500",height="350",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter2D;
	var bitmap : BitmapData;
	var renderer : DisplayObjectRenderer;
	var explosion : Explosion;
	public function new()
	{
    super ();
  }

  function _init () : Void
  {
		bitmap = new Image1 (384, 255);
		emitter = new Emitter2D();
		emitter.addAction(new DeathZone(new RectangleZone(-5, -5, 505, 355), true));
		emitter.addAction(new Move());
		prepare();
		renderer = new DisplayObjectRenderer();
		addChild(renderer);
		renderer.addEmitter(emitter);
		emitter.start();
		stage.addEventListener(MouseEvent.CLICK, explode, false, 0, true);
		emitter.addEventListener(EmitterEvent.EMITTER_EMPTY, prepare);
	}

	function prepare(event : EmitterEvent = null) : Void
	{
		if(explosion != null) 
		{
			emitter.removeAction(explosion);
			explosion = null;
		}
		var particles = Particle2DUtils.createRectangleParticlesFromBitmapData(bitmap, 8, emitter.particleFactory, 56, 47);
		emitter.addParticles(particles, false);
	}

	function explode(ev : MouseEvent) : Void
	{
		if(explosion == null) 
		{
			var p : Point = renderer.globalToLocal(new Point(ev.stageX, ev.stageY));
			explosion = new Explosion(8, p.x, p.y, 500);
			emitter.addAction(explosion);
		}
	}

}

