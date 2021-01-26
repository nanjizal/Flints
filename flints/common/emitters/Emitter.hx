package flints.common.emitters;

import jota.utils.ArrayUtils; // RE-THINK+
//import openfl.display.DisplayObjectContainer;
//import openfl.events.EventDispatcher;
import flints.common.actions.Action;
import flints.common.activities.Activity;
import flints.common.behaviours.Behaviour;
import flints.common.counters.Counter;
import flints.common.counters.ZeroCounter;
import flints.common.emitters.Emitter;
import flints.common.events.EmitterEvent;
import flints.common.events.ParticleEvent;
import flints.common.events.UpdateEvent;
import flints.common.initializers.Initializer;
import flints.common.particles.Particle;
import flints.common.particles.ParticleFactory;
import flints.common.utils.FrameUpdater;

/**
 * Dispatched when a particle dies and is about to be removed from the system.
 * As soon as the event has been handled the particle will be removed but at the
 * time of the event it still exists so its properties (e.g. its location) can be
 * read from it.
 *
 * @eventType flints.common.events.ParticleEvent.PARTICLE_DEAD
 */
//[Event(name="particleDead", type="flints.common.events.ParticleEvent")];
/**
 * Dispatched when a particle is created and has just been added to the emitter.
 *
 * @eventType flints.common.events.ParticleEvent.PARTICLE_CREATED
 */
//[Event(name="particleCreated", type="flints.common.events.ParticleEvent")];
/**
 * Dispatched when a pre-existing particle is added to the emitter.
 *
 * @eventType flints.common.events.ParticleEvent.PARTICLE_ADDED
 */
//[Event(name="particleAdded", type="flints.common.events.ParticleEvent")];
/**
 * Dispatched when an emitter attempts to update the particles' state but it
 * contains no particles. This event will be dispatched every time the update
 * occurs and there are no particles in the emitter. The update does not occur
 * when the emitter has not yet been started, when the emitter is paused, and
 * after the emitter has been stopped, so the event will not be dispatched
 * at these times.
 *
 * <p>See the firework example for an example that uses this event.</p>
 *
 * @see start();
 * @see pause();
 * @see stop();
 *
 * @eventType flints.common.events.EmitterEvent.EMITTER_EMPTY
 */
//[Event(name="emitterEmpty", type="flints.common.events.EmitterEvent")];
/**
 * Dispatched when the particle system has updated and the state of the particles
 * has changed.
 *
 * @eventType flints.common.events.EmitterEvent.EMITTER_UPDATED
 */
//[Event(name="emitterUpdated", type="flints.common.events.EmitterEvent")];
/**
 * Dispatched when the counter for the particle system has finished its cycle and so
 * the system will not emit any more particles unless the counter is changed or restarted.
 *
 * @eventType flints.common.events.EmitterEvent.COUNTER_COMPLETE
 */
//[Event(name="counterComplete", type="flints.common.events.EmitterEvent")];

/**
 * The Emitter class is the base class for the Emitter2D and Emitter3D classes.
 * The emitter class contains the common behavioour used by these two concrete
 * classes.
 *
 * <p>An Emitter manages the creation and ongoing state of particles. It uses
 * a number of utility classes to customise its behaviour.</p>
 *
 * <p>An emitter uses Initializers to customise the initial state of particles
 * that it creates; their position, velocity, color etc. These are added to the
 * emitter using the addInitializer method.</p>
 *
 * <p>An emitter uses Actions to customise the behaviour of particles that
 * it creates; to apply gravity, drag, fade etc. These are added to the emitter
 * using the addAction method.</p>
 *
 * <p>An emitter uses Activities to alter its own behaviour, to move it or rotate
 * it for example.</p>
 *
 * <p>An emitter uses a Counter to know when and how many particles to emit.</p>
 *
 * <p>All timings in the emitter are based on actual time passed,
 * independent of the frame rate of the flash movie.</p>
 *
 * <p>Most functionality is best added to an emitter using Actions,
 * Initializers, Activities and Counters. This offers greater
 * flexibility to combine behaviours without needing to subclass
 * the Emitter classes.</p>
 */
class Emitter extends EventDispatcher {
	public var maximumFrameTime(get, set):Float;
	public var actions(get, set):Array<Action>;
	public var particles(get, set):Array<Particle>;
	public var running(get, never):Bool;
	public var activities(get, set):Array<Activity>;
	public var particleFactory(get, set):ParticleFactory;
	public var useInternalTick(get, set):Bool;
	public var fixedFrameTime(get, set):Float;
	public var counter(get, set):Counter;
	public var particlesArray(get, never):Array<Dynamic>;
	public var initializers(get, set):Array<Initializer>;

