package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.ScaleImageInit;
import flints.common.initializers.InitializerBase;

/**
 * The ScaleImageInit Initializer adjusts the size of the particles image.
 * 
 * <p>If you also want to adjust the mass and collision radius of the particle, use
 * the ScaleAllInit initializer.</p>
 * 
 * @see flints.twoD.initializers.ScaleAllInit
 * @see flints.threeD.initializers.ScaleAllInit
 */

class ScaleImageInit extends InitializerBase
{
	public var maxScale(get, set):Float;
	public var minScale(get, set):Float;
	public var scale(get, set):Float;
	
	private var _min:Float;
	private var _max:Float;
	
	/**
	 * The constructor creates a ScaleImageInit initializer for use by 
	 * an emitter. To add a ScaleImageInit to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * <p>The scale factor of particles initialized by this class
	 * will be a random value between the minimum and maximum
	 * values set. If no maximum value is set, the minimum value
	 * is used with no variation.</p>
	 * 
	 * @param minScale the minimum scale factor for particles
	 * initialized by the instance.
	 * @param maxScale the maximum scale factor for particles
	 * initialized by the instance.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( minScale:Float = 1, maxScale:Float = -1 )
	{
		super();
		_min = minScale;
		if( maxScale < 0 )
		{
			_max = _min;
		}
		else
		{
			_max = maxScale;
		}
	}
	
	/**
	 * The minimum scale value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_minScale():Float
	{
		return _min;
	}
	private function set_minScale( value:Float ):Float
	{
		_min = value;
		return _min;
	}
	
	/**
	 * The maximum scale value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_maxScale():Float
	{
		return _max;
	}
	private function set_maxScale( value:Float ):Float
	{
		_max = value;
		return _max;
	}
	
	/**
	 * When reading, returns the average of minScale and maxScale.
	 * When writing this sets both maxScale and minScale to the 
	 * same scale value.
	 */
	private function get_scale():Float
	{
		return _min == _max ? _min : ( _max + _min ) / 2;
	}
	private function set_scale( value:Float ):Float
	{
		_max = _min = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		if( _max == _min )
		{
			particle.scale = _min;
		}
		else
		{
			particle.scale = _min + Math.random() * ( _max - _min );
		}
	}
}
