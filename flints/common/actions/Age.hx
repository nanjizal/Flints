package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.easing.Linear;
import flints.common.actions.Age;
import flints.common.actions.ActionBase;

/**
 * The Age action operates in conjunction with the Lifetime 
 * initializer. The Lifetime initializer sets the lifetime for
 * the particle. The Age action then ages the particle over time,
 * altering its energy to reflect its age. This energy can then
 * be used by actions like Fade and ColorChange to alter the
 * appearence of the particle as it ages.
 * 
 * <p>The aging process need not be linear. This action can use
 * a function that modifies the aging process, to ease in or out or 
 * to alter the aging in other ways.</p>
 * 
 * <p>When the particle's lifetime is over, this action marks it 
 * as dead.</p>
 * 
 * <p>When adjusting the energy this action can use any of the
 * easing functions in the flints.common.energy package
 * along with any custom easing functions that have the same interface.</p>
 * 
 * @see flints.common.actions.Action
 * @see flints.common.initializers.Lifetime
 * @see flints.common.energy
 */
class Age extends ActionBase
{
	
	public var easing(get, set):Dynamic;
	
	private var _easing:Dynamic;
	
	/**
	 * The constructor creates an Age action for use by an emitter. 
	 * To add an Age to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @param easing an easing function to use to modify the 
	 * energy curve over the lifetime of the particle. The default
	 * null produces a linear response with no easing.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 */
	public function new( easing:Dynamic = null )
	{
		super();
		if ( easing == null )
		{
			_easing = Linear.easeNone;
		}
		else
		{
			_easing = easing;
		}
	}
	
	/**
	 * The easing function used to modify the energy over the 
	 * lifetime of the particle.
	 */
	private function get_easing():Dynamic
	{
		return _easing;
	}
	private function set_easing( value:Dynamic ):Dynamic
	{
		_easing = value;
		return _easing;
	}
	
	/**
	 * Sets the energy of the particle based on its age and the easing function.
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
		particle.age += time;
		if( particle.age >= particle.lifetime )
		{
			particle.energy = 0;
			particle.isDead = true;
		}
		else
		{
			particle.energy = _easing( particle.age, 1, -1, particle.lifetime );
		}
	}
}
