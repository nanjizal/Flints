package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.easing.Linear;
import flints.common.counters.TimePeriod;
import flints.common.counters.Counter;

/**
 * The TimePeriod counter causes the emitter to emit particles for a period of 
 * time and then stop. The rate of emission over that period can be modified 
 * using easing equations that conform to the interface defined in Robert 
 * Penner's easing equations. An update to these equations is included in the 
 * flints.common.easing package.
 * 
 * @see flints.common.easing
 */
class TimePeriod implements Counter
{
	public var numParticles(get, set):Int;
	public var running(get, never):Bool;
	public var complete(get, never):Bool;
	public var easing(get, set):Dynamic;
	public var duration(get, set):Float;
	
	private var _particles : Int;
	private var _duration : Float;
	private var _particlesPassed : Int;
	private var _timePassed : Float;
	private var _easing : Dynamic;
	private var _running : Bool;

	/**
	 * The constructor creates a TimePeriod counter for use by an emitter. To
	 * add a TimePeriod counter to an emitter use the emitter's counter property.
	 * 
	 * @param numParticles The number of particles to emit over the full duration
	 * of the time period
	 * @param duration The duration of the time period. After this time is up the
	 * emitter will not release any more particles.
	 * @param easing An easing function used to distribute the emission of the
	 * particles over the time period. If no easing function is passed a simple
	 * linear distribution is used in which particles are emitted at a constant 
	 * rate over the time period.
	 * 
	 * @see flints.common.emitter.Emitter.counter
	 */
	public function new( numParticles : Int = 0, duration : Float = 0, easing : Dynamic = null )
	{
		_particles = numParticles;
		_running = false;
		_duration = duration;
		if ( easing == null )
		{
			_easing = Linear.easeNone;
		}
		else
		{
			_easing = easing;
		}
	}

	/**
	 * The number of particles to emit over the full duration
	 * of the time period.
	 */
	private function get_numParticles():Int
	{
		return _particles;
	}
	private function set_numParticles( value:Int ):Int
	{
		_particles = value;
		return _particles;
	}
	
	/**
	 * The duration of the time period. After this time is up the
	 * emitter will not release any more particles.
	 */
	private function get_duration():Float
	{
		return _duration;
	}
	private function set_duration( value:Float ):Float
	{
		_duration = value;
		return _duration;
	}
	
	/**
	 * An easing function used to distribute the emission of the
	 * particles over the time period.
	 */
	private function get_easing():Dynamic
	{
		return _easing;
	}
	private function set_easing( value:Dynamic ):Dynamic
	{
		_easing = value;
		return _easing;
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
	public function startEmitter( emitter:Emitter ) : Int
	{
		_running = true;
		_particlesPassed = 0;
		_timePassed = 0;
		return 0;
	}

	/**
	 * Uses the time, timePeriod and easing function to calculate how many
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
	public function updateEmitter( emitter:Emitter, time : Float ) : Int
	{
		if( !_running || _timePassed >= _duration )
		{
			return 0;
		}
		
		_timePassed += time;
		
		if( _timePassed >= _duration )
		{
			emitter.dispatchCounterComplete();
			var newParticles:Int = _particles - _particlesPassed;
			_particlesPassed = _particles;
			return newParticles;
		}
		
		var oldParticles:Int = _particlesPassed;
		_particlesPassed = Math.round( _easing( _timePassed, 0, _particles, _duration ) );
		return _particlesPassed - oldParticles;
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
	 * Indicates if the counter has emitted all its particles.
	 */
	public function get_complete():Bool
	{
		return _particlesPassed == _particles;
	}
	
	/**
	 * Indicates if the counter is currently emitting particles
	 */
	public function get_running():Bool
	{
		return (_running && _timePassed < _duration);
	}
}
