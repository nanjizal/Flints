package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The RotationalQuadraticDrag action applies drag to the particle to slow it 
 * down when it's rotating. The drag force is proportional to the square of the 
 * angular velocity of the particle.
 */
class RotationalQuadraticDrag extends ActionBase
{
	public var drag(get, set):Float;
	
	private var _drag:Float;
	
	/**
	 * The constructor creates a RotationalQuadraticDrag action for use by 
	 * an emitter. To add a RotationalQuadraticDrag to all particles created 
	 * by an emitter, use the emitter's addAction method.
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
		var v : Vector3D = cast( particle, Particle3D ).angVelocity;
		if ( v.x == 0 && v.y == 0 && v.z == 0 )
		{
			return;
		}
		var scale:Float = 1 - _drag * time * v.length / cast( particle, Particle3D ).inertia;
		if( scale < 0 )
		{
			v.x = 0;
			v.y = 0;
			v.z = 0;
		}
		else
		{
			v.scaleBy( scale );
		}
	}
}
