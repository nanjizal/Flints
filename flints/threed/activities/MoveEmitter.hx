package flints.threed.activities;

import flints.threed.Vector3D;
import flints.common.activities.ActivityBase;
import flints.common.emitters.Emitter;
import flints.threed.emitters.Emitter3D;
import flints.threed.geom.Vector3DUtils;

/**
 * The MoveEmitter activity moves the emitter at a constant velocity.
 */
class MoveEmitter extends ActivityBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var velocity(get, set):Vector3D;
	
	private var _vel:Vector3D;
	
	/**
	 * The constructor creates a MoveEmitter activity for use by 
	 * an emitter. To add a MoveEmitter to an emitter, use the
	 * emitter's addActvity method.
	 * 
	 * @see flints.common.emitters.Emitter#addActivity()
	 * 
	 * @param x The x coordinate of the velocity to move the emitter, 
	 * in pixels per second.
	 * @param y The y coordinate of the velocity to move the emitter, 
	 * in pixels per second.
	 */
	public function new( velocity:Vector3D = null )
	{
		super();
		this.velocity = velocity != null ? velocity : new Vector3D();
	}
	
	/**
	 * The velocity to move the emitter, in pixels per second.
	 */
	private function get_velocity():Vector3D
	{
		return _vel;
	}
	private function set_velocity( value:Vector3D ):Vector3D
	{
		_vel = Vector3DUtils.cloneVector( value );
		return _vel;
	}
	
	/**
	 * The x coordinate of the velocity to move the emitter, in pixels per second.
	 */
	private function get_x():Float
	{
		return _vel.x;
	}
	private function set_x( value:Float ):Float
	{
		_vel.x = value;
		return value;
	}
	
	/**
	 * The y coordinate of  the velocity to move the emitter, in pixels per second.
	 */
	private function get_y():Float
	{
		return _vel.y;
	}
	private function set_y( value:Float ):Float
	{
		_vel.y = value;
		return value;
	}
	
	/**
	 * The z coordinate of the velocity to move the emitter, in pixels per second.
	 */
	private function get_z():Float
	{
		return _vel.z;
	}
	private function set_z( value:Float ):Float
	{
		_vel.z = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, time : Float ) : Void
	{
		var p:Vector3D = cast( emitter, Emitter3D ).position;
		p.x += _vel.x * time;
		p.y += _vel.y * time;
		p.z += _vel.z * time;
	}
}
