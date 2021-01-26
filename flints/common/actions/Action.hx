package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.behaviours.Behaviour;
import flints.common.actions.Action;

/**
 * The Action interface must be implemented by all particle actions.
 * 
 * <p>An Action is a class that is used to continuously modify an aspect 
 * of a particle by updating the particle every frame. Actions may, for 
 * example, move the particle or modify its velocity.</p>
 * 
 * <p>Actions are directly associated with emitters and act on all
 * particles created or added to that emitter. Actions are applied to 
 * all particles created by an emitter by using the emitter's addAction 
 * method. Actions are removed from the emitter by using the emitter's
 * removeAction method.</p>
 * 
 * <p>The key method in the Action interface is the update method.
 * This is called every frame, for every particle and is where the
 * action modifies the particle's properties.</p>
 * 
 * @see flints.common.emitters.Emitter#addAction()
 * @see flints.common.emitters.Emitter#removeAction()
 */
interface Action extends Behaviour
{
	/**
	 * The update method is used by the emitter to apply the action
	 * to every particle. It is the key feature of the actions and is
	 * used to update the state of every particle every frame. This method 
	 * is called within the emitter's update loop for every particle 
	 * and need not be called by the user.
	 * 
	 * <p>Because the method is called for every particle, every frame it is
	 * a key area for optimization of the code. When creating a custom action
	 * it is usually worth making this method as efficient as possible.</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 */
	function update( emitter:Emitter, particle:Particle, time:Float ):Void;
}
