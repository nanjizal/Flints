package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.Initializer;
import flints.common.behaviours.Behaviour;

/**
 * The Initializer interface must be implemented by all particle initializers.
 * 
 * <p>An Initializer is a class that is used to set properties of a particle 
 * when it is created. Initializers may, for example, set an initial velocity
 * for a particle.</p>
 * 
 * <p>Initializers are directly associated with emitters and act on all
 * particles created by that emitter. Initializers are applied to 
 * all particles created by an emitter by using the emitter's addInitializer 
 * method. Initializers are removed from the emitter by using the emitter's
 * removeInitializer method.</p>
 * 
 * <p>The key method in the Initializer interface is the initiaize method.
 * This is called for every particle and is where the initializer modifies 
 * the particle's properties.</p>
 * 
 * @see flints.common.emitters.Emitter#addInitializer()
 * @see flints.common.emitters.Emitter#removeInitializer()
 */
interface Initializer extends Behaviour
{
	/**
	 * The initialize method is used by the emitter to apply the initialization
	 * to every particle. It is the key feature of the initializers and is
	 * used to initialize the state of every particle. This method 
	 * is called within the emitter's createParticle method for every particle 
	 * and need not be called by the user.
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be initialized.
	 */
	function initialize( emitter:Emitter, particle:Particle ):Void;
}
