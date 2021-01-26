package flints.twod.activities;

import flints.common.activities.ActivityBase;
import flints.common.emitters.Emitter;
import flints.twod.emitters.Emitter2D;

/**
 * The RotateEmitter activity rotates the emitter at a constant rate.
 */
class RotateEmitter extends ActivityBase
{
	public var angularVelocity(get, set):Float;
	
	private var _angularVelocity:Float;
	
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
	public function new( angularVelocity:Float = 0 )
	{
		super();
		this.angularVelocity = angularVelocity;
	}
	
	/**
	 * The angular velocity for the emitter in 
	 * radians per second.
	 */
	private function get_angularVelocity():Float
	{
		return _angularVelocity;
	}
	private function set_angularVelocity( value:Float ):Float
	{
		_angularVelocity = value;
		return _angularVelocity;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, time : Float ) : Void
	{
		var e:Emitter2D = cast( emitter,Emitter2D );
		e.rotRadians += _angularVelocity * time;
	}
}
