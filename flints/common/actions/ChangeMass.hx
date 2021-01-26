package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.ChangeMass;
import flints.common.actions.ActionBase;

/**
 * The ChangeMass action adjusts the mass of the particle as it ages.
 * It uses the particle's energy level to decide what mass the particle
 * should be.
 * 
 * <p>Usually a particle's energy changes from 1 to 0 over its lifetime, but
 * this can be altered via the easing function set within the age action.</p>
 * 
 * <p>This action should be used in conjunction with the Age action.</p>
 * 
 * @see flints.common.actions.Action
 * @see flints.common.actions.Age
 */

class ChangeMass extends ActionBase
{
	public var startMass(get, set):Float;
	public var endMass(get, set):Float;
	
	private var _diffMass:Float;
	private var _endMass:Float;
	
	/**
	 * The constructor creates a ChangeMass action for use by an emitter. 
	 * To add a Mass to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param startMass The mass for the particle when its energy
	 * is 1 - usually at the start of its lifetime.
	 * @param endMass The mass for the particle when its energy
	 * is 0 - usually at the end of its lifetime.
	 */
	public function new( startMass:Float = 1, endMass:Float = 1 )
	{
		super();
		_diffMass = startMass - endMass;
		_endMass = endMass;
	}
	
	/**
	 * The mass for the particle when its energy
	 * is 1 - usually at the start of its lifetime.
	 */
	private function get_startMass():Float
	{
		return _endMass + _diffMass;
	}
	private function set_startMass( value:Float ):Float
	{
		_diffMass = value - _endMass;
		return _diffMass;
	}
	
	/**
	 * The mass for the particle when its energy
	 * is 0 - usually at the end of its lifetime.
	 */
	private function get_endMass():Float
	{
		return _endMass;
	}
	private function set_endMass( value:Float ):Float
	{
		_diffMass = _endMass + _diffMass - value;
		_endMass = value;
		return _endMass;
	}
	
	/**
	 * Sets the mass of the particle based on the values defined
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
		particle.mass = _endMass + _diffMass * particle.energy;
	}
}
