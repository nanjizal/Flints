package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.counters.Counter;

/**
 * The Counter interface must be implemented by all counters.
 * 
 * <p>A counter is a class that tells an emitter how many particles to
 * emit at any time. The two methods control the rate of emission of particles
 * when the emitter starts and every frame thereafter.</p>
 * 
 * <p>A counter is directly associated with an emitter. A counter is set for 
 * an emitter by assigning it to the emitter's counter property.</p>
 * 
 * @see flints.common.emitters.Emitter#counter
 */
interface Counter 
{
	/**
	 * The startEmitter method is called when the emitter starts.
	 * 
	 * <p>This method is called within the emitter's start method 
	 * and need not be called by the user.</p>
	 * 
	 * @param emitter The emitter.
	 * @return The number of particles the emitter should emit when it starts.
	 */
	function startEmitter( emitter:Emitter ):Int;
	
	/**
	 * The updateEmitter method is called every frame after the
	 * emitter has started.
	 * 
	 * <p>This method is called within the emitter's update loop and need not
	 * be called by the user.</p>
	 * 
	 * @param emitter The emitter
	 * @param time The time, in seconds, since the previous call to this method.
	 * @return The number of particles the emitter should emit
	 * at this time.
	 */
	function updateEmitter( emitter:Emitter, time:Float ):Int;

	/**
	 * Stops the counter instructing the emitter to emit particles
	 */
	function stop():Void;
	
	/**
	 * Resumes the counter after a stop
	 */
	function resume():Void;
	
	/**
	 * Indicates if the counter has emitted all its particles
	 */
	public var complete(get, never):Bool;
	
	/**
	 * Indicates if the counter is currently emitting particles
	 */
	public var running(get, never):Bool;
}
