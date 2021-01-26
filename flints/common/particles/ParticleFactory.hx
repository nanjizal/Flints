package flints.common.particles;

import flints.common.particles.Particle;
import flints.common.particles.ParticleFactory;

/**
 * The ParticleFactory interface defines the interface for any factory class used by emitters to 
 * create, reuse and dispose of particles. To speed up the particle system, a ParticleFactory will
 * usually maintain a pool of dead particles and reuse them when a new particle is needed, rather 
 * than creating a whole new particle. The default ParticleFactory used by the Emitter is an 
 * instance of the appropriate ParticleCreator class.
 * 
 * @see flints.twoD.particles.ParticleCreator2D
 * @see flints.threeD.particles.ParticleCreator3D
 */

interface ParticleFactory 
{
	/**
	 * To obtain a new Particle object. If using a pool of particles the particle factory will usually return 
	 * a particle from the pool and only creates a new particle if the pool is empty.
	 * 
	 * @return a Particle object.
	 */
	function createParticle():Particle;
	
	/**
	 * Indicates a particle is no longer required. If using a pool of particles the particle factory will 
	 * return the particle to the pool for reuse later.
	 * 
	 * @param particle The particle to return for reuse.
	 */
	function disposeParticle( particle:Particle ):Void;

	/**
	 * Clear all cached particles from the factory
	 */
	function clearAllParticles():Void;
}
