package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.MassInit;
import flints.common.initializers.InitializerBase;

/**
 * The MassInit Initializer sets the mass of the particle.
 */

class MassInit extends InitializerBase
{
	public var mass(get, set):Float;
	
	private var _mass:Float;
	
	/**
	 * The constructor creates a MassInit initializer for use by 
	 * an emitter. To add a MassInit to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param mass the mass for particles
	 * initialized by the instance.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( mass:Float = 1 )
	{
		super();
		_mass = mass;
	}
	
	/**
	 * When reading, returns the average of minMass and maxMass.
	 * When writing this sets both minMass and maxMass to the 
	 * same mass value.
	 */
	private function get_mass():Float
	{
		return _mass;
	}
	private function set_mass( value:Float ):Float
	{
		_mass = value;
		return _mass;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		particle.mass = _mass;
	}
}
