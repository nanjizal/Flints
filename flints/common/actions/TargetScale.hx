package flints.common.actions;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.actions.TargetScale;
import flints.common.actions.ActionBase;

/**
 * The TargetScale action adjusts the scale of the particle towards a 
 * target scale. On every update the scale of the particle moves a 
 * little closer to the target scale. The rate at which particles approach
 * the target is controlled by the rate property.
 */
class TargetScale extends ActionBase
{
	public var targetScale(get, set):Float;
	public var rate(get, set):Float;
	
	private var _scale:Float;
	private var _rate:Float;
	
	/**
	 * The constructor creates a TargetScale action for use by an emitter. 
	 * To add a TargetScale to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param targetScale The target scale for the particle. 1 is normal size.
	 * @param rate Adjusts how quickly the particle reaches the target scale.
	 * Larger numbers cause it to approach the target scale more quickly.
	 */
	public function new( targetScale:Float= 1, rate:Float = 0.1 )
	{
		super();
		_scale = targetScale;
		_rate = rate;
	}
	
	/**
	 * The target scale for the particle. 1 is normal size.
	 */
	private function get_targetScale():Float
	{
		return _scale;
	}
	private function set_targetScale( value:Float ):Float
	{
		_scale = value;
		return _scale;
	}
	
	/**
	 * Adjusts how quickly the particle reaches the target scale.
	 * Larger numbers cause it to approach the target scale more quickly.
	 */
	private function get_rate():Float
	{
		return _rate;
	}
	private function set_rate( value:Float ):Float
	{
		_rate = value;
		return _rate;
	}
	
	/**
	 * Adjusts the scale of the particle based on its current scale, the target 
	 * scale and the time elapsed.
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
		particle.scale += ( _scale - particle.scale ) * _rate * time;
	}
}
