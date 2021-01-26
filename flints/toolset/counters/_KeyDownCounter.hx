package flints.common.counters;

//import openfl.display.Stage;
//import openfl.events.KeyboardEvent;
import flints.common.emitters.Emitter;
import flints.common.counters.KeyDownCounter;
import flints.common.counters.Counter;


/**
 * The KeyDownCounter Counter modifies another counter to only emit particles when a specific key
 * is being pressed.
 */
class KeyDownCounter implements Counter
{
	public var stage(get, set):Stage;
	public var running(get, never):Bool;
	public var counter(get, set):Counter;
	public var complete(get, never):Bool;
	public var keyCode(get, set):Int;
	
	private var _counter:Counter;
	private var _keyCode:Int;
	private var _isDown:Bool;
	private var _stop:Bool;
	private var _stage:Stage;
	
	/**
	 * The constructor creates a ZonedAction action for use by 
	 * an emitter. To add a ZonedAction to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.emitters.Emitter#addAction()
	 * 
	 * @param counter The counter to use when the key is down.
	 * @param keyCode The key code of the key that controls the counter.
	 * @param stage A reference to the stage.
	 */
	public function new( counter:Counter = null, keyCode:Int = 0, stage:Stage = null )
	{
		_stop = false;
		_counter = counter;
		_keyCode = keyCode;
		_isDown = false;
		_stage = stage;
		createListeners();
	}
	
	private function createListeners():Void
	{
		if( stage != null )
		{
			//stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener, false, 0, true );
			//stage.addEventListener( KeyboardEvent.KEY_UP, keyUpListener, false, 0, true );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpListener );
		}
	}
	
	private function keyDownListener( ev:KeyboardEvent ):Void
	{
		if( ev.keyCode == _keyCode )
		{
			_isDown = true;
		}
	}
	private function keyUpListener( ev:KeyboardEvent ):Void
	{
		if( ev.keyCode == _keyCode )
		{
			_isDown = false;
		}
	}

	/**
	 * The counter to use when the key is down.
	 */
	private function get_counter():Counter
	{
		return _counter;
	}
	private function set_counter( value:Counter ):Counter
	{
		_counter = value;
		return _counter;
	}
	
	/**
	 * The key code of the key that controls the counter.
	 */
	private function get_keyCode():Int
	{
		return _keyCode;
	}
	private function set_keyCode( value:Int ):Int
	{
		_keyCode = value;
		return _keyCode;
	}
	
	/**
	 * A reference to the stage
	 */
	private function get_stage():Stage
	{
		return _stage;
	}
	private function set_stage( value:Stage ):Stage
	{
		_stage = value;
		createListeners();
		return _stage;
	}
	
	public function startEmitter( emitter:Emitter ):Int
	{
		if( _isDown && !_stop )
		{
			return _counter.startEmitter( emitter );
		}
		_counter.startEmitter( emitter );
		return 0;
	}
	
	/**
	 * @inheritDoc
	 */
	public function updateEmitter( emitter:Emitter, time:Float ):Int
	{
		if( _isDown && !_stop )
		{
			return _counter.updateEmitter( emitter, time );
		}
		return 0;
	}
	
	/**
	 * Stops the emitter from emitting particles
	 */
	public function stop():Void
	{
		_stop = true;
	}
	
	/**
	 * Resumes the emitter after a stop
	 */
	public function resume():Void
	{
		_stop = false;
	}
	

	/**
	 * Indicates if the counter has emitted all its particles.
	 */
	public function get_complete():Bool
	{
		return _counter.complete;
	}
	
	/**
	 * Indicates if the counter is currently emitting particles
	 */
	public function get_running():Bool
	{
		return _counter.running;
	}
}
