package flints.threed.actions;

import flints.threed.Vector3D
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.emitters.Emitter3D;
import flints.threed.particles.Particle3D;


/**
 * The ApproachNeighbours action applies an acceleration to the particle to 
 * draw it towards other nearby particles. The size of the acceleration 
 * is constant, only the direction varies.
 * 
 * <p>This action has a priority of 10, so that it executes 
 * before other actions.</p>
 */

class ApproachNeighbours extends ActionBase
{
	public var acceleration(get, set):Float;
	public var maxDistance(get, set):Float;
	
	private var _max:Float;
	private var _acc:Float;
	private var _maxSq:Float;
	
	/*
	 * Temporary variables created as class members to avoid creating new objects all the time
	 */
	private var d:Vector3D;
	private var move:Vector3D;
	
	/**
	 * The constructor creates a ApproachNeighbours action for use by an emitter. 
	 * To add a ApproachNeighbours to all particles created by an emitter, 
	 * use the emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param maxDistance The maximum distance, in pixels, over which this action 
	 * operates. Particles further away than this distance are ignored.
	 * @param acceleration The acceleration force applied to approach the other 
	 * particles.
	 */
	public function new( maxDistance:Float = 0, acceleration:Float = 0 )
	{
		super();
		priority = 10;
		d = new Vector3D();
		move = new Vector3D();
		this.maxDistance = maxDistance;
		this.acceleration = acceleration;
	}
	
	/**
	 * The maximum distance, in pixels, over which this action operates. Particles
	 * further away than this distance are ignored.
	 */
	private function get_maxDistance():Float
	{
		return _max;
	}
	private function set_maxDistance( value:Float ):Float
	{
		_max = value;
		_maxSq = value * value;
		return _max;
	}
	
	/**
	 * The acceleration force applied to approach the other particles.
	 */
	private function get_acceleration():Float
	{
		return _acc;
	}
	private function set_acceleration( value:Float ):Float
	{
		_acc = value;
		return _acc;
	}

	/**
	 * @inheritDoc
	 */
	override public function addedToEmitter( emitter:Emitter ) : Void
	{
		cast( emitter, Emitter3D ).spaceSort = true;
	}
	
	/**
	 * Causes the particle to check all nearby particles and move towards their 
	 * average position.
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
		var p:Particle3D = cast( particle, Particle3D );
		var e:Emitter3D = cast( emitter, Emitter3D );
		var particles:Array<Dynamic> = e.particlesArray;
		var other:Particle3D;
		var i:Int;
		var len:Int = particles.length;
		var distanceInv:Float;
		var distanceSq:Float;
		var factor:Float;
		
		move.x = 0;
		move.y = 0;
		move.z = 0;
		
		//for( i = p.sortID - 1; i >= 0; --i )
		var i = p.sortID - 1;
		while( i >= 0 )
		{
			other = particles[i];
			if( ( d.x = other.position.x - p.position.x ) < -_max ) break;
			d.y = other.position.y - p.position.y;
			if( d.y > _max || d.y < -_max )
      {
        --i;
        continue;
      }
			d.z = other.position.z - p.position.z;
			if( d.z > _max || d.z < -_max )
      {
        --i;
        continue;
      }
			distanceSq = d.lengthSquared;
			if( distanceSq <= _maxSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				d.scaleBy( distanceInv );
				move.incrementBy( d );
			}
			--i;
		}
		//for( i = p.sortID + 1; i < len; ++i )
		i = p.sortID + 1;
		while( i < len )
		{
			other = cast( particles[i], Particle3D );
			if( ( d.x = other.position.x - p.position.x ) > _max ) break;
			d.y = other.position.y - p.position.y;
			if( d.y > _max || d.y < -_max )
      {
        ++i;
        continue;
      }
			d.z = other.position.z - p.position.z;
			if( d.z > _max || d.z < -_max )
      {
        ++i;
        continue;
      }
			distanceSq = d.lengthSquared;
			if( distanceSq <= _maxSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				d.scaleBy( distanceInv );
				move.incrementBy( d );
			}
			++i;
		}
		if ( move.x != 0 || move.y != 0 || move.z != 0 )
		{
			factor = time * _acc / move.length;
			move.scaleBy( factor );
			p.velocity.incrementBy( move );
		}
	}
}
