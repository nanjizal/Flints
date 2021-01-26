package flints.twod.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.twod.particles.Particle2D;

/**
 * The RotateVelocity Initializer sets the angular velocity of the particle.
 * It is usually combined with the Rotate action to rotate the particle
 * using this angular velocity.
 */

class RotateVelocity extends InitializerBase
{
	public var maxAngVelocity(get, set):Float;
	public var angVelocity(get, set):Float;
	public var minAngVelocity(get, set):Float;
	
	private var _max:Float;
	private var _min:Float;

	/**
	 * The constructor creates a RotateVelocity initializer for use by 
	 * an emitter. To add a RotateVelocity to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * <p>The angularVelocity of particles initialized by this class
	 * will be a random value between the minimum and maximum
	 * values set. If no maximum value is set, the minimum value
	 * is used with no variation.</p>
	 * 
	 * @param minAngVelocity The minimum angularVelocity, in 
	 * radians per second, for the particle's angularVelocity.
	 * @param maxAngVelocity The maximum angularVelocity, in 
	 * radians per second, for the particle's angularVelocity.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( minAngVelocity:Float = 0, maxAngVelocity:Float = 0 )
	{
		super();
		this.minAngVelocity = minAngVelocity;
		this.maxAngVelocity = maxAngVelocity;
	}
	
	/**
	 * The minimum angular velocity value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_minAngVelocity():Float
	{
		return _min;
	}
	private function set_minAngVelocity( value:Float ):Float
	{
		_min = value;
		return _min;
	}
	
	/**
	 * The maximum angular velocity value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_maxAngVelocity():Float
	{
		return _max;
	}
	private function set_maxAngVelocity( value:Float ):Float
	{
		_max = value;
		return _max;
	}
	
	/**
	 * When reading, returns the average of minAngVelocity and maxAngVelocity.
	 * When writing this sets both maxAngVelocity and minAngVelocity to the 
	 * same angular velocity value.
	 */
	private function get_angVelocity():Float
	{
		return _min == _max ? _min : ( _max + _min ) / 2;
	}
	private function set_angVelocity( value:Float ):Float
	{
		_max = _min = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		var p:Particle2D = cast( particle,Particle2D );
		if( Math.isNaN( _max ) )
		{
			p.angVelocity = _min;
		}
		else
		{
			p.angVelocity = _min + Math.random() * ( _max - _min );
		}
	}
}
