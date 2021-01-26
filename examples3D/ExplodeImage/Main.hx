import flints.common.events.EmitterEvent;
import flints.common.particles.Particle;
import flints.threed.actions.DeathZone;
import flints.threed.actions.Explosion;
import flints.threed.actions.Move;
import flints.threed.emitters.Emitter3D;
import flints.threed.particles.Particle3DUtils;
import flints.threed.renderers.DisplayObjectRenderer;
import flints.threed.zones.FrustrumZone;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.geom.Vector3D;

@:meta(SWF(width="500",height="350",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var emitter : Emitter3D;
	var bitmap : BitmapData;
	var renderer : DisplayObjectRenderer;
	var explosion : Explosion;
	public function new()
	{
		bitmap = new Image1(384, 255);
		renderer = new DisplayObjectRenderer();
		renderer.camera.dolly(-400);
		renderer.camera.projectionDistance = 400;
		renderer.y = 175;
		renderer.x = 250;
		addChild(renderer);
		emitter = new Emitter3D();
		emitter.addAction(new Move());
		emitter.addAction(new DeathZone(new FrustrumZone(renderer.camera, new Rectangle(-290, -215, 580, 430)), true));
		prepare();
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
		var particles : Array<Particle> = Particle3DUtils.createRectangleParticlesFromBitmapData(bitmap, 12, emitter.particleFactory, new Vector3D(-192, -127, 0));
		emitter.addParticles(particles, false);
	}

	function explode(ev : MouseEvent) : Void
	{
		if(explosion == null) 
		{
			var p : Point = renderer.globalToLocal(new Point(ev.stageX, ev.stageY));
			explosion = new Explosion(8, new Vector3D(p.x, p.y, 50), 500);
			emitter.addAction(explosion);
		}
	}

}

