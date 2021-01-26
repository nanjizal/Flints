package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.ColorInit;
import flints.common.utils.InterpolateColors;

/**
 * The ColorInit Initializer sets the color of the particle.
 */

class ColorInit extends InitializerBase
{
	public var minColor(get, set):Int;
	public var maxColor(get, set):Int;
	public var color(get, set):Int;
	
	private var _min:Int;
	private var _max:Int;
	
	/**
	 * The constructor creates a ColorInit initializer for use by 
	 * an emitter. To add a ColorInit to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * <p>The color of particles initialized by this class
	 * will be a random value between the two values pased to
	 * the constructor. For a fixed value, pass the same color
	 * in for both parameters.</p>
	 * 
	 * @param color1 the 32bit (ARGB) color at one end of the color range to use.
	 * @param color2 the 32bit (ARGB) color at the other end of the color range to use.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( color1:Int= 0xFFFFFF, color2:Int = 0xFFFFFF )
	{
		super();
		_min = color1;
		_max = color2;
	}
	
	/**
	 * The minimum color value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_minColor():Int
	{
		return _min;
	}
	private function set_minColor( value:Int ):Int
	{
		_min = value;
		return _min;
	}
	
	/**
	 * The maximum color value for particles initialised by 
	 * this initializer. Should be between 0 and 1.
	 */
	private function get_maxColor():Int
	{
		return _max;
	}
	private function set_maxColor( value:Int ):Int
	{
		_max = value;
		return _max;
	}
	
	/**
	 * When reading, returns the average of minColor and maxColor.
	 * When writing this sets both maxColor and minColor to the 
	 * same color.
	 */
	private function get_color():Int
	{
		return _min == _max ? _min : InterpolateColors.interpolate( _max, _min, 0.5 );
	}
	private function set_color( value:Int ):Int
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
			particle.color = _min;
		}
		else
		{
			particle.color = InterpolateColors.interpolate( _min, _max, Math.random() );
		}
	}
}
