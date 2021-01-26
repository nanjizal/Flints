package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints..common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The Move action updates the position of the particle based on its velocity.
 * It uses a Euler integrator to calculate the new position, hence the name.
 * 
 * <p>This action has a priority of -10, so that it executes after other actions.</p>
 */
class Move extends ActionBase
{
	/**
	 * The constructor creates a Move action for use by 
	 * an emitter. To add a Move to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 */
	public function new()
	{
		super();
		priority = -10;
	}

	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Vector3D = cast( particle, Particle3D ).position;
		var v:Vector3D = cast( particle, Particle3D ).velocity;
		p.x += v.x * time;
		p.y += v.y * time;
		p.z += v.z * time;
	}
}
