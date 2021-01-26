package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.counters.Random;
import flints.common.counters.Counter;

/**
 * The Random counter causes the emitter to emit particles continuously
 * at a variable random rate between two limits.
 */
class Random implements Counter
{
	public var minRate(get, set):Float;
	public var maxRate(get, set):Float;
	public var running(get, never):Bool;
	public var complete(get, never):Bool;
	
	private var _timeToNext:Float;
	private var _minRate:Float;
	private var _maxRate:Float;
	private var _running:Bool;
	
	/**
	 * The constructor creates a Random counter for use by an emitter. To
	 * add a Random counter to an emitter use the emitter's counter property.
	 * 
	 * @param minRate The minimum number of particles to emit per second.
	 * @param maxRate The maximum number of particles to emit per second.
	 * 
	 * @see flints.common.emitter.Emitter.counter
	 */
	public function new( minRate:Float = 0, maxRate:Float = 0 )
	{
		_running = false;
		_minRate = minRate;
		_maxRate = maxRate;
	}
	
	/**
	 * Stops the emitter from emitting particles
	 */
	public function stop():Void
	{
		_running = false;
	}
	
	/**
	 * Resumes the emitter emitting particles after a stop
	 */
	public function resume():Void
	{
		_running = true;
	}
	
	/**
	 * The minimum number of particles to emit per second.
	 */
	private function get_minRate():Float
	{
		return _minRate;
	}
	private function set_minRate( value:Float ):Float
	{
		_minRate = value;
		return _minRate;
	}
	
	/**
	 * The maximum number of particles to emit per second.
	 */
	private function get_maxRate():Float
	{
		return _maxRate;
	}
	private function set_maxRate( value:Float ):Float
	{
		_maxRate = value;
		return _maxRate;
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
		_timeToNext = newTimeToNext();
		return 0;
	}
	
	private function newTimeToNext():Float
	{
		var rate:Float = Math.random() * ( _maxRate - _minRate ) + _maxRate;
		return 1 / rate;
	}
	
	/**
	 * Uses the time, rateMin and rateMax to calculate how many
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
			++count;
			_timeToNext += newTimeToNext();
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
