package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The SpeedLimit action limits the particle's maximum speed to the specified
 * speed. The behaviour can be switched to instead limit the minimum speed to
 * the specified speed.
 * 
 * <p>This action has aa priority of -5, so that it executes after all accelerations 
 * have occured.</p>
 */
class SpeedLimit extends ActionBase
{
	public var isMinimum(get, set):Bool;
	public var limit(get, set):Float;
	
	private var _limit:Float;
	private var _limitSq:Float;
	private var _isMinimum:Bool;
	
	/**
	 * The constructor creates a SpeedLimit action for use by 
	 * an emitter. To add a SpeedLimit to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param speed The speed limit for the action in pixels per second.
	 * @param isMinimum If true, particles travelling slower than the speed limit
	 * are accelerated to the speed limit, otherwise particles travelling faster
	 * than the speed limit are decelerated to the speed limit.
	 */
	public function new( speed:Float = 9999, isMinimum:Bool = false )
	{
		super();
		priority = -5;
		this.limit = speed;
		this.isMinimum = isMinimum;
	}
	
	/**
	 * The speed limit
	 */
	private function get_limit():Float
	{
		return _limit;
	}
	private function set_limit( value:Float ):Float
	{
		_limit = value;
		_limitSq = value * value;
		return _limit;
	}
	
	/**
	 * Whether the speed is a minimum (true) or maximum (false) speed.
	 */
	private function get_isMinimum():Bool
	{
		return _isMinimum;
	}
	private function set_isMinimum( value:Bool ):Bool
	{
		_isMinimum = value;
		return _isMinimum;
	}

	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var speedSq:Float = p.velocity.lengthSquared;
		if ( ( _isMinimum && speedSq < _limitSq ) || ( !_isMinimum && speedSq > _limitSq ) )
		{
			var scale:Float = _limit / Math.sqrt( speedSq );
			p.velocity.scaleBy( scale );
		}
	}
}
