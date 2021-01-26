package flints.common.behaviours;

import flints.common.emitters.Emitter;
import flints.common.behaviours.Behaviour;

/**
 * The Behaviour interface is the base for the Action, Initializer and 
 * Activity interfaces.
 */
interface Behaviour
{
	public var priority(get, set) : Int;
	
	/**
	 * The priority property is used to order the execution of behaviours.
	 * 
	 * <p>The behaviours within the Flint library use 0 as the default priority. 
	 * Some behaviours that need to be called early have priorities of 10 or 20.
	 * Behaviours that need to be called late have priorities of -10 or -20.</p>
	 * 
	 * <p>For example, the move action has a priority of -20 because the movement
	 * should be performed last, after other actions have made changes
	 * to the particle's velocity.</p>
	 */
	private function get_priority():Int;
	private function set_priority( value:Int ):Int;
	
	/**
	 * The addedToEmitter method is called by the emitter when the Behaviour is 
	 * added to it. It is an opportunity for a behaviour to do any initializing
	 * that is relative to the emitter. Only a few behaviours make use of this
	 * method. It is called by the emitter and need not be called by the user.
	 * 
	 * @param emitter The Emitter that the Behaviour was added to.
	 */
	function addedToEmitter( emitter:Emitter ):Void;
	
	/**
	 * The removedFromEmitter method is called by the emitter when the Behaviour 
	 * is removed from it. It is an opportunity for a behaviour to do any finalizing
	 * that is relative to the emitter. Only a few behaviours make use of this
	 * method. It is called by the emitter and need not be called by the user.
	 * 
	 * @param emitter The Emitter that the Behaviour was removed from.
	 */
	function removedFromEmitter( emitter:Emitter ):Void;
}
