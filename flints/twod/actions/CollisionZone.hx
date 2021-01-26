package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.common.events.ParticleEvent;
import flints.twod.particles.Particle2D;
import flints.twod.zones.Zone2D;


/**
 * The CollisionZone action detects collisions between particles and a zone, 
 * modifying the particles' velocities in response to the collision. All 
 * particles are approximated to a circular shape for the collisions.
 * 
 * <p>This action has a priority of -30, so that it executes after most other 
 * actions.</p>
 */

class CollisionZone extends ActionBase
{
	public var zone(get, set):Zone2D;
	public var bounce(get, set):Float;
	
	private var _bounce:Float;
	private var _zone:Zone2D;
	
	/**
	 * The constructor creates a CollisionZone action for use by  an emitter.
	 * To add a CollisionZone to all particles managed by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param zone The zone that the particles should collide with.
	 * @param bounce The coefficient of restitution when the particles collide. 
	 * A value of 1 gives a pure elastic collision, with no energy loss. A 
	 * value between 0 and 1 causes the particles to loose enegy in the 
	 * collision. A value greater than 1 causes the particle to gain energy 
	 * in the collision.
	 */
	public function new( zone:Zone2D = null, bounce:Float = 1 )
	{
		super();
		priority = -30;
		this.bounce = bounce;
		this.zone = zone;
	}

	/**
	 * The zone that the particles should collide with.
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
	 * The coefficient of restitution when the particles collide. A value of 
	 * 1 gives a pure elastic collision, with no energy loss. A value
	 * between 0 and 1 causes the particles to loose enegy in the collision. 
	 * A value greater than 1 causes the particles to gain energy in the collision.
	 */
	public function get_bounce():Float
	{
		return _bounce;
	}
	public function set_bounce( value:Float ):Float
	{
		_bounce = value;
		return _bounce;
	}

	/**
	 * Checks for collisions between the particle and the zone.
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
		var collide:Bool = _zone.collideParticle( cast( particle,Particle2D ), _bounce );
		if( collide && emitter.hasEventListener( ParticleEvent.ZONE_COLLISION ) )
		{
			var ev:ParticleEvent = new ParticleEvent( ParticleEvent.ZONE_COLLISION, particle );
			ev.otherObject = _zone;
			emitter.dispatchEvent( ev );
		}
	}
}
