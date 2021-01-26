package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The LinearDrag action applies drag to the particle to slow it down when it's moving.
 * The drag force is proportional to the velocity of the particle.
 */

class LinearDrag extends ActionBase
{
	public var drag(get, set):Float;
	
	private var _drag:Float;
	
	/**
	 * The constructor creates a LinearDrag action for use by 
	 * an emitter. To add a LinearDrag to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param drag The amount of drag. A higher number produces a stronger drag force.
	 */
	public function new( drag:Float = 0 )
	{
		super();
		this.drag = drag;
	}
	
	/**
	 * The amount of drag. A higher number produces a stronger drag force.
	 */
	private function get_drag():Float
	{
		return _drag;
	}
	private function set_drag( value:Float ):Float
	{
		_drag = value;
		return _drag;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var scale:Float = 1 - _drag * time / p.mass;
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
