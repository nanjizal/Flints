package flints.twod.initializers;

import openfl.geom.Point;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.twod.particles.Particle2D;
import flints.twod.zones.Zone2D;
import flints.common.particles.Particle;


/**
 * The ColorInit Initializer sets the velocity of the particle. It is
 * usually combined with the Move action to move the particle
 * using this velocity.
 * 
 * <p>The initial velocity is defined using a zone from the 
 * flints.twoD.zones package. The use of zones enables diverse 
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
	public var zone(get, set):Zone2D;
	
	private var _zone:Zone2D;

	/**
	 * The constructor creates a Velocity initializer for use by 
	 * an emitter. To add a Velocity to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param velocity The zone to use for creating the velocity.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( zone:Zone2D = null )
	{
		super();
		this.zone = zone;
	}
	
	/**
	 * The zone.
	 */
	private function get_zone():Zone2D
	{
		return _zone;
	}
	private function set_zone( value:Zone2D ):Zone2D
	{
		_zone = value;
		return _zone;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		var p:Particle2D = cast( particle, Particle2D );
		var loc:Point = _zone.getLocation();
		if( p.rotation == 0 )
		{
			p.velX = loc.x;
			p.velY = loc.y;
		}
		else
		{
			var sin:Float = Math.sin( p.rotation );
			var cos:Float = Math.cos( p.rotation );
			p.velX = cos * loc.x - sin * loc.y;
			p.velY = cos * loc.y + sin * loc.x;
		}
	}
}
