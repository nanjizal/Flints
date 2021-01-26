package flints.common.activities;

import flints.common.emitters.Emitter;
import flints.common.activities.FrameUpdatable;

/**
 * The FrameUpdatable interface is used by the UpdateOnFrame activity.
 * 
 * @see flints.common.activities.UpdateOnFrame
 */
interface FrameUpdatable 
{
	/**
	 * When used with the UpdateOnFrame activity, the frameUpdate method will be called by the emitter
	 * every frame before updating the particles.
	 */
	function frameUpdate( emitter:Emitter, time:Float ):Void;
}
