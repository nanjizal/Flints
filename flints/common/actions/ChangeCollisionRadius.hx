package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.ChangeCollisionRadius;
import flints.common.actions.ActionBase;

/**
 * The ChangeCollisionRadius action adjusts the collision radius of the particle as it ages.
 * It uses the particle's energy level to decide what radius the particle
 * should have.
 * 
 * <p>Usually a particle's energy changes from 1 to 0 over its lifetime, but
 * this can be altered via the easing function set within the age action.</p>
 * 
 * <p>This action should be used in conjunction with the Age action.</p>
 * 
 * @see flints.common.actions.Action
 * @see flints.common.actions.Age
 */

class ChangeCollisionRadius extends ActionBase
{
	
	public var startRadius(get, set):Float;
	public var endRadius(get, set):Float;
	
	private var _diffRadius:Float;
	private var _endRadius:Float;
	
	/**
	 * The constructor creates a ChangeCollisionRadius action for use by an emitter. 
	 * To add a Radius to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param startRadius The collision radius for the particle when its energy
	 * is 1 - usually at the start of its lifetime.
	 * @param endRadius The collision radius for the particle when its energy
	 * is 0 - usually at the end of its lifetime.
	 */
	public function new( startRadius:Float = 1, endRadius:Float = 1 )
	{
		super();
		_diffRadius = startRadius - endRadius;
		_endRadius = endRadius;
	}
	
	/**
	 * The collision radius for the particle when its energy
	 * is 1 - usually at the start of its lifetime.
	 */
	private function get_startRadius():Float
	{
		return _endRadius + _diffRadius;
	}
	private function set_startRadius( value:Float ):Float
	{
		_diffRadius = value - _endRadius;
		return _diffRadius;
	}
	
	/**
	 * The collision radius for the particle when its energy
	 * is 0 - usually at the end of its lifetime.
	 */
	private function get_endRadius():Float
	{
		return _endRadius;
	}
	private function set_endRadius( value:Float ):Float
	{
		_diffRadius = _endRadius + _diffRadius - value;
		_endRadius = value;
		return _endRadius;
	}
	
	/**
	 * Sets the collision radius of the particle based on the values defined
	 * and the particle's energy level.
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
		particle.collisionRadius = _endRadius + _diffRadius * particle.energy;
	}
}
