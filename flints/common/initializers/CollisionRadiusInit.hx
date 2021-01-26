package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.CollisionRadiusInit;

/**
 * The CollisionRadiusInit Initializer sets the collision radius of the particle.
 * During collisions the particle is treated as a sphere (3D) or circle (2D), regardless of its actual
 * shape. This sets the size of that sphere or circle.
 */

class CollisionRadiusInit extends InitializerBase
{
	public var radius(get, set):Float;
	private var _radius:Float;
	
	/**
	 * The constructor creates a CollisionRadiusInit initializer for use by 
	 * an emitter. To add a CollisionRadiusInit to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param radius The collision radius for particles
	 * initialized by the instance.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( radius:Float = 1 )
	{
		super();
		_radius = radius;
	}
	
	/**
	 * The collision radius for particles
	 * initialized by the instance.
	 */
	private function get_radius():Float
	{
		return _radius;
	}
	private function set_radius( value:Float ):Float
	{
		_radius = value;
		return _radius;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		particle.collisionRadius = _radius;
	}
}
