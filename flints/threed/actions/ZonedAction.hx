package flints.threed.actions;

import flints.common.emitters.Emitter;
import flints.common.particles.Particle;
import flints.common.actions.Action;
import flints.common.actions.ActionBase;
import flints.threed.particles.Particle3D;
import flints.threed.zones.Zone3D;

/**
 * The ZonedAction Action applies an action to the particle only if it is in the specified zone. 
 */
class ZonedAction extends ActionBase
{
	public var zone(get, set):Zone3D;
	public var invertZone(get, set):Bool;
	public var action(get, set):Action;
	override public var priority(get, set):Int;
	
	private var _action:Action;
	private var _zone:Zone3D;
	private var _invert:Bool;
	
	/**
	 * The constructor creates a ZonedAction action for use by 
	 * an emitter. To add a ZonedAction to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.emitters.Emitter#addAction()
	 * 
	 * @param action The action to apply when inside the zone.
	 * @param zone The zone in which to apply the action.
	 * @param invertZone If false (the default) the action is applied only to particles inside 
	 * the zone. If true the action is applied only to particles outside the zone.
	 */
	public function new( action:Action = null, zone:Zone3D = null, invertZone:Bool = false )
	{
		super();
		this.action = action;
		this.zone = zone;
		this.invertZone = invertZone;
	}
	
	/**
	 * The action to apply when inside the zone.
	 */
	private function get_action():Action
	{
		return _action;
	}
	private function set_action( value:Action ):Action
	{
		_action = value;
		return value;
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
		return value;
	}
	
	/**
	 * If false (the default), the action is applied to particles inside the zone.
	 * If true, the action is applied to particles outside the zone.
	 */
	private function get_invertZone():Bool
	{
		return _invert;
	}
	private function set_invertZone( value:Bool ):Bool
	{
		_invert = value;
		return value;
	}
	
	/**
	 * Provides access to the priority of the action being used.
	 * 
	 * @inheritDoc
	 */
	override private function get_priority():Int
	{
		return _action.priority;
	}
	override private function set_priority( value:Int ):Int
	{
		_action.priority = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		_action.addedToEmitter( emitter );
	}
	
	/**
	 * @inheritDoc
	 */
	override public function removedFromEmitter( emitter:Emitter ):Void
	{
		_action.removedFromEmitter( emitter );
	}

	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		if( _zone.contains( p.position ) )
		{
			if( !_invert )
			{
				_action.update( emitter, p, time );
			}
		}
		else
		{
			if( _invert )
			{
				_action.update( emitter, p, time );
			}
		}
	}
}
