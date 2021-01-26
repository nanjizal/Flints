package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.particles.Particle2D;

/**
 * The Friction action applies friction to the particle to slow it down when 
 * it's moving. The frictional force is constant, irrespective of how fast 
 * the particle is moving. For forces proportional to the particle's velocity, 
 * use one of the drag effects - LinearDrag and QuadraticDrag.
 * 
 * @see LinearDrag
 * @see QuadraticDrag
 */

class Friction extends ActionBase
{
	public var friction(get, set):Float;
	private var _friction:Float;
	
	/**
	 * The constructor creates a Friction action for use by an emitter. 
	 * To add a Friction to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param friction The amount of friction. A higher number produces a 
	 * stronger frictional force.
	 */
	public function new( friction:Float = 0 )
	{
		super();
		this.friction = friction;
	}
	
	/**
	 * The amount of friction. A higher number produces a stronger frictional 
	 * force.
	 */
	public function get_friction():Float
	{
		return _friction;
	}
	public function set_friction( value:Float ):Float
	{
		_friction = value;
		return _friction;
	}
	
	/**
	 * Calculates the effect of the friction on the particle over the
	 * period of time indicated and adjusts the particle's velocity
	 * accordingly.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user.</p>
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
		var len2:Float = p.velX * p.velX + p.velY * p.velY;
		if( len2 == 0 )
		{
			return;
		}
		var scale:Float = 1 - ( _friction * time ) / ( Math.sqrt( len2 ) * p.mass );
		if( scale < 0 )
		{
			p.velX = 0;
			p.velY = 0;
		}
		else
		{
			p.velX *= scale;
			p.velY *= scale;
		}
	}
}
