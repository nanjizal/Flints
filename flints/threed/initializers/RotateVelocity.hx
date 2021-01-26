package flints.threed.initializers;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The RotateVelocity Initializer sets the angular velocity of the particle.
 * It is usually combined with the Rotate action to rotate the particle
 * using this angular velocity.
 */

class RotateVelocity extends InitializerBase
{
	public var maxAngVelocity(get, set):Float;
	public var angVelocity(get, set):Float;
	public var axis(get, set):Vector3D;
	public var minAngVelocity(get, set):Float;
	
	private var _max:Float;
	private var _min:Float;
	private var _axis : Vector3D;

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
	public function new( axis:Vector3D = null, minAngVelocity:Float = 0, maxAngVelocity:Float = -1 )
	{
		super();
		this.axis = axis;
		this.minAngVelocity = minAngVelocity;
		this.maxAngVelocity = maxAngVelocity;
	}
	
	/**
	 * The axis for the rotation.
	 */
	private function get_axis():Vector3D
	{
		return _axis;
	}
	private function set_axis( value:Vector3D ):Vector3D
	{
		_axis = Vector3DUtils.cloneUnit( value );
		return _axis;
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
		return value;
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
		return value;
	}
	
	/**
	 * When reading, returns the average of minAngVelocity and maxAngVelocity.
	 * When writing this sets both maxAngVelocity and minAngVelocity to the 
	 * same angular velocity value.
	 */
	public function get_angVelocity():Float
	{
		if( Math.isNaN( _max ) || _min == _max )
		{
			return _min;
		}
		return ( _max + _min ) / 2;
	}
	public function set_angVelocity( value:Float ):Float
	{
		_max = _min = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var angle:Float;
		if( Math.isNaN( _max ) || _min == _max )
		{
			angle = _min;
		}
		else
		{
			angle = _min + Math.random() * ( _max - _min );
		}
		var v:Vector3D = p.angVelocity;
		v.x = axis.x * angle;
		v.y = axis.y * angle;
		v.z = axis.z * angle;
	}
}
