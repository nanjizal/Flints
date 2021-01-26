package flints.threed.initializers;

import flints.common.emitters.Emitter;
import flints.common.particles.Particle;
import flints.common.initializers.InitializerBase;
import flints.threed.particles.Particle3D;
import flints.threed.zones.Zone3D;

/**
 * The PositionAbsolute Initializer sets the initial location of the particle.
 * 
 * <p>The class uses zones to place the particle. A zone defines a region
 * in the coordinate space of the particle system, independent of the emitter's position,
 * and the particle is placed at a random point within
 * that region. For precise placement, the Point zone defines a single
 * point at which all particles will be placed. Various zones (and the
 * Zones interface for use when implementing custom zones) are defined
 * in the flints.threeD.zones package.</p>
 */
class PositionAbsolute extends InitializerBase
{
	public var zone(get, set):Zone3D;
	
	private var _zone : Zone3D;

	/**
	 * The constructor creates a PositionAbsolute initializer for use by 
	 * an emitter. To add a PositionAbsolute to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param zone The zone to place all particles in.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( zone : Zone3D = null )
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
	override public function initialize( emitter : Emitter, particle : Particle ) : Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		p.position = _zone.getLocation();
	}
}
