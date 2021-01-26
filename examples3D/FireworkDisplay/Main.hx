import flints.common.emitters.Emitter;
import flints.common.events.EmitterEvent;
import flints.common.events.ParticleEvent;
import flints.threed.emitters.Emitter3D;
import flints.threed.particles.Particle3D;
import flints.threed.renderers.BitmapRenderer;
import flints.threed.renderers.controllers.FirstPersonCamera;
import flints.threed.zones.LineZone;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Rectangle;
import openfl.geom.Vector3D;

@:meta(SWF(width="800",height="600",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var orbitter : FirstPersonCamera;
	var renderer : BitmapRenderer;
	public function new()
	{
		renderer = new BitmapRenderer(new Rectangle(-400, -300, 800, 600), false);
		renderer.x = 400;
		renderer.y = 300;
		renderer.addFilter(new BlurFilter(2, 2, 1));
		renderer.addFilter(new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.95, 0]));
		addChild(renderer);
		renderer.camera.position = new Vector3D(0, -150, -400);
		renderer.camera.target = new Vector3D(0, -150, 0);
		renderer.camera.projectionDistance = 400;
		orbitter = new FirstPersonCamera(stage, renderer.camera);
		orbitter.start();
		var emitter : Emitter3D = new Whizzer(new LineZone(new Vector3D(-200, 0, 0), new Vector3D(200, 0, 0)));
		renderer.addEmitter(emitter);
		emitter.addEventListener(ParticleEvent.PARTICLE_DEAD, whizzBang, false, 0, true);
		emitter.start();
		emitter = new Candle(new Vector3D(150, 0, 150));
		renderer.addEmitter(emitter);
		emitter.start();
		emitter = new Candle(new Vector3D(-150, 0, 150));
		renderer.addEmitter(emitter);
		emitter.start();
		emitter = new Candle(new Vector3D(150, 0, -150));
		renderer.addEmitter(emitter);
		emitter.start();
		emitter = new Candle(new Vector3D(-150, 0, -150));
		renderer.addEmitter(emitter);
		emitter.start();
		emitter = new CatherineWheel(new Vector3D(-200, -200, 50));
		renderer.addEmitter(emitter);
		emitter.start();
		emitter = new CatherineWheel(new Vector3D(0, -200, 50));
		renderer.addEmitter(emitter);
		emitter.start();
		emitter = new CatherineWheel(new Vector3D(200, -200, 50));
		renderer.addEmitter(emitter);
		emitter.start();
	}

	public function whizzBang(ev : ParticleEvent) : Void
	{
		var bang : Emitter3D = new SphereBang(cast((ev.particle), Particle3D).position);
		bang.addEventListener(EmitterEvent.EMITTER_EMPTY, removeEmitter, false, 0, true);
		renderer.addEmitter(bang);
		bang.start();
	}

	public function removeEmitter(ev : EmitterEvent) : Void
	{
		cast((ev.target), Emitter3D).removeEventListener(EmitterEvent.EMITTER_EMPTY, removeEmitter);
		renderer.removeEmitter(cast((ev.target), Emitter3D));
	}

	public function destroy() : Void
	{
		for(e in renderer.emitters/* AS3HX WARNING could not determine type for var: e exp: EField(EIdent(renderer),emitters) type: null*/)
		{
			e.stop();
		}

	}

}

