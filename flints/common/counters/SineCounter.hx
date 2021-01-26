package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.counters.SineCounter;
import flints.common.counters.Counter;

/**
 * The Sine counter causes the emitter to emit particles continuously
 * at a rate that varies according to a sine wave.
 */
class SineCounter implements Counter
{
	public var running(get, never):Bool;
	public var period(get, set):Float;
	public var rateMin(get, set):Float;
	public var complete(get, never):Bool;
	public var rateMax(get, set):Float;
	
	private var _emitted:Float;
	private var _rateMin:Float;
	private var _rateMax:Float;
	private var _period:Float;
	private var _running:Bool;
	private var _timePassed:Float;
	private var _factor:Float;
	private var _scale:Float;
	
	/**
	 * The constructor creates a SineCounter counter for use by an emitter. To
	 * add a SineCounter counter to an emitter use the emitter's counter property.
	 * 
	 * @period The period of the sine wave used, in seconds.
	 * @param rateMax The number of particles emitted per second at the peak of
	 * the sine wave.
	 * @param rateMin The number of particles to emit per second at the bottom
	 * of the sine wave.
	 * 
	 * @see flints.common.emitter.Emitter.counter
	 */
	public function new( period:Float = 1, rateMax:Float = 0, rateMin:Float = 0 )
	{
		_running = false;
		_period = period;
		_rateMin = rateMin;
		_rateMax = rateMax;
		_factor = 2 * Math.PI / period;
		_scale = 0.5 * ( _rateMax - _rateMin );
	}
	
	/**
	 * Stops the emitter from emitting particles
	 */
	public function stop():Void
	{
		_running = false;
	}
	
	/**
	 * Resumes the emitting of particles after a stop
	 */
	public function resume():Void
	{
		_running = true;
		_emitted = 0;
	}
	
	/**
	 * The number of particles to emit per second at the bottom
	 * of the sine wave.
	 */
	private function get_rateMin():Float
	{
		return _rateMin;
	}
	private function set_rateMin( value:Float ):Float
	{
		_rateMin = value;
		_scale = 0.5 * ( _rateMax - _rateMin );
		return _rateMin;
	}
	
	/**
	 * The number of particles emitted per second at the peak of
	 * the sine wave.
	 */
	private function get_rateMax():Float
	{
		return _rateMax;
	}
	private function set_rateMax( value:Float ):Float
	{
		_rateMax = value;
		_scale = 0.5 * ( _rateMax - _rateMin );
		return _rateMax;
	}
	
	/**
	 * The period of the sine wave used, in seconds.
	 */
	private function get_period():Float
	{
		return _period;
	}
	private function set_period( value:Float ):Float
	{
		_period = value;
		_factor = 2 * Math.PI / _period;
		return _period;
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
		_timePassed = 0;
		_emitted = 0;
		return 0;
	}
	
	/**
	 * Uses the time, period, rateMin and rateMax to calculate how many
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
		_timePassed += time;
		var count:Int = Math.floor( _rateMax * _timePassed + _scale * ( 1 - Math.cos( _timePassed * _factor ) ) / _factor );
		var ret:Int = count - Std.int(_emitted);
		_emitted = count;
		return ret;
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