	/**
	 * @private
	 */
	private var _particleFactory:ParticleFactory;

	/**
	 * @private
	 */
	private var _initializers:Array<Initializer>;

	/**
	 * @private
	 */
	private var _actions:Array<Action>;

	/**
	 * @private
	 */
	private var _activities:Array<Activity>;

	/**
	 * @private
	 */
	private var _particles:Array<Particle>;

	/**
	 * @private
	 */
	private var _counter:Counter;

	/**
	 * @private
	 */
	private var _useInternalTick:Bool;

	/**
	 * @private
	 */
	private var _fixedFrameTime:Float;

	/**
	 * @private
	 */
	private var _running:Bool;

	/**
	 * @private
	 */
	private var _started:Bool;

	/**
	 * @private
	 */
	private var _updating:Bool;

	/**
	 * @private
	 */
	private var _maximumFrameTime:Float;

	/**
	 * Indicates if the emitter should dispatch a counterComplete event at the
	 * end of the next update cycle.
	 */
	private var _dispatchCounterComplete:Bool;

	/**
	 * Used to alternate the direction in which the particles in the particles
	 * array are processed, to iron out errors from always processing them in
	 * the same order.
	 */
	private var _processLastFirst:Bool;

	/**
	 * The constructor creates an emitter.
	 *
	 * @param useInternalTick Indicates whether the emitter should use its
	 * own tick event to update its state. The internal tick process is tied
	 * to the framerate and updates the particle system every frame.
	 */
	public function new() {
		super();
		_particles = [];
		_actions = [];
		_initializers = [];
		_activities = [];
		_counter = new ZeroCounter();
		_useInternalTick = true;
		_fixedFrameTime = 0;
		_running = false;
		_started = false;
		_updating = false;
		_maximumFrameTime = 0.1;
		_dispatchCounterComplete = false;
		_processLastFirst = false;
	}

	/**
	 * The maximum duration for a single update frame, in seconds.
	 *
	 * <p>Under some circumstances related to the Flash player (e.g. on MacOSX, when the
	 * user right-clicks on the flash movie) the flash movie will freeze for a period. When the
	 * freeze ends, the current frame of the particle system will be calculated as the time since
	 * the previous frame,  which encompases the duration of the freeze. This could cause the
	 * system to generate a single frame update that compensates for a long period of time and
	 * hence moves the particles an unexpected long distance in one go. The result is usually
	 * visually unacceptable and certainly unexpected.</p>
	 *
	 * <p>This property sets a maximum duration for a frame such that any frames longer than
	 * this duration are ignored. The default value is 0.5 seconds. Developers don't usually
	 * need to change this from the default value.</p>
	 */
	private function get_maximumFrameTime():Float {
		return _maximumFrameTime;
	}

	private function set_maximumFrameTime(value:Float):Float {
		_maximumFrameTime = value;
		return _maximumFrameTime;
	}

	/**
	 * The array of all initializers being used by this emitter.
	 */
	private function get_initializers():Array<Initializer> {
		return _initializers;
	}

	private function set_initializers(value:Array<Initializer>):Array<Initializer> {
		var initializer:Initializer;
		for (initializer in _initializers) {
			initializer.removedFromEmitter(this);
		}

		/**
		 * TODO: check if this is cleaning the vector?
		 */
		_initializers = _initializers.slice(_initializers.length);

		//_initializers = value.slice();
		_initializers.sort(prioritySort);
		for (initializer in value) {
			initializer.addedToEmitter(this);
		}
		return _initializers;
	}

	/**
	 * Adds an Initializer object to the Emitter. Initializers set the
	 * initial state of particles created by the emitter.
	 *
	 * @param initializer The Initializer to add
	 *
	 * @see removeInitializer()
	 * @see flints.common.initializers.Initializer.getDefaultPriority()
	 */
	public function addInitializer(initializer:Initializer):Void {
		var len:Int = _initializers.length;
		var i:Int = 0;
		while (i < len) {
			if (_initializers[i].priority < initializer.priority) {
				break;
			}
			++i;
		}

		/**
		 * TODO: insert value into vector works
		 */
		//_initializers.splice( i, 0, initializer );
		_initializers = ArrayUtils.insertIntoVector([i, initializer, _initializers]);

		initializer.addedToEmitter(this);
	}

