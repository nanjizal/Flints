package flints.threed.initializers;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.threed.emitters.Emitter3D;
import flints.threed.geom.Quaternion;
import flints.threed.particles.Particle3D;
import flints.threed.zones.Zone3D;

/**
 * The ColorInit Initializer sets the velocity of the particle. It is
 * usually combined with the Move action to move the particle
 * using this velocity.
 * 
 * <p>The initial velocity is defined using a zone from the 
 * flints.threeD.zones package. The use of zones enables diverse 
 * ranges of velocities. For example, to use a specific velocity,
 * a Point zone can be used. To use a varied speed in a specific
 * direction, a LineZone zone can be used. For a fixed speed in
 * a varied direction, a Disc or DiscSector zone with identical
 * inner and outer radius can be used. A Disc or DiscSector with
 * different inner and outer radius produces a range of speeds
 * in a range of directions.</p>
 */

class Velocity extends InitializerBase
{
	public var zone(get, set):Zone3D;
	
	private var _zone:Zone3D;

	/**
	 * The constructor creates a Velocity initializer for use by 
	 * an emitter. To add a Velocity to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param velocity The zone to use for creating the velocity.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( zone:Zone3D = null )
	{
		super();
		this.zone = zone;
	}
	
	/**
	 * The zone.
	 */
	private function get_zone():Zone3D
	{
		return _zone;
	}
	private function set_zone( value:Zone3D ):Zone3D
	{
		_zone = value;
		return _zone;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var e:Emitter3D = cast( emitter, Emitter3D );
		var v:Vector3D = zone.getLocation();
		//if( !e.rotation.equals( Quaternion.IDENTITY ) )
		if( !e.rotation.equals( new Quaternion().IDENTITY ) )
		{
			v = e.rotationTransform.transformVector( v );
		}
		p.velocity = v;
	}
}
