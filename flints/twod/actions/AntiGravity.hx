package flints.twod.actions;

/**
 * The AntiGravity action applies a force to the particle to push it away from
 * a single point - the center of the effect. The force applied is inversely 
 * proportional to the square of the distance from the particle to the point.
 * 
 * <p>This is the same as the GravityWell action with a negative force.</p>
 * 
 * @see flints.twod.actions.GravityWell
 */

class AntiGravity extends GravityWell
{
	/**
	 * The constructor creates an AntiGravity action for use by an emitter. 
	 * To add an AntiGravity to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param power The strength of the force - larger numbers produce a 
	 * stronger force.
	 * @param x The x coordinate of the point away from which the force pushes 
	 * the particles.
	 * @param y The y coordinate of the point away from which the force pushes 
	 * the particles.
	 * @param epsilon The minimum distance for which the anti-gravity force is 
	 * calculated. Particles closer than this distance experience the 
	 * anti-gravity as if they were this distance away. This stops the 
	 * anti-gravity effect blowing up as distances get small.
	 */
	public function new( power:Float = 0, x:Float = 0, y:Float = 0, epsilon:Float = 1 )
	{
		super( power, x, y, epsilon );
	}
	
	/**
	 * The strength of the anti-gravity force - larger numbers produce a 
	 * stronger force.
	 */
	override private function get_power():Float
	{
		//return -super.power;
		return -_power;
	}
	override private function set_power( value:Float ):Float
	{
		//super.power = -value;
		//return -value;
		_power = -value;
		return -value;
	}
}