	/**
	 * Removes an Initializer from the Emitter.
	 *
	 * @param initializer The Initializer to remove
	 *
	 * @see addInitializer()
	 */
	public function removeInitializer(initializer:Initializer):Void {
		//var index:Int = _initializers.indexOf( initializer );

		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;

		for (i in 0..._initializers.length) {
			if (_initializers[i] == initializer) {
				index = i;
				break;
			}
		}
		if (index != -1) {
			_initializers.splice(index, 1);
			initializer.removedFromEmitter(this);
		}
	}

	/**
	 * Removes all Initializers from the Emitter.
	 *
	 * @see removeInitializer()
	 */
	public function removeAllInitializers():Void {
		var initializer:Initializer;
		while (_initializers.length > 0) {
			initializer = _initializers.pop();
			initializer.removedFromEmitter(this);
		}
	}

	/**
	 * Detects if the emitter is using a particular initializer or not.
	 *
	 * @param initializer The initializer to look for.
	 *
	 * @return true if the initializer is being used by the emitter, false
	 * otherwise.
	 */
	public function hasInitializer(initializer:Initializer):Bool {
		//return _initializers.indexOf( initializer ) != -1;

		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;

		for (i in 0..._initializers.length) {
			if (_initializers[i] == initializer) {
				index = i;
				break;
			}
		}
		return index != -1;
	}

	/**
	 * Detects if the emitter is using an initializer of a particular class.
	 *
	 * @param initializerClass The type of initializer to look for.
	 *
	 * @return true if the emitter is using an instance of the class as an
	 * initializer, false otherwise.
	 */
	public function hasInitializerOfType(initializerClass:Dynamic):Bool {
		var len:Int = _initializers.length;
		var i:Int = 0;
		while (i < len) {
			if (Std.is(_initializers[i], initializerClass)) {
				return true;
			}
			++i;
		}
		return false;
	}

	/**
	 * The array of all actions being used by this emitter.
	 */
	private function get_actions():Array<Action> {
		return _actions;
	}

	private function set_actions(value:Array<Action>):Array<Action> {
		var action:Action;
		for (action in _actions) {
			action.removedFromEmitter(this);
		}

		/**
		 * TODO: check if cleans vector
		 */
		_actions = _actions.slice(_actions.length);

		//_actions = value.slice();
		_actions.sort(prioritySort);
		for (action in value) {
			action.addedToEmitter(this);
		}
		return _actions;
	}

	/**
	 * Adds an Action to the Emitter. Actions set the behaviour of particles
	 * created by the emitter.
	 *
	 * @param action The Action to add
	 *
	 * @see removeAction();
	 * @see flints.common.actions.Action.getDefaultPriority()
	 */
	public function addAction(action:Action):Void {
		var len:Int = _actions.length;
		var i:Int = 0;
		while (i < len) {
			if (_actions[i].priority < action.priority) {
				break;
			}
			++i;
		}

		/**
		 * TODO: insert into vector
		 */
		//_actions.splice( i, 0, action );
		_actions = ArrayUtils.insertIntoVector([i, action, _actions]);

		action.addedToEmitter(this);
	}

	/**
	 * Removes an Action from the Emitter.
	 *
	 * @param action The Action to remove
	 *
	 * @see addAction()
	 */
	public function removeAction(action:Action):Void {
		//var index:Int = _actions.indexOf( action );

		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;

		for (i in 0..._actions.length) {
			if (_actions[i] == action) {
				index = i;
				break;
			}
		}
		if (index != -1) {
			_actions.splice(index, 1);
			action.removedFromEmitter(this);
		}
	}

	/**
	 * Detects if the emitter is using a particular action or not.
	 *
	 * @param action The action to look for.
	 *
	 * @return true if the action is being used by the emitter, false
	 * otherwise.
	 */
	public function hasAction(action:Action):Bool {
		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;

		for (i in 0..._actions.length) {
			if (_actions[i] == action) {
				index = i;
				break;
			}
		}
		return index != -1;
	}

	/**
	 * Detects if the emitter is using an action of a particular class.
	 *
	 * @param actionClass The type of action to look for.
	 *
	 * @return true if the emitter is using an instance of the class as an
	 * action, false otherwise.
	 */
	public function hasActionOfType(actionClass:Dynamic):Bool {
		var len:Int = _actions.length;
		var i:Int = 0;
		while (i < len) {
			if (Std.is(_actions[i], actionClass)) {
				return true;
			}
			++i;
		}
		return false;
	}

