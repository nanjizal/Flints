package flints.common.activities;

import flints.common.emitters.Emitter;
import flints.common.activities.FrameUpdatable;
import flints.common.activities.UpdateOnFrame;
import flints.common.activities.ActivityBase;

/**
 * The UpdateOnFrame activity is used to call a frameUpdate method of an object 
 * that implements the FrameUpdatable interface. The frameUpdate method is called
 * once every frame.
 * 
 * <p>This activity is most often used to update an action once every frame.
 * Because the update method of an action is called once for every particle, 
 * every frame, there is no obvious point for an action to implement code
 * that should be called once only every frame, irrespective of the number
 * of particles. If the action implements FrameUpdatable and adds an 
 * UpdateOnFrame activity to the emitter in its addedToEmitter method, the
 * frameUpdate method will be called once every frame.</p>
 * 
 * <p>See the Explosion Action for an example of an action that uses this 
 * activity.</p>
 * 
 * @see flints.twoD.actions.Explosion
 */
class UpdateOnFrame extends ActivityBase
{
	private var action:FrameUpdatable;
	/**
	 * The constructor creates an UpdateOnFrame activity.
	 * 
	 * @param fu The object that shouldbe updated every frame.
	 */
	public function new( frameUpdatable:FrameUpdatable )
	{
		super();
		action = frameUpdatable;
	}
	
	/**
	 * Calls the frameUpdate method of the FrameUpdatable object associated
	 * with this activity.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user</p>
	 * 
	 * @param emitter The Emitter.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Activity#update()
	 */
	override public function update( emitter:Emitter, time:Float ):Void
	{
		action.frameUpdate( emitter, time );
	}
}
