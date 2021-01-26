package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;

/**
 * The TweenPosition action adjusts the particle's position between two
 * locations as it ages. This action
 * should be used in conjunction with the Age action.
 */

class TweenPosition extends ActionBase
{
	public var end(get, set):Vector3D;
	public var start(get, set):Vector3D;
	
	private var _start:Vector3D;
	private var _end:Vector3D;
	private var _diff:Vector3D;
	
	/**
	 * The constructor creates a TweenPosition action for use by 
	 * an emitter. To add a TweenPosition to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param startX The x value for the particle at the
	 * start of its life.
	 * @param startY The y value for the particle at the
	 * start of its life.
	 * @param endX The x value of the particle at the end of its
	 * life.
	 * @param endY The y value of the particle at the end of its
	 * life.
	 */
	public function new( start:Vector3D = null, end:Vector3D = null )
	{
		super();
		this.start = start != null ? start : new Vector3D();
		this.end = end != null ? end : new Vector3D();
	}
	
	/**
	 * The x position for the particle at the start of its life.
	 */
	private function get_start():Vector3D
	{
		return _start;
	}
	private function set_start( value:Vector3D ):Vector3D
	{
		_start = Vector3DUtils.clonePoint( value );
		if( _end != null )
		{
			_diff = _start.subtract( _end );
		}
		return _start;
	}
	
	/**
	 * The X value for the particle at the end of its life.
	 */
	private function get_end():Vector3D
	{
		return _end;
	}
	private function set_end( value:Vector3D ):Vector3D
	{
		_end = Vector3DUtils.clonePoint( value );
		if( _start != null )
		{
			_diff = _start.subtract( _end );
		}
		return _end;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Vector3D = cast( particle, Particle3D ).position;
		var r:Float = particle.energy;
		p.x = _diff.x * r + _end.x;
		p.y = _diff.y * r + _end.y;
		p.z = _diff.z * r + _end.z;
	}
}
