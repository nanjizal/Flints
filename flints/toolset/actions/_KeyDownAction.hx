package flints.common.actions;

//import openfl.display.Stage;
//import openfl.events.KeyboardEvent;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.Action;
import flints.common.actions.KeyDownAction;
import flints.actions.ActionBase;


/**
 * The KeyDownAction Action uses another action. It applies the other action
 * to the particles only if a specified key is down.
 * 
 * @see flints.common.actions.Action
 */

class KeyDownAction extends ActionBase
{
	public var stage(get, set):Stage;
	public var action(get, set):Action;
	public var keyCode(get, set):Int;
	
	private var _action:Action;
	private var _keyCode:Int;
	private var _isDown:Bool;
	private var _stage:Stage;

	/**
	 * The constructor creates a KeyDownAction action for use by 
	 * an emitter. To add a KeyDownAction to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.emitters.Emitter#addAction()
	 * 
	 * @param action The action to apply when the key is down.
	 * @param keyCode The key code of the key that controls the action.
	 * @param stage A reference to the stage.
	 */
	public function new( action:Action= null, keyCode:Int = 0, stage:Stage = null )
	{
		super();
		_action = action;
		_keyCode = keyCode;
		_isDown = false;
		_stage = stage;
		createListeners();
	}
	
	private function createListeners():Void
	{
		if( _stage != null )
		{
			//_stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener, false, 0, true );
			_stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener );
			//_stage.addEventListener( KeyboardEvent.KEY_UP, keyUpListener, false, 0, true );
			_stage.addEventListener( KeyboardEvent.KEY_UP, keyUpListener );
		}
	}
	
	private function keyDownListener( ev:KeyboardEvent ):Void
	{
		if( Std.int (ev.keyCode) == _keyCode )
		{
			_isDown = true;
		}
	}
	private function keyUpListener( ev:KeyboardEvent ):Void
	{
		if( Std.int (ev.keyCode) == _keyCode )
		{
			_isDown = false;
		}
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
	
	/**
	 * The action to apply when the key is down.
	 */
	private function get_action():Action
	{
		return _action;
	}
	private function set_action( value:Action ):Action
	{
		_action = value;
		return _action;
	}
	
	/**
	 * The key code of the key that controls the action.
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
	 * Returns the default priority of the action that is applied.
	 * 
	 * @see flints.common.actions.Action#getDefaultPriority()
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
	 * Calls the addedToEmitter method of the action that is applied
	 * 
	 * @param emitter The Emitter that the Action was added to.
	 * 
	 * @see flints.common.actions.Action#addedToEmitter()
	 */
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		_action.addedToEmitter( emitter );
	}
	
	/**
	 * Calls the removedFromEmitter method of the action that is applied
	 * 
	 * @param emitter The Emitter that the Action was removed from.
	 * 
	 * @see flints.common.actions.Action#removedFromEmitter()
	 */
	override public function removedFromEmitter( emitter:Emitter ):Void
	{
		_action.removedFromEmitter( emitter );
	}

	/**
	 * If the key is down, this method calls the update method of the 
	 * action that is applied.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		if( _isDown )
		{
			_action.update( emitter, particle, time );
		}
	}
}
