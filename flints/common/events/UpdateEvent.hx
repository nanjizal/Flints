package flints.common.events;

import openfl.events.Event;

import flints.common.events.UpdateEvent;

/**
 * The UpdateEvent is dispatched from the FrameUpdater utility every frame, to all emitters that are
 * being updated by Flint, to trigger the update cycle on each emitter.
 */
class UpdateEvent extends Event
{
	/**
	 * The event dispatched on the enter frame
	 */
	public static inline var UPDATE:String = "update";
	
	/**
	 * The particle to which the event relates.
	 */
	public var time:Float;
	
	/**
	 * The constructor creates a ParticleEvent object.
	 * 
	 * @param type The type of the event, accessible as Event.type.
	 * @param particle The particle to which teh event relates.
	 * @param bubbles Determines whether the Event object participates 
	 * in the bubbling stage of the event flow. The default value is false.
	 * @param cancelable Determines whether the Event object can be 
	 * canceled. The default values is false.
	 */
	//public function new( type : String, time:Float = NaN, bubbles : Bool = false, cancelable : Bool = false )
	/**
	 * TODO: could not set NaN to time value by default
	 */
	public function new( type : String, time:Float = 0, bubbles : Bool = false, cancelable : Bool = false )
	{
		super(type, bubbles, cancelable);
		this.time = time;
	}
	
	/**
	 * Creates a copy of this event.
	 * 
	 * @return The copy of this event.
	 */
	override public function clone():Event
	{
		return new UpdateEvent( type, time, bubbles, cancelable );
	}
}
