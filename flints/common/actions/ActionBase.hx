package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.ActionBase;
import flints.common.actions.Action;

/**
 * The ActionBase class is the abstract base class for all particle actions
 * in the Flint library. It implements the Action interface with a default
 * priority of zero and empty methods for the rest of the interface.
 * 
 * <p>Instances of the ActionBase class should not be directly created because 
 * the ActionBase class itself simply implements the Action interface with 
 * default methods that do nothing.</p>
 * 
 * <p>Developers creating custom actions may either extend the ActionBase
 * class or implement the Action interface directly. Classes that extend the 
 * ActionBase class need only to implement their own functionality for the 
 * methods they want to use, leaving other methods with their default empty
 * implementations.</p>
 * 
 * @see flints.common.emitters.Emitter#addAction()
 */
class ActionBase implements Action
{
	public var priority(get, set):Int;
	
	private var _priority:Int;
	
	/**
	 * The constructor creates an ActionBase object. But you shouldn't use it 
	 * directly because the ActionBase class is abstract.
	 */
	public function new()
	{
		_priority = 0;
	}
	
	/**
	 * Returns a default priority of 0 for this action. Derived classes 
	 * override this method if they want a different default priority.
	 * 
	 * @see flints.common.actions.Action#getDefaultPriority()
	 */
	private function get_priority():Int
	{
		return _priority;
	}
	private function set_priority( value:Int ):Int
	{
		_priority = value;
		return value;
	}
	
	/**
	 * This method does nothing. Some derived classes override this method
	 * to perform actions when the action is added to an emitter.
	 * 
	 * @param emitter The Emitter that the Action was added to.
	 * 
	 * @see flints.common.actions.Action#addedToEmitter()
	 */
	public function addedToEmitter( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. Some derived classes override this method
	 * to perform actions when the action is removed from the emitter.
	 * 
	 * @param emitter The Emitter that the Action was removed from.
	 * 
	 * @see flints.common.actions.Action#removedFromEmitter()
	 */
	public function removedFromEmitter( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. All derived classes override this method
	 * to update each particle every frame.
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
	}
}
