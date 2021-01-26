package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.particles.Particle2D;

/**
 * The GravityWell action applies a force on the particle to draw it towards
 * a single point. The force applied is inversely proportional to the square
 * of the distance from the particle to the point, in accordance with Newton's
 * law of gravity.
 * 
 * <p>This simulates the effect of gravity over large distances (as between
 * planets, for example). To simulate the effect of gravity at the surface
 * of the eacrth, use an Acceleration action with the direction of force 
 * downwards.</p>
 * 
 * @see Acceleration
 */

class GravityWell extends ActionBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var power(get, set):Float;
	public var epsilon(get, set):Float;
	
	private var _x:Float;
	private var _y:Float;
	private var _power:Float;
	private var _epsilonSq:Float;
	private var _gravityConst:Float; // just scales the power to a more reasonable number
	
	/**
	 * The constructor creates a GravityWell action for use by an emitter.
	 * To add a GravityWell to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param power The strength of the gravity force - larger numbers produce a 
	 * stronger force.
	 * @param x The x coordinate of the point towards which the force draws 
	 * the particles.
	 * @param y The y coordinate of the point towards which the force draws 
	 * the particles.
	 * @param epsilon The minimum distance for which gravity is calculated. 
	 * Particles closer than this distance experience a gravity force as if 
	 * they were this distance away. This stops the gravity effect blowing 
	 * up as distances get small. For realistic gravity effects you will want 
	 * a small epsilon ( ~1 ), but for stable visual effects a larger
	 * epsilon (~100) is often better.
	 */
	public function new( power:Float = 0, x:Float = 0, y:Float = 0, epsilon:Float = 100 )
	{
		super();
		_gravityConst = 10000;
		this.power = power;
		this.x = x;
		this.y = y;
		this.epsilon = epsilon;
	}
	
	/**
	 * The strength of the gravity force - larger numbers produce a 
	 * stronger force.
	 */
	private function get_power():Float
	{
		return _power / _gravityConst;
	}
	private function set_power( value:Float ):Float
	{
		_power = value * _gravityConst;
		return _power;
	}
	
	/**
	 * The x coordinate of the point towards which the force draws 
	 * the particles.
	 */
	private function get_x():Float
	{
		return _x;
	}
	private function set_x( value:Float ):Float
	{
		_x = value;
		return _x;
	}
	
	/**
	 * The y coordinate of the point towards which the force draws 
	 * the particles.
	 */
	private function get_y():Float
	{
		return _y;
	}
	private function set_y( value:Float ):Float
	{
		_y = value;
		return _y;
	}
	
	/**
	 * The minimum distance for which the gravity force is calculated. 
	 * Particles closer than this distance experience the gravity as if
	 * they were this distance away. This stops the gravity effect blowing 
	 * up as distances get small.  For realistic gravity effects you will want 
	 * a small epsilon ( ~1 ), but for stable visual effects a larger
	 * epsilon (~100) is often better.
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
	 * Calculates the gravity force on the particle and applies it for
	 * the period of time indicated.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user.</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		if( particle.mass == 0 )
		{
			return;
		}
		var p:Particle2D = cast( particle,Particle2D );
		var x:Float = _x - p.x;
		var y:Float = _y - p.y;
		var dSq:Float = x * x + y * y;
		if( dSq == 0 )
		{
			return;
		}
		var d:Float = Math.sqrt( dSq );
		if( dSq < _epsilonSq ) dSq = _epsilonSq;
		var factor:Float = ( _power * time ) / ( dSq * d );
		p.velX += x * factor;
		p.velY += y * factor;
	}
}
