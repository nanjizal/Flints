package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.geom.Quaternion;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;


/**
 * The RotateToDirection action updates the rotation of the particle 
 * so that it always points in the direction it is traveling.
 */
class RotateToDirection extends ActionBase
{
	private var _axis:Vector3D;
	private var _temp:Vector3D;
	private var _target:Vector3D;
	
	/**
	 * The constructor creates a RotateToDirection action for use by 
	 * an emitter. To add a RotateToDirection to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 */
	public function new()
	{
		super();
		_axis = new Vector3D();
		_temp = new Vector3D();
		_target = new Vector3D();
	}

	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, particle : Particle, time : Float ) : Void
	{
		var p : Particle3D = cast( particle, Particle3D );
		var vel : Vector3D = p.velocity;
		var len:Float = vel.length;
		if ( len == 0 )
		{
			return;
		}
		_target.x = vel.x / len;
		_target.y = vel.y / len;
		_target.z = vel.z / len;
		
		var faceAxis:Vector3D = p.faceAxis;
		if( _target.x == faceAxis.x && _target.y == faceAxis.y && _target.z == faceAxis.z )
		{
			p.rotation.assign( new Quaternion().IDENTITY );
			return;
		}
		
		if( _target.x == -faceAxis.x && _target.y == -faceAxis.y && _target.z == -faceAxis.z )
		{
			var v:Vector3D = Vector3DUtils.getPerpendicular( faceAxis );
			p.rotation.reset( 0, v.x, v.y, v.z );
			return;
		}
		_axis = _target.crossProduct( p.faceAxis );
		var angle:Float = Math.acos( p.faceAxis.dotProduct( _target ) );
		p.rotation.setFromAxisRotation( _axis, angle );
	}
}