	/**
	 * The array of all actions being used by this emitter.
	 */
	private function get_activities():Array<Activity> {
		return _activities;
	}

	private function set_activities(value:Array<Activity>):Array<Activity> {
		var activity:Activity;
		for (activity in _activities) {
			activity.removedFromEmitter(this);
		}
		//_activities = value.slice();

		/**
		 * TODO: check slice
		 */
		_activities = _activities.slice(_activities.length);

		//_activities = value.slice(0);
		_activities.sort(prioritySort);
		for (activity in _activities) {
			activity.addedToEmitter(this);
		}
		return _activities;
	}

	/**
	 * Adds an Activity to the Emitter. Activities set the behaviour
	 * of the Emitter.
	 *
	 * @param activity The activity to add
	 *
	 * @see removeActivity()
	 * @see flints.common.activities.Activity.getDefaultPriority()
	 */
	public function addActivity(activity:Activity):Void {
		var len:Int = _activities.length;
		var i:Int = 0;
		while (i < len) {
			if (_activities[i].priority < activity.priority) {
				break;
			}
			++i;
		}

		/**
		 * TODO: insert into vector
		 */
		_activities = ArrayUtils.insertIntoVector([i, activity, _activities]);

		//_activities.splice( i, 0, activity );
		activity.addedToEmitter(this);
	}

	/**
	 * Removes an Activity from the Emitter.
	 *
	 * @param activity The Activity to remove
	 *
	 * @see addActivity()
	 */
	public function removeActivity(activity:Activity):Void {
		//var index:Int = _activities.indexOf( activity );

		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;

		for (i in 0..._activities.length) {
			if (_activities[i] == activity) {
				index = i;
				break;
			}
		}
		if (index != -1) {
			_activities.splice(index, 1);
			activity.removedFromEmitter(this);
		}
	}

	/**
	 * Detects if the emitter is using a particular activity or not.
	 *
	 * @param activity The activity to look for.
	 *
	 * @return true if the activity is being used by the emitter, false
	 * otherwise.
	 */
	public function hasActivity(activity:Activity):Bool {
		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;

		for (i in 0..._activities.length) {
			if (_activities[i] == activity) {
				index = i;
				break;
			}
		}
		return index != -1;
	}

	/**
	 * Detects if the emitter is using an activity of a particular class.
	 *
	 * @param activityClass The type of activity to look for.
	 *
	 * @return true if the emitter is using an instance of the class as an
	 * activity, false otherwise.
	 */
	public function hasActivityOfType(activityClass:Dynamic):Bool {
		var len:Int = _activities.length;
		var i:Int = 0;
		while (i < len) {
			if (Std.is(_activities[i], activityClass)) {
				return true;
			}
			++i;
		}
		return false;
	}

	/**
	 * The Counter for the Emitter. The counter defines when and
	 * with what frequency the emitter emits particles.
	 */
	private function get_counter():Counter {
		return _counter;
	}

	private function set_counter(value:Counter):Counter {
		_counter = value;
		if (running) {
			_counter.startEmitter(this);
		}
		return _counter;
	}

	/**
	 * Used by counters to tell the emitter to dispatch a counter complete event.
	 */
	public function dispatchCounterComplete():Void {
		_dispatchCounterComplete = true;
	}

	/**
	 * Indicates whether the emitter should manage its own internal update
	 * tick. The internal update tick is tied to the frame rate and updates
	 * the particle system every frame.
	 *
	 * <p>If users choose not to use the internal tick, they have to call
	 * the emitter's update method with the appropriate time parameter every
	 * time they want the emitter to update the particle system.</p>
	 */
	private function get_useInternalTick():Bool {
		return _useInternalTick;
	}

	private function set_useInternalTick(value:Bool):Bool {
		if (_useInternalTick != value) {
			_useInternalTick = value;
			if (_started) {
				if (_useInternalTick) {
					//FrameUpdater.instance().addEventListener( UpdateEvent.UPDATE, updateEventListener, false, 0, true );
					FrameUpdater.instance().addEventListener(UpdateEvent.UPDATE, updateEventListener);
				} else {
					FrameUpdater.instance().removeEventListener(UpdateEvent.UPDATE, updateEventListener);
				}
			}
		}
		return _useInternalTick;
	}

