package flints.twod.particles;

import openfl.Vector;
import flints.common.debug.ParticleFactoryStats;
import flints.common.particles.ParticleFactory;
import flints.common.particles.Particle;

/**
 * The ParticleCreator is used by the Emitter class to manage the creation and reuse of particles.
 * To speed up the particle system, the ParticleCreator class maintains a pool of dead particles 
 * and reuses them when a new particle is needed, rather than creating a whole new particle.
 */

class ParticleCreator2D implements ParticleFactory
{
	private var _particles:Vector<Particle>;
	
	/**
	 * The constructor creates a ParticleCreator object.
	 */
	public function new()
	{
		_particles = new Vector<Particle>();
	}
	
	/**
	 * Obtains a new Particle object. The createParticle method will return
	 * a dead particle from the poll of dead particles or create a new particle if none are
	 * available.
	 * 
	 * @return a Particle object.
	 */
	public function createParticle():Particle
	{
		ParticleFactoryStats.numParticles++;
		if ( _particles.length > 0 )
		{
			return _particles.pop();
		}
		else
		{
			return new Particle2D();
		}
	}
	
	/**
	 * Returns a particle to the particle pool for reuse
	 * 
	 * @param particle The particle to return for reuse.
	 */
	public function disposeParticle( particle:Particle ):Void
	{
		ParticleFactoryStats.numParticles--;
		if( Std.is( particle, Particle2D ) )
		{
			particle.initialize();
			_particles.push( particle );
		}
	}

	/**
	 * Empties the particle pool.
	 */
	public function clearAllParticles():Void
	{
		_particles = new Vector<Particle>();
	}
}
