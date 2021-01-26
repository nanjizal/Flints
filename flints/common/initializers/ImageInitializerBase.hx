package flints.common.initializers;
// TODO: NOT HAPPY ABOUT DYNAMIC... investigate!
import openfl.errors.Error;
import flints.common.particles.Particle;
import flints.common.events.ParticleEvent;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.ImageInitializerBase;

/**
 * The ImageInitializerBase is the base class for image initializers.
 * It adds the option to pool the images for reuse after a particle dies 
 * and to fill the pool with a set of images in advance.
 */
class ImageInitializerBase extends InitializerBase
{
	public var usePool(get, set):Bool;
	
	private var _usePool:Bool;
	private var _pool:Array<Dynamic>;
	private var _emitters:Array<Dynamic>;
	
	/**
	 * The constructor is usually called by the constructor of the class that extends this.
	 * 
	 * @param usePool Whether the images should be pooled for reuse when a particle dies
	 * @param fillPool How many images to create immediately for reuse as particles need them
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( usePool:Bool = false, fillPool:Int = 0 )
	{
		super();
		_usePool = usePool;
		_emitters = new Array<Dynamic>();
		if( _usePool )
		{
			clearPool();
			if( fillPool > 0 )
			{
				this.fillPool( fillPool );
			}
		}
	}
	
	/**
	 * Clears the image pool, forcing all particles to be created anew.
	 */
	public function clearPool():Void
	{
		_pool = new Array<Dynamic>();
	}
	
	/**
	 * When added to an emitter, the initializer will start listening for dead particles
	 * so their images may be pooled. The initializer will only pool images that it created.
	 */
	override public function addedToEmitter( emitter:Emitter ) : Void
	{
		_emitters.push( emitter );
		if( _usePool )
		{
			emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, particleDying, false, -1000, true );
		}
	}
	
	private function particleDying( event : ParticleEvent ) : Void
	{
		if( event.particle.isDead && event.particle.dictionary.exists(this) )
		{
			_pool.push( event.particle.image );
			//delete event.particle.dictionary[this];
			event.particle.dictionary.remove(this);
		}
	}
	
	/**
	 * When removed from an emitter, the initializer will stop listening for dead particles from that emitter.
	 */
	override public function removedFromEmitter( emitter:Emitter ) : Void
	{
		emitter.removeEventListener( ParticleEvent.PARTICLE_DEAD, particleDying );
		var index:Int = Lambda.indexOf(_emitters, emitter);
		if( index != -1 )
		{
			_emitters.splice( index, 1 );
		}
	}
	
	/**
	 * Fills the pool with a given number of particles.
	 * 
	 * @param count The number of particles to create.
	 */
	public function fillPool( count:Int ) : Void
	{
		if( !_usePool )
		{
			return;
		}
		if( _pool.length > 0 )
		{
			_pool = new Array<Dynamic>();
		}
		//for( var i:Int = 0; i < count; ++i )
		for( i in 0 ... count )
		{
			_pool[i] = createImage();
		}
	}
	
	/**
	 * Whether the images should be pooled for reuse when a particle dies
	 */
	private function get_usePool():Bool
	{
		return _usePool;
	}
	private function set_usePool( value:Bool ) : Bool
	{
		if( _usePool != value )
		{
			_usePool = value;
			var emitter:Emitter;
			if( _usePool )
			{
				for( emitter in _emitters.iterator() )
				{
					emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, particleDying, false, -1000, true );
				}
			}
			else
			{
				for( emitter in _emitters.iterator() )
				{
					emitter.removeEventListener( ParticleEvent.PARTICLE_DEAD, particleDying );
				}
			}
		}
		return _usePool;
	}
	
	/**
	 * The method to create an image for a particle. This should be overridden in the class that extends this one.
	 */
	public function createImage() : Dynamic
	{
		throw new Error( "Image initializer must override the createImage method." );
		return null;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		if( _usePool )
		{
			if( _pool.length > 0 )
			{
				particle.image = _pool.shift();
			}
			else
			{
				particle.image = createImage();
			}
			//particle.dictionary[this] = true;
			particle.dictionary.set(this, true);
		}
		else
		{
			particle.image = createImage();
		}
	}
}
