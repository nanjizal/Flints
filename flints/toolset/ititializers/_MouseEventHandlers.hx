package flints.initializers;

import openfl.events.IEventDispatcher;
import openfl.events.MouseEvent;
import flints.common.particles.Particle;
import flints.common.events.ParticleEvent;
import flints.common.emitters.Emitter;
import flints.common.initializers.MouseEventHandlers;
import flints.common.initializers.InitializerBase;

/**
 * The MouseEventHandlers Initializer sets event handlers to listen for the mouseOver and mouseOut events on each 
 * particle. To use this initializer, you must use a DisplayObjectRenderer, use an InteractiveObject as the image
 * for each particle, and set the mouseChildren property of the renderer to true.
 */

class MouseEventHandlers extends InitializerBase
{
	public var downHandler(get, set):Dynamic;
	public var overHandler(get, set):Dynamic;
	public var upHandler(get, set):Dynamic;
	public var outHandler(get, set):Dynamic;
	public var clickHandler(get, set):Dynamic;
	
	private var _overHandler:Dynamic;
	private var _outHandler:Dynamic;
	private var _upHandler:Dynamic;
	private var _downHandler:Dynamic;
	private var _clickHandler:Dynamic;
	
	/**
	 * The constructor creates a MouseEventHandlers initializer for use by 
	 * an emitter. To add a MouseEventHandlers to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new()
	{
		super();
	}
	
	/**
	 * The mouseOver event handler.
	 */
	private function get_overHandler():Dynamic
	{
		return _overHandler;
	}
	private function set_overHandler( value:Dynamic ):Dynamic
	{
		_overHandler = value;
		return _overHandler;
	}
	
	/**
	 * The mouseOut event handler.
	 */
	private function get_outHandler():Dynamic
	{
		return _outHandler;
	}
	private function set_outHandler( value:Dynamic ):Dynamic
	{
		_outHandler = value;
		return _outHandler;
	}
	
	/**
	 * The mouseUp event handler.
	 */
	private function get_upHandler():Dynamic
	{
		return _upHandler;
	}
	private function set_upHandler( value:Dynamic ):Dynamic
	{
		_upHandler = value;
		return _upHandler;
	}
	
	/**
	 * The mouseDown event handler.
	 */
	private function get_downHandler():Dynamic
	{
		return _downHandler;
	}
	private function set_downHandler( value:Dynamic ):Dynamic
	{
		_downHandler = value;
		return _downHandler;
	}
	
	/**
	 * The mouseClick event handler.
	 */
	private function get_clickHandler():Dynamic
	{
		return _clickHandler;
	}
	private function set_clickHandler( value:Dynamic ):Dynamic
	{
		_clickHandler = value;
		return _clickHandler;
	}
	
	/**
	 * Listens for particles to die and removes the mouse event listeners from them when this occurs.
	 */
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		//emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, removeListeners, false, 0, true );
		emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, removeListeners );
	}
	
	/**
	 * Stops listening for particles to die.
	 */
	override public function removedFromEmitter( emitter:Emitter ):Void
	{
		emitter.removeEventListener( ParticleEvent.PARTICLE_DEAD, removeListeners );
	}

	private function removeListeners( event:ParticleEvent ):Void
	{
		if( Std.is(event.particle.image, IEventDispatcher) )
		{
			var dispatcher:IEventDispatcher = cast( event.particle.image,IEventDispatcher );
			if( _overHandler != null )
			{
				dispatcher.removeEventListener( MouseEvent.MOUSE_OVER, _overHandler );
			}
			if( _outHandler != null )
			{
				dispatcher.removeEventListener( MouseEvent.MOUSE_OVER, _outHandler );
			}
			if( _upHandler != null )
			{
				dispatcher.removeEventListener( MouseEvent.MOUSE_OVER, _upHandler );
			}
			if( _downHandler != null )
			{
				dispatcher.removeEventListener( MouseEvent.MOUSE_OVER, _downHandler );
			}
			if( _clickHandler != null )
			{
				dispatcher.removeEventListener( MouseEvent.MOUSE_OVER, _clickHandler );
			}
		}
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		if( Std.is(particle.image, IEventDispatcher) )
		{
			var dispatcher:IEventDispatcher = cast( particle.image,IEventDispatcher );
			if( _overHandler != null )
			{
				//dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _overHandler, false, 0, true );
				dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _overHandler );
			}
			if( _outHandler != null )
			{
				//dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _outHandler, false, 0, true );
				dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _outHandler );
			}
			if( _upHandler != null )
			{
				//dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _upHandler, false, 0, true );
				dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _upHandler );
			}
			if( _downHandler != null )
			{
				//dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _downHandler, false, 0, true );
				dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _downHandler );
			}
			if( _clickHandler != null )
			{
				//dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _clickHandler, false, 0, true );
				dispatcher.addEventListener( MouseEvent.MOUSE_OVER, _clickHandler );
			}
		}
	}
}
