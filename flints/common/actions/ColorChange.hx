package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.ColorChange;
import flints.common.actions.ActionBase;
import flints.common.utils.InterpolateColors;

/**
 * The ColorChange action alters the color of the particle as it ages.
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

class ColorChange extends ActionBase
{
	public var endColor(get, set):Int;
	public var startColor(get, set):Int;
	
	private var _startColor:Int;
	private var _endColor:Int;
	
	/**
	 * The constructor creates a ColorChange action for use by an emitter. 
	 * To add a ColorChange to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param startColor The 32bit (ARGB) color of the particle when its
	 * energy is 1 - usually at the beginning of its life.
	 * @param endColor The 32bit (ARGB) color of the particle when its 
	 * energy is 0 - usually at the end of its life.
	 */
	public function new( startColor:Int = 0xFFFFFF, endColor:Int = 0xFFFFFF )
	{
		super();
		_startColor = startColor;
		_endColor = endColor;
	}
	
	/**
	 * The color of the particle when its energy is 1.
	 */
	private function get_startColor():Int
	{
		return _startColor;
	}
	private function set_startColor( value:Int ):Int
	{
		_startColor = value;
		return value;
	}
	
	/**
	 * The color of the particle when its energy is zero.
	 */
	private function get_endColor():Int
	{
		return _endColor;
	}
	private function set_endColor( value:Int ):Int
	{
		_endColor = value;
		return value;
	}

	/**
	 * Sets the color of the particle based on the colors and the particle's 
	 * energy level.
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
		particle.color = InterpolateColors.interpolate( _startColor, _endColor, particle.energy );
	}
}
