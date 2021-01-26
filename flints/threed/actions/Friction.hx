package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The Friction action applies friction to the particle to slow it down when it's moving.
 * The frictional force is constant, irrespective of how fast the particle is moving.
 * For forces proportional to the particle's velocity, use one of the drag effects -
 * LinearDrag and QuadraticDrag.
 * 
 * @see LinearDrag
 * @see QuadraticDrag
 */

class Friction extends ActionBase
{
	public var friction(get, set):Float;
	
	private var _friction:Float;
	
	/**
	 * The constructor creates a Friction action for use by 
	 * an emitter. To add a Friction to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param friction The amount of friction. A higher number produces a stronger frictional force.
	 */
	public function new( friction:Float = 0 )
	{
		super();
		this.friction = friction;
	}
	
	/**
	 * The amount of friction. A higher number produces a stronger frictional force.
	 */
	private function get_friction():Float
	{
		return _friction;
	}
	private function set_friction( value:Float ):Float
	{
		_friction = value;
		return _friction;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var len2:Float = p.velocity.lengthSquared;
		if( len2 == 0 )
		{
			return;
		}
		var scale:Float = 1 - ( _friction * time ) / ( Math.sqrt( len2 ) * p.mass );
		if( scale < 0 )
		{
			p.velocity.x = 0;
			p.velocity.y = 0;
			p.velocity.z = 0;
		}
		else
		{
			p.velocity.scaleBy( scale );
		}
	}
}
