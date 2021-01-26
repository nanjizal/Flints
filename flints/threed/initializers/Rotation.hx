package flints.threed.initializers;

import flints.threed.Vector3D;
import flints.common.emitters.Emitter;
import flints.common.particles.Particle;
import flints.common.initializers.InitializerBase;
import flints.threed.geom.Quaternion;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The Rotation Initializer sets the rotation of the particle. The rotation is
 * relative to the rotation of the emitter.
 */

class Rotation extends InitializerBase
{
	public var angle(get, set):Float;
	public var maxAngle(get, set):Float;
	public var minAngle(get, set):Float;
	public var axis(get, set):Vector3D;
	
	private var _axis : Vector3D;
	private var _min : Float;
	private var _max : Float;
	private var _rot:Quaternion;

	/**
	 * The constructor creates a Rotation initializer for use by 
	 * an emitter. To add a Rotation to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * <p>The rotation of particles initialized by this class
	 * will be a random value between the minimum and maximum
	 * values set. If no maximum value is set, the minimum value
	 * is used with no variation.</p>
	 * 
	 * @param axis The axis around which the rotation occurs.
	 * @param minAngle The minimum angle, in radians, for the particle's rotation.
	 * @param maxAngle The maximum angle, in radians, for the particle's rotation.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( axis:Vector3D = null, minAngle:Float = 0, maxAngle:Float = -1 )
	{
		super();
		_rot = new Quaternion();
		this.axis = axis != null ? axis : Vector3D.Z_AXIS;
		this.minAngle = minAngle;
		this.maxAngle = maxAngle;
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
	 * The minimum angle for particles initialised by 
	 * this initializer.
	 */
	private function get_minAngle():Float
	{
		return _min;
	}
	private function set_minAngle( value:Float ):Float
	{
		_min = value;
		return value;
	}
	
	/**
	 * The maximum angle for particles initialised by 
	 * this initializer.
	 */
	private function get_maxAngle():Float
	{
		return _max;
	}
	private function set_maxAngle( value:Float ):Float
	{
		_max = value;
		return value;
	}
	
	/**
	 * When reading, returns the average of minAngle and maxAngle.
	 * When writing this sets both maxAngle and minAngle to the 
	 * same angle value.
	 */
	private function get_angle():Float
	{
		if( Math.isNaN( _max ) || _min == _max )
		{
			return _min;
		}
		return ( _max + _min ) / 2;
	}
	private function set_angle( value:Float ):Float
	{
		_max = _min = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter : Emitter, particle : Particle ) : Void
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
		_rot.setFromAxisRotation( _axis, angle );
		p.rotation.preMultiplyBy( _rot );
	}
}
