package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.Lifetime;
import flints.common.initializers.InitializerBase;

/**
 * The Lifetime Initializer sets a lifetime for the particle. It is
 * usually combined with the Age action to age the particle over its
 * lifetime and destroy the particle at the end of its lifetime.
 */
class Lifetime extends InitializerBase
{
	public var maxLifetime(get, set):Float;
	public var lifetime(get, set):Float;
	public var minLifetime(get, set):Float;
	
	private var _max:Float;
	private var _min:Float;
	
	/**
	 * The constructor creates a Lifetime initializer for use by 
	 * an emitter. To add a Lifetime to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * <p>The lifetime of particles initialized by this class
	 * will be a random value between the minimum and maximum
	 * values set. If no maximum value is set, the minimum value
	 * is used with no variation.</p>
	 * 
	 * @param minLifetime the minimum lifetime for particles
	 * initialized by the instance.
	 * @param maxLifetime the maximum lifetime for particles
	 * initialized by the instance.
	 * 
	 * @see Emitter.addInitializer.
	 */
	public function new( minnew:Float = 0.0, maxnew:Float = -1 )
	{
		super();
		_max = maxnew;
		_min = minnew;
	}
	
	/**
	 * The minimum lifetime for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_minLifetime():Float
	{
		return _min;
	}
	private function set_minLifetime( value:Float ):Float
	{
		_min = value;
		return _min;
	}
	
	/**
	 * The maximum lifetime for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_maxLifetime():Float
	{
		return _max;
	}
	private function set_maxLifetime( value:Float ):Float
	{
		_max = value;
		return _max;
	}
	
	/**
	 * When reading, returns the average of minLifetime and maxLifetime.
	 * When writing this sets both maxLifetime and minLifetime to the 
	 * same lifetime value.
	 */
	private function get_lifetime():Float
	{
		return _min == _max ? _min : ( _max + _min ) * 0.5;
	}
	private function set_lifetime( value:Float ):Float
	{
		_max = _min = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		if( _max < 0 )
		{
			particle.lifetime = _min;
		}
		else
		{
			particle.lifetime = _min + Math.random() * ( _max - _min );
		}
	}
}
