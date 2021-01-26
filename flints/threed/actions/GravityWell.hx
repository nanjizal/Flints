package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The GravityWell action applies a force on the particle to draw it towards
 * a single point. The force applied is inversely proportional to the square
 * of the distance from the particle to the point.
 */

class GravityWell extends ActionBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var power(get, set):Float;
	public var epsilon(get, set):Float;
	public var position(get, set):Vector3D;
	
	private var _position:Vector3D;
	private var _power:Float;
	private var _epsilonSq:Float;
	private var _gravityConst:Float; // just scales the power to a more reasonable number
	
	/**
	 * The constructor creates a GravityWell action for use by 
	 * an emitter. To add a GravityWell to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param power The strength of the force - larger numbers produce a stringer force.
	 * @param position The point towards which the force draws the particles.
	 * @param epsilon The minimum distance for which gravity is calculated. Particles closer
	 * than this distance experience a gravity force as it they were this distance away.
	 * This stops the gravity effect blowing up as distances get small. For realistic gravity 
	 * effects you will want a small epsilon ( ~1 ), but for stable visual effects a larger
	 * epsilon (~100) is often better.
	 */
	public function new( power:Float = 0, position:Vector3D = null, epsilon:Float = 100 )
	{
		super();
		this.power = power;
		this.position = position != null ? position : new Vector3D();
		this.epsilon = epsilon;
		_gravityConst = 10000;
	}
	
	/**
	 * The strength of the gravity force.
	 */
	private function get_power():Float
	{
		return _power / _gravityConst;
	}
	private function set_power( value:Float ):Float
	{
		_power = value * _gravityConst;
		return value;
	}
	
	/**
	 * The x coordinate of the center of the gravity force.
	 */
	private function get_position():Vector3D
	{
		return _position;
	}
	private function set_position( value:Vector3D ):Vector3D
	{
		_position = Vector3DUtils.clonePoint( value );
		return value;
	}
	
	/**
	 * The x coordinate of the point that the force pulls the particles towards.
	 */
	private function get_x():Float
	{
		return _position.x;
	}
	private function set_x( value:Float ):Float
	{
		_position.x = value;
		return value;
	}
	
	/**
	 * The y coordinate of the point that the force pulls the particles towards.
	 */
	private function get_y():Float
	{
		return _position.y;
	}
	private function set_y( value:Float ):Float
	{
		_position.y = value;
		return value;
	}
	
	/**
	 * The z coordinate of the point that the force pulls the particles towards.
	 */
	private function get_z():Float
	{
		return _position.z;
	}
	private function set_z( value:Float ):Float
	{
		_position.z = value;
		return value;
	}
	
	/**
	 * The minimum distance for which the gravity force is calculated. 
	 * Particles closer than this distance experience the gravity as it they were 
	 * this distance away. This stops the gravity effect blowing up as distances get 
	 * small.
	 */
	private function get_epsilon():Float
	{
		return Math.sqrt( _epsilonSq );
	}
	private function set_epsilon( value:Float ):Float
	{
		_epsilonSq = value * value;
		return _epsilonSq;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		if( particle.mass == 0 )
		{
			return;
		}
		var p:Particle3D = cast( particle, Particle3D );
		var offset:Vector3D = _position.subtract( p.position );
		var dSq:Float = offset.lengthSquared;
		if( dSq == 0 )
		{
			return;
		}
		var d:Float = Math.sqrt( dSq );
		if( dSq < _epsilonSq ) dSq = _epsilonSq;
		var factor:Float = ( _power * time ) / ( dSq * d );
		offset.scaleBy( factor );
		p.velocity.incrementBy( offset );
	}
}
