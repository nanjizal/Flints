package flints.threed.activities;

import flints.threed.Vector3D;
import flints.common.activities.ActivityBase;
import flints.common.emitters.Emitter;
import flints.threed.emitters.Emitter3D;
import flints.threed.geom.Quaternion;
import flints.threed.geom.Vector3DUtils;

/**
 * The RotateEmitter activity rotates the emitter at a constant rate.
 */
class RotateEmitter extends ActivityBase
{
	public var rotateSpeed(get, set):Float;
	public var axis(get, set):Vector3D;
	
	private var _rotateSpeed:Float;
	private var _axis:Vector3D;
	private var _angVel:Quaternion;
	private var temp:Quaternion;
	
	/**
	 * The constructor creates a RotateEmitter activity for use by 
	 * an emitter. To add a RotateEmitter to an emitter, use the
	 * emitter's addActvity method.
	 * 
	 * @see flints.common.emitters.Emitter#addActivity()
	 * 
	 * @para angularVelocity The angular velocity for the emitter in 
	 * radians per second.
	 */
	public function new( axis:Vector3D = null, rotateSpeed:Float = 0 )
	{
		super();
		_rotateSpeed = 0;
		temp = new Quaternion();
		_angVel = new Quaternion();
		this.rotateSpeed = rotateSpeed;
		if( axis != null )
		{
			this.axis = axis;
		}
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
		var temp:Vector3D = _axis.clone();
		temp.scaleBy( _rotateSpeed );
		setAngularVelocity( temp );
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
			var temp:Vector3D = _axis.clone();
			temp.scaleBy( _rotateSpeed );
			setAngularVelocity( temp );
		}
		return _rotateSpeed;
	}

	private function setAngularVelocity( value:Vector3D ):Void
	{
		_angVel.w = 0;
		_angVel.x = value.x * 0.5;
		_angVel.y = value.y * 0.5;
		_angVel.z = value.z * 0.5;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, time : Float ) : Void
	{
		var e:Emitter3D = cast( emitter, Emitter3D );
		temp.assign( _angVel );
		temp.postMultiplyBy( e.rotation );
		e.rotation.incrementBy( temp.scaleBy( time ) ).normalize();
	}
}
