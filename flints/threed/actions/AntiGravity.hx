package flints.threed.actions;

import flints.threed.Vector3D;

/**
 * The AntiGravity action applies a force to the particle to push it away from
 * a single point - the center of the effect. The force applied is inversely 
 * proportional to the square of the distance from the particle to the point.
 */

class AntiGravity extends GravityWell
{
	override public var power(get, set):Float;
	
	/**
	 * The constructor creates an AntiGravity action for use by an emitter. 
	 * To add an AntiGravity to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param power The strength of the force - larger numbers produce a 
	 * stronger force.
	 * @param position The point in 3D space that the force pushes the 
	 * particles away from.
	 * @param epsilon The minimum distance for which the anti-gravity force is 
	 * calculated. Particles closer than this distance experience the 
	 * anti-gravity as it they were this distance away. This stops the 
	 * anti-gravity effect blowing up as distances get very small.
	 */
	public function new( power:Float = 0, position:Vector3D = null, epsilon:Float = 1 )
	{
		super( power, position, epsilon );
	}
	
	/**
	 * The strength of the anti-gravity force - larger numbers produce a 
	 * stronger force.
	 */
	override private function get_power():Float
	{
		//return -super.power;
		return -power;
	}
	override private function set_power( value:Float ):Float
	{
		//super.power = -value;
		//return value;
		_power = -value;
		return -value;
	}
}
