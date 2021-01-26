package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.utils.WeightedArray;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.ColorsInit;

/**
 * The ColorsInit initializer sets the color of the particle. It selects 
 * one of multiple colors, using optional weighting values to produce an uneven
 * distribution for the colors.
 */

class ColorsInit extends InitializerBase
{
	private var _colors:WeightedArray;
	private var _mxmlColors:Array<Dynamic>;
	private var _mxmlWeights:Array<Dynamic>;
	
	/**
	 * The constructor creates a ColorsInit initializer for use by 
	 * an emitter. To add a ColorsInit to all particles created by 
	 * an emitter, use the emitter's addInitializer method.
	 * 
	 * @param colors An array containing the Colors to use for 
	 * each particle created by the emitter, as 32bit ARGB values.
	 * @param weights The weighting to apply to each color. If no weighting
	 * values are passed, the colors are all assigned a weighting of 1.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( colors:Array<Dynamic> = null, weights:Array<Dynamic> = null )
	{
		super();
		_colors = new WeightedArray();
		if( colors == null )
		{
			return;
		}
		init( colors, weights );
	}
	
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		if( _mxmlColors != null )
		{
			init( _mxmlColors, _mxmlWeights );
			_mxmlColors = null;
			_mxmlWeights = null;
		}
	}
	
	private function init( colors:Array<Dynamic> = null, weights:Array<Dynamic> = null ):Void
	{
		_colors.clear();
		var len:Int = colors.length;
		var i:Int;
		if( weights != null && weights.length == len )
		{
			for (i in 0...len) 
			{
				_colors.add( colors[i], weights[i] );
			}
		}
		else
		{
			for (i in 0...len) 
			{
				_colors.add( colors[i], 1 );
			}
		}
	}
	
	public function addColor( color:Int, weight:Float = 1 ):Void
	{
		_colors.add( color, weight );
	}
	
	public function removeColor( color:Int ):Void
	{
		_colors.remove( color );
	}
	
	public function colorsSetter( value:Array<Dynamic> ):Void
	{
		if( value.length == 1 && Std.is(value[0], String) )
		{
			_mxmlColors = cast( value[0],String ).split( "," );
		}
		else
		{
			_mxmlColors = value;
		}
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
		if( _mxmlColors != null && _mxmlWeights != null )
		{
			init( _mxmlColors, _mxmlWeights );
			_mxmlColors = null;
			_mxmlWeights = null;
		}
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		particle.color = _colors.getRandomValue();
	}
}
