package flints.common.activities;

import flints.common.emitters.Emitter;
import flints.common.behaviours.Behaviour;
import flints.common.activities.Activity;

/**
 * The Activity interface must be implemented by all emitter activities.
 * 
 * <p>An Activity is a class that is used to continuously modify an aspect 
 * of an emitter by updating the emitter every frame. Activities may, for 
 * example, move or rotate the emitter.</p>
 * 
 * <p>Activities are associated with emitters by using the emitter's 
 * addActivity method. Activities are removed from the emitter by using 
 * the emitter's removeActivity method.</p>
 * 
 * @see flints.common.emitters.Emitter#addActivity()
 * @see flints.common.emitters.Emitter#removeActivity()
 */
interface Activity extends Behaviour
{
	/**
	 * The initialize method is used by the emitter to start the activity.
	 * It is called within the emitter's start method and need not
	 * be called by the user.
	 * 
	 * @param emitter The Emitter that is using the activity.
	 */
	function initialize( emitter:Emitter ):Void;
	
	/**
	 * The update method is used by the emitter to apply the activity.
	 * It is the key feature of the activity and is used to update the state
	 * of the emitter. This method is called within the emitter's update loop 
	 * and need not be called by the user.
	 * 
	 * @param emitter The Emitter that is using the activity.
	 * @param time The duration of the frame (in seconds) - used for time based 
	 * updates.
	 */
	function update( emitter:Emitter, time:Float ):Void;
}
