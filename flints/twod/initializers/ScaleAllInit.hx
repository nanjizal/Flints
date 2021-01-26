package flints.twod.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;

/**
 * The ScaleAllInit Initializer sets the size of the particles image
 * and adjusts its mass and collision radius accordingly.
 * 
 * <p>If you want to adjust only the image size use
 * the ScaleImageInit initializer.</p>
 * 
 * <p>This initializer has a priority of -10 to ensure it occurs after 
 * mass and radius assignment classes like CollisionRadiusInit and MassInit.</p>
 * 
 * @see flints.common.initializers.ScaleImageInit
 */

class ScaleAllInit extends InitializerBase
{
	public var maxScale(get, set):Float;
	public var minScale(get, set):Float;
	public var scale(get, set):Float;
	
	private var _min:Float;
	private var _max:Float;
	
	/**
	 * The constructor creates a ScaleAllInit initializer for use by 
	 * an emitter. To add a ScaleAllInit to all particles created by an emitter, use the
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
	public function new( minScale:Float = 1, maxScale:Float = 1 )
	{
		super();
		priority = -10;
		this.minScale = minScale;
		this.maxScale = Math.isNaN( maxScale ) ? minScale : maxScale;
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
		var scale:Float;
		if( _max == _min )
		{
			scale = _min;
		}
		else
		{
			scale = _min + Math.random() * ( _max - _min );
		}
		particle.scale = scale;
		particle.mass *= scale * scale;
		particle.collisionRadius *= scale;
	}
}
