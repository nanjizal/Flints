package flints.twod.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.twod.particles.Particle2D;

/**
 * The RotationAbsolute Initializer sets the rotation of the particle. The rotation is
 * independent of the rotation of the emitter.
 */

class RotationAbsolute extends InitializerBase
{
	public var angle(get, set):Float;
	public var maxAngle(get, set):Float;
	public var minAngle(get, set):Float;
	
	private var _min : Float;
	private var _max : Float;

	/**
	 * The constructor creates a RotationAbsolute initializer for use by 
	 * an emitter. To add a RotationAbsolute to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * <p>The rotation of particles initialized by this class
	 * will be a random value between the minimum and maximum
	 * values set. If no maximum value is set, the minimum value
	 * is used with no variation.</p>
	 * 
	 * @param minAngle The minimum angle, in radians, for the particle's rotation.
	 * @param maxAngle The maximum angle, in radians, for the particle's rotation.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( minAngle : Float = 0, maxAngle : Float = 0 )
	{
		super();
		this.minAngle = minAngle;
		this.maxAngle = maxAngle;
	}
	
	/**
	 * The minimum angle for particles initialised by 
	 * this initializer.
	 */
	private function get_minAngle():Float
	{
		return _min;
	}
	private function set_minAngle( value:Float ):Float
	{
		_min = value;
		return _min;
	}
	
	/**
	 * The maximum angle for particles initialised by 
	 * this initializer.
	 */
	private function get_maxAngle():Float
	{
		return _max;
	}
	private function set_maxAngle( value:Float ):Float
	{
		_max = value;
		return _max;
	}
	
	/**
	 * When reading, returns the average of minAngle and maxAngle.
	 * When writing this sets both maxAngle and minAngle to the 
	 * same angle value.
	 */
	private function get_angle():Float
	{
		return _min == _max ? _min : ( _max + _min ) / 2;
	}
	private function set_angle( value:Float ):Float
	{
		_max = _min = value;
		return value;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter : Emitter, particle : Particle ) : Void
	{
		var p:Particle2D = cast( particle,Particle2D );
		if( Math.isNaN( _max ) )
		{
			p.rotation = _min;
		}
		else
		{
			p.rotation = _min + Math.random() * ( _max - _min );
		}
	}
}
