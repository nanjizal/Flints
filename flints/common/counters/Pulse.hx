package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.counters.Pulse;
import flints.common.counters.Counter;

/**
 * The Pulse counter causes the emitter to emit groups of particles at a regular
 * interval.
 */
class Pulse implements Counter
{
	public var running(get, never):Bool;
	public var period(get, set):Float;
	public var quantity(get, set):Int;
	public var complete(get, never):Bool;
	
	private var _timeToNext:Float;
	private var _period:Float;
	private var _quantity:Int;
	private var _running:Bool;
	
	/**
	 * The constructor creates a Pulse counter for use by an emitter. To
	 * add a Pulse counter to an emitter use the emitter's counter property.
	 * 
	 * @param period The time, in seconds, between each pulse.
	 * @param quantity The number of particles to emit at each pulse.
	 * 
	 * @see flints.common.emitter.Emitter.counter
	 */
	public function new( period:Float = 1, quantity:Int = 0 )
	{
		_running = false;
		_quantity = quantity;
		_period = period;
	}
	
	/**
	 * Stops the emitter from emitting particles
	 */
	public function stop():Void
	{
		_running = false;
	}
	
	/**
	 * Resumes the emitter after a stop
	 */
	public function resume():Void
	{
		_running = true;
	}
	
	/**
	 * The time, in seconds, between each pulse.
	 */
	private function get_period():Float
	{
		return _period;
	}
	private function set_period( value:Float ):Float
	{
		_period = value;
		return _period;
	}
	
	/**
	 * The number of particles to emit at each pulse.
	 */
	private function get_quantity():Int
	{
		return Std.int(_quantity);
	}
	private function set_quantity( value:Int ):Int
	{
		_quantity = value;
		return _quantity;
	}
	
	/**
	 * Initilizes the counter. Returns 0 to indicate that the emitter should 
	 * emit no particles when it starts.
	 * 
	 * <p>This method is called within the emitter's start method 
	 * and need not be called by the user.</p>
	 * 
	 * @param emitter The emitter.
	 * @return 0
	 * 
	 * @see flints.common.counters.Counter#startEmitter()
	 */
	public function startEmitter( emitter:Emitter ):Int
	{
		_running = true;
		_timeToNext = _period;
		return _quantity;
	}
	
	/**
	 * Uses the time, period and quantity to calculate how many
	 * particles the emitter should emit now.
	 * 
	 * <p>This method is called within the emitter's update loop and need not
	 * be called by the user.</p>
	 * 
	 * @param emitter The emitter.
	 * @param time The time, in seconds, since the previous call to this method.
	 * @return the number of particles the emitter should create.
	 * 
	 * @see flints.common.counters.Counter#updateEmitter()
	 */
	public function updateEmitter( emitter:Emitter, time:Float ):Int
	{
		if( !_running )
		{
			return 0;
		}
		var count:Int = 0;
		_timeToNext -= time;
		while( _timeToNext <= 0 )
		{
			count += _quantity;
			_timeToNext += _period;
		}
		return count;
	}

	/**
	 * Indicates if the counter has emitted all its particles. For this counter
	 * this will always be false.
	 */
	public function get_complete():Bool
	{
		return false;
	}
	
	/**
	 * Indicates if the counter is currently emitting particles
	 */
	public function get_running():Bool
	{
		return _running;
	}
}
