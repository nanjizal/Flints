package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;
import flints.threed.zones.Zone3D;


/**
 * The Jet Action applies an acceleration to the particle only if it is in the specified zone. 
 */

class Jet extends ActionBase
{
	public var x(get, set):Float;
	public var zone(get, set):Zone3D;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var invertZone(get, set):Bool;
	public var acceleration(get, set):Vector3D;
	
	private var _acc:Vector3D;
	private var _zone:Zone3D;
	private var _invert:Bool;
	
	/**
	 * The constructor creates a Jet action for use by 
	 * an emitter. To add a Jet to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param accelerationX The x coordinate of the acceleration to apply, in pixels 
	 * per second per second.
	 * @param accelerationY The y coordinate of the acceleration to apply, in pixels 
	 * per second per second.
	 * @param zone The zone in which to apply the acceleration.
	 * @param invertZone If false (the default) the acceleration is applied only to particles inside 
	 * the zone. If true the acceleration is applied only to particles outside the zone.
	 */
	public function new( acceleration:Vector3D = null, zone:Zone3D = null, invertZone:Bool = false )
	{
		super();
		this.acceleration = acceleration != null ? acceleration : new Vector3D();
		this.zone = zone;
		this.invertZone = invertZone;
	}
	
	/**
	 * The acceleration, in coordinate units per second per second.
	 */
	private function get_acceleration():Vector3D
	{
		return _acc;
	}
	private function set_acceleration( value:Vector3D ):Vector3D
	{
		_acc = Vector3DUtils.cloneVector( value );
		return _acc;
	}
	
	/**
	 * The zone in which to apply the acceleration.
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
	 * If true, the zone is treated as the safe area and being ouside the zone
	 * results in the particle dying. Otherwise, being inside the zone causes the
	 * particle to die.
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
	 * The x coordinate of the acceleration, in coordinate units per second per second.
	 */
	private function get_x():Float
	{
		return _acc.x;
	}
	private function set_x( value:Float ):Float
	{
		_acc.x = value;
		return value;
	}
	
	/**
	 * The y coordinate of the acceleration, in coordinate units per second per second.
	 */
	private function get_y():Float
	{
		return _acc.y;
	}
	private function set_y( value:Float ):Float
	{
		_acc.y = value;
		return value;
	}
	
	/**
	 * The z coordinate of the acceleration, in coordinate units per second per second.
	 */
	private function get_z():Float
	{
		return _acc.z;
	}
	private function set_z( value:Float ):Float
	{
		_acc.z = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var v:Vector3D = p.velocity;
		if( _zone.contains( p.position ) )
		{
			if( !_invert )
			{
				v.x += _acc.x * time;
				v.y += _acc.y * time;
				v.z += _acc.z * time;
			}
		}
		else
		{
			if( _invert )
			{
				v.x += _acc.x * time;
				v.y += _acc.y * time;
				v.z += _acc.z * time;
			}
		}
	}
}
