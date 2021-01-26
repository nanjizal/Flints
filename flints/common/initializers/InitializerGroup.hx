package flints.common.initializers;

import jota.utils.ArrayUtils;
import openfl.Vector;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.Initializer;
import flints.common.initializers.InitializerGroup;
import flints.common.initializers.InitializerBase;

/**
 * The InitializerGroup initializer collects a number of initializers into a single 
 * larger initializer that applies all the grouped initializers to a particle. It is
 * commonly used with the ChooseInitializer initializer to choose from different
 * groups of initializers when initializing a particle.
 * 
 * @see flints.common.initializers.ChooseInitializer
 */

class InitializerGroup extends InitializerBase
{
	public var initializers(get, never):Vector<Initializer>;
	
	private var _initializers:Vector<Initializer>;
	private var _emitter:Emitter;
	
	/**
	 * The constructor creates an InitializerGroup.
	 * 
	 * @param initializers Initializers that should be added to the group.
	 */
	public function new( initializers:Array<Dynamic> )
	{
		super();
		_initializers = new Vector<Initializer>();
		for( i in initializers.iterator() )
		{
			addInitializer( i );
		}
	}
	
	public function get_initializers():Vector<Initializer>
	{
		return _initializers;
	}
	public function set_initializers( value:Vector<Initializer> ):Vector<Initializer>
	{
		var initializer:Initializer;
		if( _emitter != null )
		{
			for( initializer in _initializers )
			{
				initializer.removedFromEmitter( _emitter );
			}
		}
		/**
		 * TODO: get clone of vector?
		 */
		 //_initializers = value.slice( );
		_initializers = value.slice(0,value.length);
		_initializers.sort( prioritySort );
		if( _emitter != null )
		{
			for( initializer in _initializers )
			{
				initializer.addedToEmitter( _emitter );
			}
		}
		return _initializers;
	}

	public function addInitializer( initializer:Initializer ):Void
	{
		var len:Int = _initializers.length;
		var idx:Int = 0;
		for( i in 0 ... len )
		{
			idx = i;
			if( _initializers[i].priority < initializer.priority )
			{
				break;
			}
		}
		//_initializers.splice( i, 0, initializer );
		_initializers = ArrayUtils.insertIntoVector([idx, initializer, _initializers]);
		if( _emitter != null )
		{
			initializer.addedToEmitter( _emitter );
		}
	}
	
	public function removeInitializer( initializer:Initializer ):Void
	{
		//var index:Int = _initializers.indexOf( initializer );
		/**
		 * TODO: vector cannot indexOf so doing it "manualy"
		 */
		var index:Int = -1;
		for( i in 0 ... _initializers.length ) {
			if (_initializers[i] == initializer)
			{
				index = i;
				break;
			}
		}
		if( index != -1 )
		{
			_initializers.splice( index, 1 );
			if( _emitter != null )
			{
				initializer.removedFromEmitter( _emitter );
			}
		}
	}
	
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		_emitter = emitter;
    for (initializer in _initializers)
    {
      initializer.addedToEmitter (emitter);
    }
	}

	override public function removedFromEmitter( emitter:Emitter ):Void
	{
    for (initializer in _initializers)
    {
      initializer.removedFromEmitter (emitter);
    }
		_emitter = null;
	}

	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
    for (initializer in _initializers)
    {
      initializer.initialize (emitter, particle);
    }
	}
	
	private function prioritySort( b1:Initializer, b2:Initializer ):Int
	{
		return b1.priority - b2.priority;
	}
}
