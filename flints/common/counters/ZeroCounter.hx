package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.counters.ZeroCounter;
import flints.common.counters.Counter;

/**
 * The Zero counter causes the emitter to emit no particles. Because the emitter
 * requires a counter, this counter is used as the default and should be used 
 * whenever you don't want a counter.
 */
class ZeroCounter implements Counter
{
	public var running(get, never):Bool;
	public var complete(get, never):Bool;
	
	/**
	 * The constructor creates a Zero counter for use by an emitter. To
	 * add a Zero counter to an emitter use the emitter's counter property.
	 * 
	 * @see flints.common.emitters.Emitter#counter
	 */
	public function new()
	{
	}
	
	/**
	 * Returns 0 to indicate that the emitter should emit no particles when it
	 * starts.
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
		return 0;
	}
	
	/**
	 * Returns 0 to indicate that the emitter should emit no particles.
	 * 
	 * <p>This method is called within the emitter's update loop and need not
	 * be called by the user.</p>
	 * 
	 * @param emitter The emitter.
	 * @param time The time, in seconds, since the previous call to this method.
	 * @return 0
	 * 
	 * @see flints.common.counters.Counter#updateEmitter()
	 */
	public function updateEmitter( emitter:Emitter, time:Float ):Int
	{
		return 0;
	}

	/**
	 * Does nothing
	 */
	public function stop():Void
	{
	}
	
	/**
	 * Does nothing
	 */
	public function resume():Void
	{
	}

	/**
	 * Indicates if the counter has emitted all its particles. For the ZeroCounter
	 * this will always be true.
	 */
	public function get_complete():Bool
	{
		return true;
	}
	
	/**
	 * Indicates if the counter is currently emitting particles
	 */
	public function get_running():Bool
	{
		return false;
	}
}
