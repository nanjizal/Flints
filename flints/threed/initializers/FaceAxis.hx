package flints.threed.initializers;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The FaceAxis Initializer sets the face axis of the particle. The face axis
 * is a unit vector in the coordinate space of the particle that indicates the
 * "forward" direction for the particle.
 * 
 * <p>The face axis is used when rotating the particle to the direction of
 * motion and when using a display object to represent the particle - the display
 * object is rotated so that its x axis points in the direction of the facing axis
 * of the particle.</p>
 */

class FaceAxis extends InitializerBase
{
	public var axis(get, set):Vector3D;
	
	private var _axis : Vector3D;

	/**
	 * The constructor creates a FaceAxis initializer for use by 
	 * an emitter. To add a FaceAxis to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param axis The face axis for the particles.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( axis : Vector3D = null )
	{
		super();
		this.axis = axis != null ? axis : Vector3D.X_AXIS;
	}
	
	/**
	 * The face axis of the particles.
	 */
	private function get_axis():Vector3D
	{
		return _axis;
	}
	private function set_axis( value:Vector3D ):Vector3D
	{
		_axis = Vector3DUtils.cloneUnit( value );
		return _axis;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter : Emitter, particle : Particle ) : Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		p.faceAxis = _axis.clone();
	}
}
