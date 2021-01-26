import flints.common.events.ParticleEvent;
import flints.common.particles.Particle;
import flints.twod.emitters.Emitter2D;
import flints.twod.renderers.PixelRenderer;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Rectangle;
import openfl.Vector;

@:meta(SWF(width="400",height="200",frameRate="60",backgroundColor="#000000"))
class Main extends Sprite
{

	var startEmitter : Emitter2D;
	var tween1Emitter : Emitter2D;
	var tween2Emitter : Emitter2D;
	public function new()
	{
    super ();

		startEmitter = new FirstEmitter();
		tween1Emitter = new TweenToFlint();
		tween2Emitter = new TweenToParticles();
		var renderer : PixelRenderer = new PixelRenderer(new Rectangle(0, 0, 400, 200));
		renderer.addFilter(new BlurFilter(2, 2, 1));
		renderer.addFilter(new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.97, 0]));
		renderer.addEmitter(startEmitter);
		renderer.addEmitter(tween1Emitter);
		renderer.addEmitter(tween2Emitter);
		addChild(renderer);
		startEmitter.addEventListener(ParticleEvent.PARTICLE_DEAD, moveToTween1);
		tween1Emitter.addEventListener(ParticleEvent.PARTICLE_DEAD, moveToTween2);
		tween2Emitter.addEventListener(ParticleEvent.PARTICLE_DEAD, moveToTween1);
		startEmitter.start();
		tween1Emitter.start();
		tween2Emitter.start();
	}

	function moveToTween1(event : ParticleEvent) : Void
	{
		event.particle.revive();
		tween1Emitter.addParticle(event.particle, true);
	}

	function moveToTween2(event : ParticleEvent) : Void
	{
		event.particle.revive();
		tween2Emitter.addParticle(event.particle, true);
	}

}

