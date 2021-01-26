package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.Fade;
import flints.common.actions.ActionBase;

/**
 * The Fade action adjusts the particle's alpha as it ages.
 * It uses the particle's energy level to decide what colour to display.
 * 
 * <p>Usually a particle's energy changes from 1 to 0 over its lifetime, but
 * this can be altered via the easing function set within the age action.</p>
 * 
 * <p>This action should be used in conjunction with the Age action.</p>
 * 
 * @see flints.common.actions.Action
 * @see flints.common.actions.Age
 */

class Fade extends ActionBase
{
	public var endAlpha(get, set):Float;
	public var startAlpha(get, set):Float;
	
	private var _diffAlpha:Float;
	private var _endAlpha:Float;
	
	/**
	 * The constructor creates a Fade action for use by 
	 * an emitter. To add a Fade to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * <p>This action has a priority of -5, so that the Fade executes after 
	 * color changes.</p>
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param startAlpha The alpha value for the particle when its energy
	 * is 1 - usually at the start of its lifetime. The value should be 
	 * between 0 and 1.
	 * @param endAlpha The alpha value of the particle when its energy
	 * is 0 - usually at the end of its lifetime. The value should be 
	 * between 0 and 1.
	 */
	public function new( startAlpha:Float = 1, endAlpha:Float = 0 )
	{
		super();
		priority = -5;
		_diffAlpha = startAlpha - endAlpha;
		_endAlpha = endAlpha;
	}
	
	/**
	 * The alpha value for the particle when its energy is 1.
	 * The value should be between 0 and 1.
	 */
	private function get_startAlpha():Float
	{
		return _endAlpha + _diffAlpha;
	}
	private function set_startAlpha( value:Float ):Float
	{
		_diffAlpha = value - _endAlpha;
		return _diffAlpha;
	}
	
	/**
	 * The alpha value for the particle when its energy is 0.
	 * The value should be between 0 and 1.
	 */
	private function get_endAlpha():Float
	{
		return _endAlpha;
	}
	private function set_endAlpha( value:Float ):Float
	{
		_diffAlpha = _endAlpha + _diffAlpha - value;
		_endAlpha = value;
		return _endAlpha;
	}
	
	/**
	 * Sets the transparency of the particle based on the values defined
	 * and the particle's energy level.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var alpha:Float = _endAlpha + _diffAlpha * particle.energy;
		particle.color = ( particle.color & 0xFFFFFF ) | ( Math.round( alpha * 255 ) << 24 );
	}
}
