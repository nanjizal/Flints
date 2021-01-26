package flints.threed.actions;

// TODO: implement 3d Vector ?
import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;


/**
 * The Accelerate Action adjusts the velocity of the particle by a 
 * constant acceleration. This can be used, for example, to simulate
 * gravity.
 */
class Accelerate extends ActionBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var acceleration(get, set):Vector3D;
	
	private var _acc:Vector3D;
	
	/**
	 * The constructor creates an Acceleration action for use by an emitter. 
	 * To add an Accelerator to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param acceleration The acceleration to apply, in coordinate units 
	 * per second per second.
	 */
	public function new( acceleration:Vector3D = null )
	{
		super();
		this.acceleration = acceleration != null ? acceleration : new Vector3D();
	}
	
	/**
	 * The acceleration, in coordinate units per second per second.
	 */
	private function get_acceleration():Vector3D
	{
		return _acc;
	}
	private function set_acceleration( value:Vector3D ):Vector3D
	{
		_acc = value.clone();
		_acc.w = 0;
		return value;
	}
	
	/**
	 * The x coordinate of the acceleration, in
	 * coordinate units per second per second.
	 */
	private function get_x():Float
	{
		return _acc.x;
	}
	private function set_x( value:Float ):Float
	{
		_acc.x = value;
		return value;
	}
	
	/**
	 * The y coordinate of the acceleration, in
	 * coordinate units per second per second.
	 */
	private function get_y():Float
	{
		return _acc.y;
	}
	private function set_y( value:Float ):Float
	{
		_acc.y = value;
		return value;
	}
	
	/**
	 * The z coordinate of the acceleration, in
	 * coordinate units per second per second.
	 */
	private function get_z():Float
	{
		return _acc.z;
	}
	private function set_z( value:Float ):Float
	{
		_acc.z = value;
		return value;
	}
	
	/**
	 * Applies the acceleration to a particle for the specified time period.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var v:Vector3D = cast( particle, Particle3D ).velocity;
		v.x += _acc.x * time;
		v.y += _acc.y * time;
		v.z += _acc.z * time;
	}
}
