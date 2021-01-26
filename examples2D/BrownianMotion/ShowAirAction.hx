import openfl.display.DisplayObject;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.common.particles.Particle;

/**
 * The KeyDownAction Action uses another action. It applies the other action
 * to the particles only if a specified key is down.
 * 
 * @see flints.common.actions.Action
 */
class ShowAirAction extends ActionBase
{

	var _isDown : Bool;
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
  public function new(stage : DisplayObject)
	{
    super ();

		_isDown = false;
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener, false, 0, true);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener, false, 0, true);
	}

	function keyDownListener(ev : KeyboardEvent) : Void
	{
		if(ev.keyCode == Keyboard.SHIFT) 
		{
			_isDown = true;
		}
	}

	function keyUpListener(ev : KeyboardEvent) : Void
	{
		if(ev.keyCode == Keyboard.SHIFT) 
		{
			_isDown = false;
		}
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
  override public function update(emitter : Emitter, particle : Particle, time : Float) : Void
	{
		if(particle.mass == 1) 
		{
			if(_isDown) 
			{
				particle.color = 0;
			}

			else 
			{
				particle.color = 0xFF666666;
			}

		}
	}

}

