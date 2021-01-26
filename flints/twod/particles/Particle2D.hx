package flints.twod.particles;

import openfl.geom.Matrix;
import flints.common.particles.Particle;
import flints.common.particles.ParticleFactory;

/**
 * The Particle class is a set of public properties shared by all particles.
 * It is deliberately lightweight, with only one method. The Initializers
 * and Actions modify these properties directly. This means that the same
 * particles can be used in many different emitters, allowing Particle 
 * objects to be reused.
 * 
 * Particles are usually created by the ParticleCreator class. This class
 * just simplifies the reuse of Particle objects which speeds up the
 * application. 
 */
class Particle2D extends Particle
{
	public var matrixTransform(get, never):Matrix;
	public var inertia(get, never):Float;
	
	/**
	 * The x coordinate of the particle in pixels.
	 */
	public var x:Float;
	/**
	 * The y coordinate of the particle in pixels.
	 */
	public var y:Float;
	/**
	 * The x coordinate of the particle prior to the latest update.
	 */
	public var previousX:Float;
	/**
	 * The y coordinate of the particle prior to the latest update.
	 */
	public var previousY:Float;
	/**
	 * The x coordinate of the velocity of the particle in pixels per second.
	 */
	public var velX:Float;
	/**
	 * The y coordinate of the velocity of the particle in pixels per second.
	 */
	public var velY:Float;
	
	/**
	 * The rotation of the particle in radians.
	 */
	public var rotation:Float;
	/**
	 * The angular velocity of the particle in radians per second.
	 */
	public var angVelocity:Float;

	private var _previousMass:Float;
	private var _previousRadius:Float;
	private var _inertia:Float;
	
	/**
	 * The moment of inertia of the particle about its center point
	 */
	private function get_inertia():Float
	{
		if( mass != _previousMass || collisionRadius != _previousRadius )
		{
			_inertia = mass * collisionRadius * collisionRadius * 0.5;
			_previousMass = mass;
			_previousRadius = collisionRadius;
		}
		return _inertia;
	}

	/**
	 * The position in the emitter's horizontal spacial sorted array
	 */
	public var sortID:Int;
	
	/**
	 * Creates a particle. Alternatively particles can be reused by using the ParticleCreator to create
	 * and manage them. Usually the emitter will create the particles and the user doesn't need
	 * to create them.
	 */
	public function new()
	{
		super();
		sortID = -1;
		x = 0;
		y = 0;
		previousX = 0;
		previousY = 0;
		velX = 0;
		velY = 0;
		rotation = 0;
		angVelocity = 0;
	}
	
	/**
	 * Sets the particles properties to their default values.
	 */
	override public function initialize():Void
	{
		super.initialize();
		x = 0;
		y = 0;
		previousX = 0;
		previousY = 0;
		velX = 0;
		velY = 0;
		rotation = 0;
		angVelocity = 0;
		sortID = -1;
	}
	
	/**
	 * A transformation matrix for the position, scale and rotation of the particle.
	 */
	private function get_matrixTransform():Matrix
	{
		var cos:Float = scale * Math.cos( rotation );
		var sin:Float = scale * Math.sin( rotation );
		return new Matrix( cos, sin, -sin, cos, x, y );
	}
	
	/**
	 * @inheritDoc
	 */
	override public function clone( factory:ParticleFactory = null ):Particle
	{
		var p:Particle2D;
		if( factory != null )
		{
			p = cast( factory.createParticle(), Particle2D );
		}
		else
		{
			p = new Particle2D();
		}
		cloneInto( p );
		p.x = x;
		p.y = y;
		p.velX = velX;
		p.velY = velY;
		p.rotation = rotation;
		p.angVelocity = angVelocity;
		return p;
	}
}
