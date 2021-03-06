package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The TargetVelocity action adjusts the velocity of the particle towards the target velocity.
 */
class TargetVelocity extends ActionBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var rate(get, set):Float;
	public var targetVelocity(get, set):Vector3D;
	
	private var _vel:Vector3D;
	private var _rate:Float;
	
	/**
	 * The constructor creates a TargetVelocity action for use by 
	 * an emitter. To add a TargetVelocity to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param velX The x coordinate of the target velocity, in pixels per second.
	 * @param velY The y coordinate of the target velocity, in pixels per second.
	 * @param rate Adjusts how quickly the particle reaches the target velocity.
	 * Larger numbers cause it to approach the target velocity more quickly.
	 */
	public function new( targetVelocity:Vector3D = null, rate:Float = 0.1 )
	{
		super();
		this.targetVelocity = targetVelocity != null ? targetVelocity : new Vector3D();
		this.rate = rate;
	}
	
	/**
	 * The x coordinate of the target velocity, in pixels per second.s
	 */
	private function get_targetVelocity():Vector3D
	{
		return _vel;
	}
	private function set_targetVelocity( value:Vector3D ):Vector3D
	{
		_vel = Vector3DUtils.cloneVector( value );
		return _vel;
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
		return value;
	}
	
	/**
	 * The x coordinate of the target velocity.
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
	 * The y coordinate of  the target velocity.
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
	 * The z coordinate of the target velocity.
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
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var v:Vector3D = cast( particle, Particle3D ).velocity;
		var c:Float = _rate * time;
		v.x += ( _vel.x - v.x ) * c;
		v.y += ( _vel.y - v.y ) * c;
		v.z += ( _vel.z - v.z ) * c;
	}
}
