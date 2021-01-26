package flints.common.renderers;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Vector;
import flints.common.particles.Particle;
import flints.common.events.ParticleEvent;
import flints.common.events.EmitterEvent;
import flints.common.emitters.Emitter;
import flints.common.renderers.SpriteRendererBase;
import flints.common.renderers.Renderer;


/**
 * The base class used by all the Flint renderers. This class manages
 * various aspects of the rendering process.
 * 
 * <p>The class will add every emitter it should renderer to it's internal
 * array of emitters. It will listen for the appropriate events on the 
 * emitter and will then call the protected methods addParticle, removeParticle
 * and renderParticles at the appropriate times. Many derived classes need 
 * only implement these three methods to manage the rendering of the particles.</p>
 */
class SpriteRendererBase extends Sprite implements Renderer 
{
	public var emitters(get, set):Vector<Emitter>;
	/**
	 * @private
	 * 
	 * We retain assigned emitters in this array merely so the reference exists and they are not
	 * garbage collected. This ensures the expected behaviour is achieved - an emitter that exists
	 * on a renderer is not garbage collected, an emitter that does not exist on a renderer may be 
	 * garbage collected if no other references exist.
	 */
	private var _emitters:Vector<Emitter>;
	
	private var _particles:Array<Dynamic>;
	
	/**
	 * The constructor creates a RendererBase class.
	 */
	public function new()
	{
		super();
		_emitters = new Vector<Emitter>();
		_particles = [];
		mouseEnabled = false;
		mouseChildren = false;
		//addEventListener( Event.ADDED_TO_STAGE, addedToStage, false, 0, true );
		addEventListener( Event.ADDED_TO_STAGE, addedToStage );
	}
	
	/**
	 * Adds the emitter to the renderer. When an emitter is added, the renderer
	 * invalidates its display so the renderParticles method will be called
	 * on the next render event in the frame update.
	 * 
	 * @param emitter The emitter that is added to the renderer.
	 */
	public function addEmitter( emitter : Emitter ) : Void
	{
		_emitters.push( emitter );
		if( stage != null )
		{
			#if (flash||cpp)
			stage.invalidate();
			#end
		}
		//emitter.addEventListener( EmitterEvent.EMITTER_UPDATED, emitterUpdated, false, 0, true );
		//emitter.addEventListener( ParticleEvent.PARTICLE_CREATED, particleAdded, false, 0, true );
		//emitter.addEventListener( ParticleEvent.PARTICLE_ADDED, particleAdded, false, 0, true );
		//emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, particleRemoved, false, 0, true );
		//emitter.addEventListener( ParticleEvent.PARTICLE_REMOVED, particleRemoved, false, 0, true );
		emitter.addEventListener( EmitterEvent.EMITTER_UPDATED, emitterUpdated );
		emitter.addEventListener( ParticleEvent.PARTICLE_CREATED, particleAdded );
		emitter.addEventListener( ParticleEvent.PARTICLE_ADDED, particleAdded );
		emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, particleRemoved );
		emitter.addEventListener( ParticleEvent.PARTICLE_REMOVED, particleRemoved );
		for( p in emitter.particlesArray.iterator() )
		{
			addParticle( p );
		}
		if( _emitters.length == 1 )
		{
			//addEventListener( Event.RENDER, updateParticles, false, 0, true );
			addEventListener( Event.RENDER, updateParticles );
		}
	}

	/**
	 * Removes the emitter from the renderer. When an emitter is removed, the renderer
	 * invalidates its display so the renderParticles method will be called
	 * on the next render event in the frame update.
	 * 
	 * @param emitter The emitter that is removed from the renderer.
	 */
	public function removeEmitter( emitter : Emitter ) : Void
	{
		//for( var i:Int = 0; i < _emitters.length; ++i )
		for( i in 0 ... _emitters.length )
		{
			if( _emitters[i] == emitter )
			{
				_emitters.splice( i, 1 );
				emitter.removeEventListener( EmitterEvent.EMITTER_UPDATED, emitterUpdated );
				emitter.removeEventListener( ParticleEvent.PARTICLE_CREATED, particleAdded );
				emitter.removeEventListener( ParticleEvent.PARTICLE_ADDED, particleAdded );
				emitter.removeEventListener( ParticleEvent.PARTICLE_DEAD, particleRemoved );
				emitter.removeEventListener( ParticleEvent.PARTICLE_REMOVED, particleRemoved );
				for( p in emitter.particlesArray.iterator() )
				{
					removeParticle( p );
				}
				if( _emitters.length == 0 )
				{
					removeEventListener( Event.RENDER, updateParticles );
					renderParticles( [] );
				}
				else if( stage != null )
				{
					#if (flash||cpp)
					stage.invalidate();
					#end
				}
				return;
			}
		}
	}
	
	private function addedToStage( ev:Event ):Void
	{
		if( stage != null )
		{
			#if (flash||cpp)
			stage.invalidate();
			#end
		}
	}
	
	private function particleAdded( ev:ParticleEvent ):Void
	{
		addParticle( ev.particle );
		if( stage != null )
		{
			#if (flash||cpp)
			stage.invalidate();
			#end
		}
	}
	
	private function particleRemoved( ev:ParticleEvent ):Void
	{
		removeParticle( ev.particle );
		if( stage != null )
		{
			#if (flash||cpp)
			stage.invalidate();
			#end
		}
	}

	private function emitterUpdated( ev:EmitterEvent ):Void
	{
		if( stage != null )
		{
			#if (flash||cpp)
			stage.invalidate();
			#end
		}
	}
	
	private function updateParticles( ev:Event ) : Void
	{
		renderParticles( _particles );
	}
	
	/**
	 * The addParticle method is called when a particle is added to one of
	 * the emitters that is being rendered by this renderer.
	 * 
	 * @param particle The particle.
	 */
	private function addParticle( particle:Particle ):Void
	{
		_particles.push( particle );
	}
	
	/**
	 * The removeParticle method is called when a particle is removed from one
	 * of the emitters that is being rendered by this renderer.
	 * @param particle The particle.
	 */
	private function removeParticle( particle:Particle ):Void
	{
		var index:Int = Lambda.indexOf(_particles,particle);
		if( index != -1 )
		{
			_particles.splice( index, 1 );
		}
	}
	
	/**
	 * The renderParticles method is called during the render phase of 
	 * every frame if the state of one of the emitters being rendered
	 * by this renderer has changed.
	 * 
	 * @param particles The particles being managed by all the emitters
	 * being rendered by this renderer. The particles are in no particular
	 * order.
	 */
	private function renderParticles( particles:Array<Dynamic> ):Void
	{
	}

	/**
	 * The array of all emitters being rendered by this renderer.
	 */
	private function get_emitters():Vector<Emitter>
	{
		return _emitters;
	}
	private function set_emitters( value:Vector<Emitter> ):Vector<Emitter>
	{
		var e:Emitter;
		for( e in _emitters )
		{
			removeEmitter( e );
		}
		for( e in value )
		{
			addEmitter( e );
		}
		return _emitters;
	}
}
