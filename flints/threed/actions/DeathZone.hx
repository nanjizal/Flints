package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;
import flints.threed.zones.Zone3D;

/**
 * The DeathZone action marks the particle as dead if it is inside
 * a specific zone.
 * 
 * This action has a priority of -20, so that it executes after 
 * all movement has occured.
 */

class DeathZone extends ActionBase
{
	public var zone(get, set):Zone3D;
	public var zoneIsSafe(get, set):Bool;
	
	private var _zone:Zone3D;
	private var _invertZone:Bool;
	
	/**
	 * The constructor creates a DeathZone action for use by an emitter. 
	 * To add a DeathZone to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * @see flints.threeD.zones
	 * 
	 * @param zone The zone to use. Any item from the 
	 * flints.threeD.zones package can be used.
	 * @param zoneIsSafe If true, the zone is treated as the safe area
	 * and particles outside the zone are killed. If false, particles
	 * inside the zone are killed.
	 */
	public function new( zone:Zone3D = null, zoneIsSafe:Bool = false )
	{
		super();
		priority = -20;
		this.zone = zone;
		this.zoneIsSafe = zoneIsSafe;
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
	 * If true, the zone is treated as the safe area and particles ouside the 
	 * zone are killed. If false, particles inside the zone are killed.
	 */
	private function get_zoneIsSafe():Bool
	{
		return _invertZone;
	}
	private function set_zoneIsSafe( value:Bool ):Bool
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
		var p:Particle3D = cast( particle, Particle3D );
		var inside:Bool = _zone.contains( p.position );
		if ( _invertZone )
		{
			inside = !inside;
		}
		if ( inside )
		{
			p.isDead = true;
		}
	}
}