	/**
	 * Indicates a fixed time (in seconds) to use for every frame. Setting
	 * this property causes the emitter to bypass its frame timing
	 * functionality and use the given time for every frame. This enables
	 * the particle system to be frame based rather than time based.
	 *
	 * <p>To return to time based animation, set this value to zero (the
	 * default).</p>
	 *
	 * <p>This feature only works if useInternalTick is true (the default).</p>
	 *
	 * @see #useInternalTick
	 */
	private function get_fixedFrameTime():Float {
		return _fixedFrameTime;
	}

	private function set_fixedFrameTime(value:Float):Float {
		_fixedFrameTime = value;
		return _fixedFrameTime;
	}

	/**
	 * Indicates if the emitter is currently running.
	 */
	private function get_running():Bool {
		return _running;
	}

	/**
	 * This is the particle factory used by the emitter to create and dispose
	 * of particles. The 2D and 3D libraries each have a default particle
	 * factory that is used by the Emitter2D and Emitter3D classes. Any custom
	 * particle factory should implement the ParticleFactory interface.
	 * @see flints.common.particles.ParticleFactory
	 */
	private function get_particleFactory():ParticleFactory {
		return _particleFactory;
	}

	private function set_particleFactory(value:ParticleFactory):ParticleFactory {
		_particleFactory = value;
		return _particleFactory;
	}

	/**
	 * The collection of all particles being managed by this emitter.
	 */
	private function get_particles():Dynamic {
		return _particles;
	}

	private function set_particles(value:Array<Particle>):Array<Particle> {
		killAllParticles();
		addParticles(value, false);
		return _particles;
	}

	/**
	 * The actual array of particles used internally by this emitter. You may want to use this to manipulate
	 * the particles array directly or to provide optimized access to the array inside a custom
	 * behaviour. If you don't need the actual array, using the particles property is slightly safer.
	 *
	 * @see #particles
	 */
	private function get_particlesArray():Array<Particle> {
		return _particles;
	}

