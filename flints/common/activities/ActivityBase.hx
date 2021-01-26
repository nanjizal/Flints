package flints.common.activities;

import flints.common.emitters.Emitter;
import flints.activities.ActivityBase;
import flints.common.activities.Activity;

/**
 * The ActivityBase class is the abstract base class for all emitter activities
 * in the Flint library. It implements the Activity interface with a default
 * priority of zero and empty methods for the rest of the interface.
 * 
 * <p>Instances of the ActivityBase class should not be directly created 
 * because the ActivityBase class itself simply implements the Activity 
 * interface with default methods that do nothing.</p>
 * 
 * <p>Developers creating custom activities may either extend the ActivityBase
 * class or implement the Activity interface directly. Classes that extend the 
 * ActivityBase class need only to implement their own functionality for the 
 * methods they want to use, leaving other methods with their default empty
 * implementations.</p>
 * 
 * @see flints.common.emitters.Emitter#addActivity()
 */
class ActivityBase implements Activity
{
	public var priority(get, set):Int;
	private var _priority:Int;

	/**
	 * The constructor creates an ActivityBase object. But you shouldn't use it 
	 * directly because the ActivityBase class is abstract.
	 */
	public function new()
	{
		_priority = 0;
	}

	/**
	 * Returns a default priority of 0 for this activity. Derived classes 
	 * override this method if they want a different default priority.
	 * 
	 * @see flints.common.actions.Activity#getDefaultPriority()
	 */
	private function get_priority():Int
	{
		return _priority;
	}
	private function set_priority( value:Int ):Int
	{
		_priority = value;
		return _priority;
	}
	
	/**
	 * This method does nothing. Some derived classes override this method
	 * to perform actions when the activity is added to an emitter.
	 * 
	 * @param emitter The Emitter that the Activity was added to.
	 * 
	 * @see flints.common.actions.Activity#addedToEmitter()
	 */
	public function addedToEmitter( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. Some derived classes override this method
	 * to perform actions when the activity is removed from the emitter.
	 * 
	 * @param emitter The Emitter that the Action was removed from.
	 * 
	 * @see flints.common.actions.Activity#removedFromEmitter()
	 */
	public function removedFromEmitter( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. Derived classes override this method
	 * to alter the state of the emitter when it starts.
	 * 
	 * @param emitter The Emitter.
	 * 
	 * @see flints.common.actions.Activity#initialize()
	 */
	public function initialize( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. Derived classes override this method
	 * to alter the state of the emitter every frame.
	 * 
	 * @param emitter The Emitter.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Activity#update()
	 */
	public function update( emitter:Emitter, time:Float ):Void
	{
	}
}
