package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.particles.Particle3D;

/**
 * The RandomDrift action moves the particle by a random small amount every frame,
 * causing the particle to drift around.
 */

class RandomDrift extends ActionBase
{
	public var driftZ(get, set):Float;
	public var driftY(get, set):Float;
	public var driftX(get, set):Float;
	
	private var _driftX:Float;
	private var _driftY:Float;
	private var _driftZ:Float;
	
	/**
	 * The constructor creates a RandomDrift action for use by 
	 * an emitter. To add a RandomDrift to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param driftX The maximum amount of horizontal drift in pixels per second.
	 * @param driftY The maximum amount of vertical drift in pixels per second.
	 */
	public function new( driftX:Float = 0, driftY:Float = 0, driftZ:Float = 0 )
	{
		super();
		this.driftX = driftX;
		this.driftY = driftY;
		this.driftZ = driftZ;
	}
	
	/**
	 * The maximum amount of horizontal drift in pixels per second.
	 */
	private function get_driftX():Float
	{
		return _driftX / 2;
	}
	private function set_driftX( value:Float ):Float
	{
		_driftX = value * 2;
		return _driftX;
	}
	
	/**
	 * The maximum amount of vertical drift in pixels per second.
	 */
	private function get_driftY():Float
	{
		return _driftY / 2;
	}
	private function set_driftY( value:Float ):Float
	{
		_driftY = value * 2;
		return _driftY;
	}
	
	/**
	 * The maximum amount of vertical drift in pixels per second.
	 */
	private function get_driftZ():Float
	{
		return _driftZ / 2;
	}
	private function set_driftZ( value:Float ):Float
	{
		_driftZ = value * 2;
		return _driftZ;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		p.velocity.x += ( Math.random() - 0.5 ) * _driftX * time;
		p.velocity.y += ( Math.random() - 0.5 ) * _driftY * time;
		p.velocity.z += ( Math.random() - 0.5 ) * _driftZ * time;
	}
}
