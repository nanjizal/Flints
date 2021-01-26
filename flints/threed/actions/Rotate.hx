package flints.threed.actions;

import flints.common.emitters.Emitter;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.threed.geom.Quaternion;
import flints.threed.particles.Particle3D;

/**
 * The Rotate action updates the rotation of the particle based on its angular velocity.
 * It uses a Euler integrator to calculate the new rotation, hence the name.
 * 
 * <p>This action has a priority of -10, so that it executes after other actions.</p>
 */
class Rotate extends ActionBase
{
	/*
	 * Temporary variables created as class members to avoid creating new objects all the time
	 */
	private var q:Quaternion;
	
	/**
	 * The constructor creates a Rotate action for use by 
	 * an emitter. To add a Rotate to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 */
	public function new()
	{
		super();
		priority = -10;
		q = new Quaternion();
	}

	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		q.w = 0;
		q.x = p.angVelocity.x * 0.5;
		q.y = p.angVelocity.y * 0.5;
		q.z = p.angVelocity.z * 0.5;
		q.postMultiplyBy( p.rotation );
		p.rotation.incrementBy( q.scaleBy( time ) ).normalize();
	}
}
