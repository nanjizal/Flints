package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.particles.Particle2D;
import flints.twod.zones.Zone2D;

/**
 * The Jet Action applies an acceleration to particles only if they are in 
 * the specified zone. 
 */

class Jet extends ActionBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var zone(get, set):Zone2D;
	public var invertZone(get, set):Bool;
	
	private var _x:Float;
	private var _y:Float;
	private var _zone:Zone2D;
	private var _invert:Bool;
	
	/**
	 * The constructor creates a Jet action for use by an emitter. 
	 * To add a Jet to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param accelerationX The x component of the acceleration to apply, in 
	 * pixels per second per second.
	 * @param accelerationY The y component of the acceleration to apply, in 
	 * pixels per second per second.
	 * @param zone The zone in which to apply the acceleration.
	 * @param invertZone If false (the default) the acceleration is applied 
	 * only to particles inside the zone. If true the acceleration is applied 
	 * only to particles outside the zone.
	 */
	public function new( accelerationX:Float = 0, accelerationY:Float = 0, zone:Zone2D = null, invertZone:Bool = false )
	{
		super();
		this.x = accelerationX;
		this.y = accelerationY;
		this.zone = zone;
		this.invertZone = invertZone;
	}
	
	/**
	 * The x component of the acceleration to apply, in 
	 * pixels per second per second.
	 */
	private function get_x():Float
	{
		return _x;
	}
	private function set_x( value:Float ):Float
	{
		_x = value;
		return _x;
	}
	
	/**
	 * The y component of the acceleration to apply, in 
	 * pixels per second per second.
	 */
	private function get_y():Float
	{
		return _y;
	}
	private function set_y( value:Float ):Float
	{
		_y = value;
		return _y;
	}
	
	/**
	 * The zone in which to apply the acceleration.
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
	 * If false (the default) the acceleration is applied 
	 * only to particles inside the zone. If true the acceleration is applied 
	 * only to particles outside the zone.
	 */
	private function get_invertZone():Bool
	{
		return _invert;
	}
	private function set_invertZone( value:Bool ):Bool
	{
		_invert = value;
		return _invert;
	}
	
	/**
	 * Checks if the particle is inside the zone and, if so, applies the 
	 * acceleration to the particle for the period of time indicated.
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
		var p:Particle2D = cast( particle,Particle2D );
		if( _zone.contains( p.x, p.y ) )
		{
			if( !_invert )
			{
				p.velX += _x * time;
				p.velY += _y * time;
			}
		}
		else
		{
			if( _invert )
			{
				p.velX += _x * time;
				p.velY += _y * time;
			}
		}
	}
}
