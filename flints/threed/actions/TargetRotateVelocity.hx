package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The TargetRotateVelocity action adjusts the angular velocity of the particle towards the target angular velocity.
 */
class TargetRotateVelocity extends ActionBase
{
	public var rotateSpeed(get, set):Float;
	public var rate(get, set):Float;
	public var axis(get, set):Vector3D;
	
	private var _rotateSpeed:Float;
	private var _axis:Vector3D;
	private var _angVel:Vector3D;
	private var _rate:Float;
	
	/**
	 * The constructor creates a TargetRotateVelocity action for use by 
	 * an emitter. To add a TargetRotateVelocity to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param axis The axis the velocity acts around.
	 * @param angVelocity The target angular velocity, in radians per second.
	 * @param rate Adjusts how quickly the particle reaches the target angular velocity.
	 * Larger numbers cause it to approach the target angular velocity more quickly.
	 */
	public function new( axis:Vector3D = null, rotateSpeed:Float = 0, rate:Float = 0.1 )
	{
		super();
		_rotateSpeed = 0;
		this.rotateSpeed = rotateSpeed;
		if( axis != null )
		{
			this.axis = axis;
		}
		this.rate = rate;
	}
	
	/**
	 * Adjusts how quickly the particle reaches the target angular velocity.
	 * Larger numbers cause it to approach the target angular velocity more quickly.
	 */
	private function get_rate():Float
	{
		return _rate;
	}
	private function set_rate( value:Float ):Float
	{
		_rate = value;
		return _rate;
	}
	
	/**
	 * The axis for the target angular velocity.
	 */
	private function get_axis():Vector3D
	{
		return _axis;
	}
	private function set_axis( value:Vector3D ):Vector3D
	{
		_axis = Vector3DUtils.cloneUnit( value );
		_angVel = _axis.clone();
		_angVel.scaleBy( _rotateSpeed );
		return _axis;
	}
	
	/**
	 * The size of the target angular velocity.
	 */
	private function get_rotateSpeed():Float
	{
		return _rotateSpeed;
	}
	private function set_rotateSpeed( value:Float ):Float
	{
		_rotateSpeed = value;
		if( _axis != null )
		{
			_angVel = _axis.clone();
			_angVel.scaleBy( _rotateSpeed );
		}
		return _rotateSpeed;
	}

	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var v:Vector3D = cast( particle, Particle3D ).angVelocity;
		var c:Float = _rate * time;
		v.x += ( _angVel.x - v.x ) * c;
		v.y += ( _angVel.y - v.y ) * c;
		v.z += ( _angVel.z - v.z ) * c;
	}
}
