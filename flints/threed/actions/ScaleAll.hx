package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;

/**
 * The ScaleAll action adjusts the size of the particles image, its collision radius
 * and its mass as it ages. It uses the particle's energy level to decide what size 
 * the particle should be.
 * 
 * <p>Usually a particle's energy changes from 1 to 0 over its lifetime, but
 * this can be altered via the easing function set within the age action.</p>
 * 
 * <p>This action should be used in conjunction with the Age action.</p>
 * 
 * <p>If you only want to adjust the image size of the particle, use
 * the ScaleImage action.</p>
 * 
 * @see flints.common.actions.ScaleImage
 * @see flints.common.actions.Action
 * @see flints.common.actions.Age
 */
class ScaleAll extends ActionBase
{
	public var startScale(get, set):Float;
	public var endScale(get, set):Float;
	
	private var _diffScale:Float;
	private var _endScale:Float;
	
	/**
	 * The constructor creates a ScaleImage action for use by an emitter. 
	 * To add a ScaleImage to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param startScale The scale factor for the particle when its energy
	 * is 1 - usually at the start of its lifetime. A scale of 1 is normal size.
	 * @param endScale The scale factor for the particle when its energy
	 * is 0 - usually at the end of its lifetime. A scale of 1 is normal size.
	 */
	public function new( startScale:Float = 1, endScale:Float = 1 )
	{
		super();
		_diffScale = 0;
		_endScale = 1;
		this.endScale = endScale;
		this.startScale = startScale;
	}
	
	/**
	 * The scale factor for the particle when its energy
	 * is 1 - usually at the start of its lifetime. A scale of 1 is normal size.
	 */
	private function get_startScale():Float
	{
		return _endScale + _diffScale;
	}
	private function set_startScale( value:Float ):Float
	{
		_diffScale = value - _endScale;
		return _diffScale;
	}
	
	/**
	 * The scale factor for the particle when its energy
	 * is 0 - usually at the end of its lifetime. A scale of 1 is normal size.
	 */
	private function get_endScale():Float
	{
		return _endScale;
	}
	private function set_endScale( value:Float ):Float
	{
		_diffScale = _endScale + _diffScale - value;
		_endScale = value;
		return _endScale;
	}
	
	/**
	 * Sets the scale of the particle based on the values defined
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
		var scale:Float = _endScale + _diffScale * particle.energy;
		var change:Float = scale / particle.scale;

		particle.scale = scale;
		particle.mass *= change * change * change;
		particle.collisionRadius *= change;
	}
}
