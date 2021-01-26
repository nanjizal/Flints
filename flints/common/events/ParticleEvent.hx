package flints.common.events;

import openfl.events.Event;
import flints.common.particles.Particle;
import flints.common.events.ParticleEvent;


/**
 * The class for particle related events dispatched by classes in the Flint project.
 */
class ParticleEvent extends Event
{
	/**
	 * The event dispatched by an emitter when a particle is created.
	 */
	public static var PARTICLE_CREATED:String = "particleCreated";
	
	/**
	 * The event dispatched by an emitter when a particle dies.
	 */
	public static var PARTICLE_DEAD:String = "particleDead";
	
	/**
	 * The event dispatched by an emitter when a pre-existing particle is added to it.
	 */
	public static var PARTICLE_ADDED:String = "particleAdded";
	
	/**
	 * The event dispatched by an emitter when a particle is removed from it (but doesn't die).
	 */
	public static var PARTICLE_REMOVED:String = "particleRemoved";

	/**
	 * The event dispatched by an emitter when a particle collides with another particle.
	 */
	public static var PARTICLES_COLLISION:String = "particlesCollision";
	
	/**
	 * The event dispatched by an emitter when a particle collides with a zone.
	 */
	public static var ZONE_COLLISION:String = "zoneCollision";
	
	/**
	 * The event dispatched by an emitter when a particle collides with another particle.
	 */
	public static var BOUNDING_BOX_COLLISION:String = "boundingBoxCollision";
	
	/**
	 * The particle to which the event relates.
	 */
	public var particle:Particle;
	
	/**
	 * The other object involved in the event. This may be null.
	 */
	public var otherObject:Dynamic;
	
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
	public function new( type : String, particle:Particle = null, bubbles : Bool = false, cancelable : Bool = false )
	{
		super(type, bubbles, cancelable);
		this.particle = particle;
	}

	/**
	 * Creates a copy of this event.
	 * 
	 * @return The copy of this event.
	 */
	override public function clone():Event
	{
		var e:ParticleEvent = new ParticleEvent( type, particle, bubbles, cancelable );
		e.otherObject = otherObject;
		return e;
	}
}