	/*
	 * Used internally to create a particle.
	 */
	private function createParticle():Particle {
		var particle:Particle = _particleFactory.createParticle();
		initParticle(particle);
		for (initializer in _initializers) {
			initializer.initialize(this, particle);
		}

		_particles.push(particle);
		if (hasEventListener(ParticleEvent.PARTICLE_CREATED)) {
			dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED, particle));
		}
		return particle;
	}

	/**
	 * Emitters do their own particle initialization here - usually involves
	 * positioning and rotating the particle to match the position and rotation
	 * of the emitter. This method is called before any initializers that are
	 * assigned to the emitter, so initializers can override any properties set
	 * here.
	 *
	 * <p>The implementation of this method in this base class does nothing.</p>
	 */
	private function initParticle(particle:Particle):Void {}

	/**
	 * Add a particle to the emitter. This enables users to create a
	 * particle externally to the emitter and then pass the particle to this
	 * emitter for management. Or remove a particle from one emitter and add
	 * it to another.
	 *
	 * @param particle The particle to add to this emitter
	 * @param applyInitializers Indicates whether to apply the emitter's
	 * initializer behaviours to the particle (true) or not (false).
	 *
	 * @see #removeParticle()
	 */
	public function addParticle(particle:Particle, applyInitializers:Bool = false):Void {
		if (applyInitializers) {
			for (initializer in _initializers) {
				initializer.initialize(this, particle);
			}
		}
		_particles.push(particle);
		if (hasEventListener(ParticleEvent.PARTICLE_ADDED)) {
			dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED, particle));
		}
	}

	/**
	 * Adds existing particles to the emitter. This enables users to create
	 * particles externally to the emitter and then pass the particles to the
	 * emitter for management. Or remove particles from one emitter and add
	 * them to another.
	 *
	 * @param particles The particles to add to this emitter
	 * @param applyInitializers Indicates whether to apply the emitter's
	 * initializer behaviours to the particle (true) or not (false).
	 *
	 * @see #removeParticles()
	 */
	public function addParticles(particles:Array<Particle>, applyInitializers:Bool = false):Void {
		var len:Int = particles.length;
		var i:Int;
		if (applyInitializers) {
			var len2:Int = _initializers.length;
			var j:Int = 0;
			while (j < len2) {
				for (i in 0...len) {
					_initializers[j].initialize(this, particles[i]);
				}
				++j;
			}
		}
		if (hasEventListener(ParticleEvent.PARTICLE_ADDED)) {
			for (i in 0...len) {
				_particles.push(particles[i]);
				dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED, particles[i]));
			}
		} else {
			for (i in 0...len) {
				_particles.push(particles[i]);
			}
		}
	}

	/**
	 * Remove a particle from this emitter.
	 *
	 * @param particle The particle to remove.
	 * @return true if the particle was removed, false if it wasn't on this emitter in the first place.
	 */
	public function removeParticle(particle:Particle):Bool {
		//var index:Int = _particles.indexOf( particle );
		var index:Int = Lambda.indexOf(_particles, particle);
		if (index != -1) {
			if (_updating) {
				/**
				 * TODO: remove particle and event listener
				 */
				//addEventListener( EmitterEvent.EMITTER_UPDATED, function( e:EmitterEvent ) : Void
				//{
				//removeEventListener( EmitterEvent.EMITTER_UPDATED, arguments.callee );
				//removeParticle( particle );
				//});
				addEventListener(EmitterEvent.EMITTER_UPDATED, function(e:EmitterEvent):Void {
					removeParticle(particle);
				});

				//addEventListener( EmitterEvent.EMITTER_UPDATED, removeParticleProxy);
			} else {
				_particles.splice(index, 1);
				dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_REMOVED, particle));
			}
			return true;
		}
		return false;
	}

	public function removeParticleProxy(e:EmitterEvent):Void {
		cast(e.target, DisplayObjectContainer).removeEventListener(EmitterEvent.EMITTER_UPDATED, removeParticleProxy);
		removeParticle(e.target);
	}

	/**
	 * Remove a collection of particles from this emitter.
	 *
	 * @param particles The particles to remove.
	 */
	public function removeParticles(particles:Array<Particle>):Void {
		if (_updating) {
			/**
			 * TODO: remove particle and event listener
			 */
			//addEventListener( EmitterEvent.EMITTER_UPDATED, function( e:EmitterEvent ) : Void
			//{
			//removeEventListener( EmitterEvent.EMITTER_UPDATED, arguments.callee );
			//removeParticles( particles );
			//});
			addEventListener(EmitterEvent.EMITTER_UPDATED, function(e:EmitterEvent):Void {
				removeParticles(particles);
			});
		} else {
			var i:Int = 0;
			var len:Int = particles.length;
			while (i < len) {
				var index:Int = Lambda.indexOf(_particles, particles[i]);
				if (index != -1) {
					_particles.splice(index, 1);
					dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_REMOVED, particles[i]));
				}
				++i;
			}
		}
	}

	/**
	 * Kill all the particles on this emitter.
	 */
	public function killAllParticles():Void {
		var len:Int = _particles.length;
		var i:Int;
		if (hasEventListener(ParticleEvent.PARTICLE_DEAD)) {
			for (i in 0...len) {
				dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD, _particles[i]));
				_particleFactory.disposeParticle(_particles[i]);
			}
		} else {
			for (i in 0...len) {
				_particleFactory.disposeParticle(_particles[i]);
			}
		}
		_particles = [];
	}

	/**
	 * Starts the emitter. Until start is called, the emitter will not emit or
	 * update any particles.
	 */
	public function start():Void {
		if (_useInternalTick) {
			//FrameUpdater.instanceGetter().addEventListener( UpdateEvent.UPDATE, updateEventListener, false, 0, true );
			FrameUpdater.instance().addEventListener(UpdateEvent.UPDATE, updateEventListener);
		}
		_started = true;
		_running = true;
		for (activity in _activities) {
			activity.initialize(this);
		}
		for (i in 0..._counter.startEmitter(this)) {
			createParticle();
		}
	}

	/**
	 * Update event listener used to fire the update function when using teh internal tick.
	 */
	private function updateEventListener(ev:UpdateEvent):Void {
		if (_fixedFrameTime > 0) {
			update(_fixedFrameTime);
		} else {
			update(ev.time);
		}
	}

	/**
	 * Used to update the emitter. If using the internal tick, this method
	 * will be called every frame without any action by the user. If not
	 * using the internal tick, the user should call this method on a regular
	 * basis to update the particle system.
	 *
	 * <p>The method asks the counter how many particles to create then creates
	 * those particles. Then it calls sortParticles, applies the activities to
	 * the emitter, applies the Actions to all the particles, removes all dead
	 * particles, and finally dispatches an emitterUpdated event which tells
	 * any renderers to redraw the particles.</p>
	 *
	 * @param time The duration, in seconds, to be applied in the update step.
	 *
	 * @see sortParticles();
	 */
	public function update(time:Float):Void {
		//trace("update");
		if (!_running) {
			return;
		}
		if (time > _maximumFrameTime) {
			time = _maximumFrameTime;
		}
		var i:Int;
		var particle:Particle;
		_updating = true;
		var len:Int = _counter.updateEmitter(this, time);
		//for (i in 0...len)
		i = 0;
		while (i < len) {
			createParticle();
			++i;
		}
		sortParticles();
		len = _activities.length;
		for (i in 0...len) {
			cast(_activities[i], Activity).update(this, time);
		}
		if (_particles.length > 0) {
			// update particle state
			len = _actions.length;
			var action:Action;
			var plen:Int = _particles.length;
			//trace(plen);
			var j:Int = 0;
			if (_processLastFirst) {
				j = 0;
				while (j < len) {
					action = _actions[j];
					//trace(action);
					i = plen - 1;
					while (i >= 0) {
						particle = _particles[i];
						action.update(this, particle, time);
						--i;
					}
					++j;
				}
			} else {
				//for (j in 0...len)
				j = 0;
				while (j < len) {
					action = _actions[j];
					//for (i in 0...plen)
					i = 0;
					while (i < plen) {
						particle = _particles[i];
						action.update(this, particle, time);
						++i;
					}
					++j;
				}
			}
			_processLastFirst = !_processLastFirst;

			// remove dead particles
			if (hasEventListener(ParticleEvent.PARTICLE_DEAD)) {
				i = plen;
				while (i-- > 0) {
					particle = _particles[i];
					if (particle.isDead) {
						_particles.splice(i, 1);
						dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD, particle));
						if (particle.isDead) {
							_particleFactory.disposeParticle(particle);
						}
					}
				}
			} else {
				i = plen;
				while (i-- > 0) {
					particle = _particles[i];
					if (particle.isDead) {
						_particles.splice(i, 1);
						_particleFactory.disposeParticle(particle);
					}
				}
			}
		} else {
			if (hasEventListener(EmitterEvent.EMITTER_EMPTY)) {
				dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
			}
		}
		_updating = false;
		if (hasEventListener(EmitterEvent.EMITTER_UPDATED)) {
			dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_UPDATED));
		}
		if (_dispatchCounterComplete) {
			_dispatchCounterComplete = false;
			if (hasEventListener(EmitterEvent.COUNTER_COMPLETE)) {
				dispatchEvent(new EmitterEvent(EmitterEvent.COUNTER_COMPLETE));
			}
		}
	}

	/**
	 * Used to sort the particles as required. In this base class this method
	 * does nothing.
	 */
	private function sortParticles():Void {}

	/**
	 * Pauses the emitter.
	 */
	public function pause():Void {
		_running = false;
	}

	/**
	 * Resumes the emitter after a pause.
	 */
	public function resume():Void {
		_running = true;
	}

	/**
	 * Stops the emitter, killing all current particles and returning them to the
	 * particle factory for reuse.
	 */
	public function stop():Void {
		if (_useInternalTick) {
			FrameUpdater.instance().removeEventListener(UpdateEvent.UPDATE, updateEventListener);
		}
		_started = false;
		_running = false;
		killAllParticles();
	}

	/**
	 * Makes the emitter skip forwards a period of time with a single update.
	 * Used when you want the emitter to look like it's been running for a while.
	 *
	 * @param time The time, in seconds, to skip ahead.
	 * @param frameRate The frame rate for calculating the new positions. The
	 * emitter will calculate each frame over the time period to get the new state
	 * for the emitter and its particles. A higher frameRate will be more
	 * accurate but will take longer to calculate.
	 */
	public function runAhead(time:Float, frameRate:Float = 10):Void {
		var maxTime:Float = _maximumFrameTime;
		var step:Float = 1 / frameRate;
		_maximumFrameTime = step;
		while (time > 0) {
			time -= step;
			update(step);
		}
		_maximumFrameTime = maxTime;
	}

	//private function prioritySort( b1:Behaviour, b2:Behaviour ):Float
	private function prioritySort(b1:Behaviour, b2:Behaviour):Int {
		return b1.priority - b2.priority;
	}
}
