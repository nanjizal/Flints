package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.particles.Particle2D;

/**
 * The DeathSpeed action marks the particle as dead if it is travelling faster 
 * than the specified speed. The behaviour can be switched to instead mark as 
 * dead particles travelling slower than the specified speed.
 */

class DeathSpeed extends ActionBase
{
	public var isMinimum(get, set):Bool;
	public var limit(get, set):Float;
	
	private var _limit:Float;
	private var _limitSq:Float;
	private var _isMinimum:Bool;
	
	/**
	 * The constructor creates a DeathSpeed action for use by an emitter. 
	 * To add a DeathSpeed to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param speed The speed limit for the action in pixels per second.
	 * @param isMinimum If true, particles travelling slower than the speed limit
	 * are killed, otherwise particles travelling faster than the speed limit are
	 * killed.
	 */
	public function new( speed:Float = 1000, isMinimum:Bool = false )
	{
		super();
		this.limit = speed;
		this.isMinimum = isMinimum;
	}
	
	/**
	 * The speed limit beyond which the particle dies.
	 */
	public function get_limit():Float
	{
		return _limit;
	}
	public function set_limit( value:Float ):Float
	{
		_limit = value;
		_limitSq = value * value;
		return _limit;
	}
	
	/**
	 * Whether the speed is a minimum (true) or maximum (false) speed.
	 */
	public function get_isMinimum():Bool
	{
		return _isMinimum;
	}
	public function set_isMinimum( value:Bool ):Bool
	{
		_isMinimum = value;
		return _isMinimum;
	}
	
	/**
	 * Checks the particle's speed and marks it as dead if it is moving faster 
	 * than the speed limit, if this is a mximum speed limit, or slower if 
	 * this is a minimum speed limit.
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
		var p:Particle2D = cast( particle,Particle2D );
		var speedSq:Float = p.velX * p.velX + p.velY * p.velY;
		if ( ( _isMinimum && speedSq < _limitSq ) || ( !_isMinimum && speedSq > _limitSq ) )
		{
			p.isDead = true;
		}
	}
}
