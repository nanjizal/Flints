package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.initializers.Initializer;
import flints.common.emitters.Emitter;
import flints.common.utils.WeightedArray;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.ChooseInitializer;

/**
 * The ChooseInitializer initializer selects one of multiple initializers, using 
 * optional weighting values to produce an uneven distribution for the choice, 
 * and applies it to the particle. This is often used with the InitializerGroup 
 * initializer to apply a randomly chosen group of initializers to the particle.
 * 
 * @see flints.common.initializers.InitializerGroup
 */

class ChooseInitializer extends InitializerBase
{
	private var _initializers:WeightedArray;
	private var _mxmlInitializers:Array<Dynamic>;
	private var _mxmlWeights:Array<Dynamic>;
	
	/**
	 * The constructor creates a ChooseInitializer initializer for use by 
	 * an emitter. To add a ChooseInitializer to 
	 * an emitter, use the emitter's addInitializer method.
	 * 
	 * @param colors An array containing the Initializers to use.
	 * @param weights The weighting to apply to each initializer. If no weighting
	 * values are passed, the initializers are all assigned a weighting of 1.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( initializers:Array<Dynamic> = null, weights:Array<Dynamic> = null )
	{
		super();
		_initializers = new WeightedArray();
		if( initializers == null )
		{
			return;
		}
		init( initializers, weights );
	}
	
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		if( _mxmlInitializers != null )
		{
			init( _mxmlInitializers, _mxmlWeights );
			_mxmlInitializers = null;
			_mxmlWeights = null;
		}
	}
	
	private function init( initializers:Array<Dynamic> = null, weights:Array<Dynamic> = null ):Void
	{
		_initializers.clear();
		var len:Int = initializers.length;
		var i:Int;
		if( weights != null && weights.length == len )
		{
			for (i in 0...len) 
			{
				_initializers.add( initializers[i], weights[i] );
			}
		}
		else
		{
			for (i in 0...len) 
			{
				_initializers.add( initializers[i], 1 );
			}
		}
	}
	
	public function addInitializer( initializer:Initializer, weight:Float = 1 ):Void
	{
		_initializers.add( initializer, weight );
	}
	
	public function removeInitializer( initializer:Initializer ):Void
	{
		_initializers.remove( initializer );
	}
	
	public function initializersSetter( value:Array<Dynamic> ):Void
	{
		_mxmlInitializers = value;
		checkStartValues();
	}
	
	public function weightsSetter( value:Array<Dynamic> ):Void
	{
		if( value.length == 1 && Std.is(value[0], String) )
		{
			_mxmlWeights = cast( value[0],String ).split( "," );
		}
		else
		{
			_mxmlWeights = value;
		}
		checkStartValues();
	}
	
	private function checkStartValues():Void
	{
		if( _mxmlInitializers != null && _mxmlWeights != null )
		{
			init( _mxmlInitializers, _mxmlWeights );
			_mxmlInitializers = null;
			_mxmlWeights = null;
		}
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		var initializer:Initializer = _initializers.getRandomValue();
		initializer.initialize( emitter, particle );
	}
}
