package flints.common.counters;

import flints.common.emitters.Emitter;
import flints.common.counters.Counter;
import flints.common.counters.Blast;

/**
 * The Blast counter causes the emitter to create a single burst of
 * particles when it starts and then emit no further particles.
 * It is used, for example, to simulate an explosion.
 */
class Blast implements Counter
{
	public var running(get, never):Bool;
	public var startCount(get, set):Float;
	public var complete(get, never):Bool;
	
	private var _startCount:Int;
	private var _done:Bool;
	
	/**
	 * The constructor creates a Blast counter for use by an emitter. To
	 * add a Blast counter to an emitter use the emitter's counter property.
	 * 
	 * @param startCount The number of particles to emit
	 * when the emitter starts.
	 * 
	 * @see flints.common.emitter.Emitter.counter
	 */
	public function new( startCount:Int = 0 )
	{
		_done = false;
		_startCount = startCount;
	}
			
	/**
	 * The number of particles to emit when the emitter starts.
	 */
	private function get_startCount():Float
	{
		return _startCount;
	}
	private function set_startCount( value:Float ):Float
	{
		_startCount = Std.int(value);
		return _startCount;
	}
	
	/**
	 * Does nothing. Since the blast counter emits a single blast and then
	 * stops, stopping it changes nothing.
	 */
	public function stop():Void
	{
	}
	
	/**
	 * Does nothing. Since the blast counter emits a single blast and then
	 * stops, stopping and resuming it changes nothing.
	 */
	public function resume():Void
	{
	}
	
	/**
	 * Initilizes the counter. Returns startCount to indicate that the emitter 
	 * should emit that many particles when it starts.
	 * 
	 * <p>This method is called within the emitter's start method 
	 * and need not be called by the user.</p>
	 * 
	 * @param emitter The emitter.
	 * @return the value of startCount.
	 * 
	 * @see flints.common.counters.Counter#startEmitter()
	 */
	public function startEmitter( emitter:Emitter ):Int
	{
		_done = true;
		emitter.dispatchCounterComplete();
		return _startCount;
	}
	
	/**
	 * Returns 0 to indicate that no particles should be emitted after the 
	 * initial blast.
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
	 * Indicates if the counter has emitted all its particles.
	 */
	public function get_complete():Bool
	{
		return _done;
	}
	
	/**
	 * Indicates if the counter is currently emitting particles
	 */
	public function get_running():Bool
	{
		return false;
	}
}
