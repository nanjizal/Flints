package flints.twod.emitters;

import flints.common.emitters.Emitter;
import flints.common.particles.Particle;
import flints.common.particles.ParticleFactory;
import flints.common.utils.Maths;
import flints.twod.particles.Particle2D;
import flints.twod.particles.ParticleCreator2D;

/**
 * The Emitter class manages the creation and ongoing state of particles. It uses a number of
 * utility classes to customise its behaviour.
 *
 * <p>An emitter uses Initializers to customise the initial state of particles
 * that it creates, their position, velocity, color etc. These are added to the
 * emitter using the addInitializer  method.</p>
 *
 * <p>An emitter uses Actions to customise the behaviour of particles that
 * it creates, to apply gravity, drag, fade etc. These are added to the emitter
 * using the addAction method.</p>
 *
 * <p>An emitter uses Activities to customise its own behaviour in an ongoing manner, to
 * make it move or rotate.</p>
 *
 * <p>An emitter uses a Counter to know when and how many particles to emit.</p>
 *
 * <p>An emitter uses a Renderer to display the particles on screen.</p>
 *
 * <p>All timings in the emitter are based on actual time passed, not on frames.</p>
 *
 * <p>Most functionality is best added to an emitter using Actions,
 * Initializers, Activities, Counters and Renderers. This offers greater
 * flexibility to combine behaviours witout needing to subclass
 * the Emitter itself.</p>
 *
 * <p>The emitter also has position properties - x, y, rotation - that can be used to directly
 * affect its location in the particle system.</p>
 */
class Emitter2D extends Emitter {
	public var x(get, set):Float;
	//public var defaultParticleFactory(defaultParticleFactoryGetter,null):ParticleFactory;
	public var y(get, set):Float;
	public var rotation(get, set):Float;
	public var rotRadians(get, set):Float;

	/**
	 * @private
	 *
	 * default factory to manage the creation, reuse and destruction of particles
	 */
	private static var _creator:ParticleCreator2D = new ParticleCreator2D();

	/**
	 * The default particle factory used to manage the creation, reuse and destruction of particles.
	 */
	public static function defaultParticleFactoryGetter():ParticleFactory {
		return _creator;
	}

	/**
	 * @private
	 */
	private var _x:Float;

	/**
	 * @private
	 */
	private var _y:Float;

	/**
	 * @private
	 */
	private var _rotation:Float; // N.B. Is in radians

	/**
	 * Identifies whether the particles should be arranged
	 * into spacially sorted arrays - this speeds up proximity
	 * testing for those actions that need it.
	 */
	public var spaceSort:Bool;

	/**
	 * The constructor creates an emitter.
	 */
	public function new() {
		super();
		this._x = 0;
		this._y = 0;
		this._rotation = 0;
		this.spaceSort = false;
		_particleFactory = _creator;
	}

	/**
	 * Indicates the x coordinate of the Emitter within the particle system's coordinate space.
	 */
	private function get_x():Float {
		return _x;
	}

	private function set_x(value:Float):Float {
		_x = value;
		return value;
	}

	/**
	 * Indicates the y coordinate of the Emitter within the particle system's coordinate space.
	 */
	private function get_y():Float {
		return _y;
	}

	private function set_y(value:Float):Float {
		_y = value;
		return value;
	}

	/**
	 * Indicates the rotation of the Emitter, in degrees, within the particle system's coordinate space.
	 */
	private function get_rotation():Float {
		return Maths.asDegrees(_rotation);
	}

	private function set_rotation(value:Float):Float {
		_rotation = Maths.asRadians(value);
		return value;
	}

	/**
	 * Indicates the rotation of the Emitter, in radians, within the particle system's coordinate space.
	 */
	private function get_rotRadians():Float {
		return _rotation;
	}

	private function set_rotRadians(value:Float):Float {
		_rotation = value;
		return value;
	}

	/**
	 * Used internally to initialise the position and rotation of a particle relative to the emitter.
	 */
	override private function initParticle(particle:Particle):Void {
		var p:Particle2D = cast(particle, Particle2D);
		p.x = _x;
		p.y = _y;
		p.previousX = _x;
		p.previousY = _y;
		p.rotation = _rotation;
	}

	/**
	 * Used internally and in derived classes to update the emitter.
	 * @param time The duration, in seconds, of the current frame.
	 */
	override private function sortParticles():Void {
		if (spaceSort) {
			/**
			 * TODO: sort on, check if this works
			 */
			_particles.sort((a, b) -> Reflect.compare(cast(a, Particle2D).x, cast(b, Particle2D).x));

			for (i in 0..._particles.length) {
				cast(_particles[i], Particle2D).sortID = i;
			}
		}
	}
}
