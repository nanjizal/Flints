package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.Initializer;

/**
 * The InitializerBase class is the abstract base class for all particle 
 * initializers in the Flint library. It implements the Initializer interface 
 * with a default priority of zero and empty methods for the rest of the 
 * interface.
 * 
 * <p>Instances of the InitializerBase class should not be directly created 
 * because the InitializerBase class itself simply implements the Initializer
 * interface with default methods that do nothing.</p>
 * 
 * <p>Developers creating custom initializers may either extend the 
 * InitializerBase class or implement the Initializer interface directly. 
 * Classes that extend the InitializerBase class need only to implement their 
 * own functionality for the methods they want to use, leaving other methods 
 * with their default empty implementations.</p>
 * 
 * @see flints.common.emitters.Emitter#addInitializer()
 */
class InitializerBase implements Initializer
{
	public var priority(get, set):Int;
	
	private var _priority:Int;

	/**
	 * The constructor creates an Initializer object. But you shouldn't use 
	 * it directly because the InitializerBase class is abstract.
	 */
	public function new()
	{
		_priority = 0;
	}
	
	/**
	 * Returns a default priority of 0 for this action. Derived classes 
	 * overrid ethis method if they want a different default priority.
	 * 
	 * @see flints.common.initializers.Initializer#getDefaultPriority()
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
	 * to perform actions when the initializer is added to an emitter.
	 * 
	 * @see flints.common.initializers.Initializer#addedToEmitter()
	 */
	public function addedToEmitter( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. Some derived classes override this method
	 * to perform actions when the initializer is removed from the emitter.
	 * 
	 * @see flints.common.initializers.Initializer#removedFromEmitter()
	 */
	public function removedFromEmitter( emitter:Emitter ):Void
	{
	}
	
	/**
	 * This method does nothing. All derived classes override this method
	 * to initialize each particle created by the emitter.
	 * 
	 * @see flints.common.initializers.Initializer#initialize()
	 */
	public function initialize( emitter:Emitter, particle:Particle ):Void
	{
	}
}
