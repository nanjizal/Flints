package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.particles.Particle2D;

/**
 * The Accelerate Action adjusts the velocity of each particle by a 
 * constant acceleration. This can be used, for example, to simulate
 * gravity.
 */
class Accelerate extends ActionBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private var _x:Float;
	private var _y:Float;
	
	/**
	 * The constructor creates an Acceleration action for use by an emitter. 
	 * To add an Accelerator to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param accelerationX The x coordinate of the acceleration to apply, in
	 * pixels per second per second.
	 * @param accelerationY The y coordinate of the acceleration to apply, in 
	 * pixels per second per second.
	 */
	public function new( accelerationX:Float = 0, accelerationY:Float = 0 )
	{
		super();
		this.x = accelerationX;
		this.y = accelerationY;
	}
	
	/**
	 * The x coordinate of the acceleration, in
	 * pixels per second per second.
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
	 * The y coordinate of the acceleration, in
	 * pixels per second per second.
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
	 * Applies the acceleration to a particle for the specified time period.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle2D = cast( particle,Particle2D );
		p.velX += _x * time;
		p.velY += _y * time;
	}
}
