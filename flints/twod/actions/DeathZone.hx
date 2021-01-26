package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.particles.Particle2D;
import flints.twod.zones.Zone2D;


/**
 * The DeathZone action marks the particle as dead if it is inside
 * a specific zone.
 * 
 * This action has a priority of -20, so that it executes after 
 * all movement has occured.
 */

class DeathZone extends ActionBase
{
	public var zone(get, set):Zone2D;
	public var zoneIsSafe(get, set):Bool;
	
	private var _zone:Zone2D;
	private var _invertZone:Bool;
	private var p:Particle2D;
	private var inside:Bool;
	
	
	/**
	 * The constructor creates a DeathZone action for use by an emitter. 
	 * To add a DeathZone to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * @see flints.twod.zones
	 * 
	 * @param zone The zone to use. Any item from the 
	 * flints.twod.zones package can be used.
	 * @param zoneIsSafe If true, the zone is treated as the safe area
	 * and particles outside the zone are killed. If false, particles
	 * inside the zone are killed.
	 */
	public function new( zone:Zone2D = null, zoneIsSafe:Bool = false )
	{
		super();
		priority = -20;
		this.zone = zone;
		this.zoneIsSafe = zoneIsSafe;
	}
	
	/**
	 * The zone.
	 */
	public function get_zone():Zone2D
	{
		return _zone;
	}
	public function set_zone( value:Zone2D ):Zone2D
	{
		_zone = value;
		return _zone;
	}
	
	/**
	 * If true, the zone is treated as the safe area and particles ouside the 
	 * zone are killed. If false, particles inside the zone are killed.
	 */
	public function get_zoneIsSafe():Bool
	{
		return _invertZone;
	}
	public function set_zoneIsSafe( value:Bool ):Bool
	{
		_invertZone = value;
		return _invertZone;
	}

	/**
	 * Checks whether the particle is inside the zone and kills it if it is
	 * in the DeathZone region.
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
		p = cast( particle,Particle2D );
		inside = _zone.contains( p.x, p.y );
		if ( _invertZone )
		{
			if( !inside )
			{
				p.isDead = true;
			}
		}
		else
		{
			if ( inside )
			{
				p.isDead = true;
			}
		}
	}
}
