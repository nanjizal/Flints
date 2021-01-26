package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The RotationalFriction action applies friction to the particle's rotational movement
 * to slow it down when it's rotating. The frictional force is constant, irrespective 
 * of how fast the particle is rotating. For forces proportional to the particle's 
 * angular velocity, use one of the rotational drag effects -
 * RotationalLinearDrag and RotationalQuadraticDrag.
 */
class RotationalFriction extends ActionBase
{
	public var friction(get, set):Float;
	
	private var _friction:Float;
	
	/**
	 * The constructor creates a RotationalFriction action for use by 
	 * an emitter. To add a RotationalFriction to all particles created by an emitter, 
	 * use the emitter's addAction method.
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
		var v : Vector3D = cast( particle, Particle3D ).angVelocity;
		if ( v.x == 0 || v.y ==0 || v.z == 0 )
		{
			return;
		}
		var scale:Float = 1 - ( _friction * time ) / ( v.length * cast( particle, Particle3D ).inertia );
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
