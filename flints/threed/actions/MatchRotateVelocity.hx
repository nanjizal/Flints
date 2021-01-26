package flints.threed.actions;

import openfl.geom.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.emitters.Emitter3D;
import flints.threed.particles.Particle3D;

/**
 * The MatchRotateVelocity action applies an angular acceleration to the particle to match
 * its angular velocity to that of its nearest neighbours.
 * 
 * <p>This action has a priority of 10, so that it executes 
 * before other actions.</p>
 */
class MatchRotateVelocity extends ActionBase
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
	private var vel:Vector3D;

	/**
	 * The constructor creates a MatchRotateVelocity action for use by 
	 * an emitter. To add a MatchRotateVelocity to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param maxDistance The maximum distance, in pixels, over which this action operates.
	 * The particle will match its angular velocity other particles that are this close or 
	 * closer to it.
	 * @param acceleration The angular acceleration applied to adjust velocity to match that
	 * of the other particles.
	 */
	public function new( maxDistance:Float = 0, acceleration:Float = 0 )
	{
		super();
		priority = 10;
		d = new Vector3D();
		vel = new Vector3D();
		this.maxDistance = maxDistance;
		this.acceleration = acceleration;
	}
	
	/**
	 * The maximum distance, in pixels, over which this action operates.
	 * The particle will match its angular velocity other particles that are this 
	 * close or closer to it.
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
	 * The angular acceleration applied to adjust velocity to match that
	 * of the other particles.
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
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var e:Emitter3D = cast( emitter, Emitter3D );
		var particles:Array<Dynamic> = e.particlesArray;
		var other:Particle3D;
		var i:Int;
		var len:Int = particles.length;
		var distanceSq:Float;
		
		vel.x = 0;
		vel.y = 0;
		vel.z = 0;
		
		var count:Int = 0;
		var factor:Float;
		//for( i = p.sortID - 1; i >= 0; --i )
		var i = p.sortID - 1;
		while( i >= 0 )
		{
			other = particles[i];
			if( ( d.x = other.position.x - p.position.x ) < -_max )
      {
        break;
      }
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
				vel.incrementBy( other.angVelocity );
				++count;
			}
			--i;
		}
		//for( i = p.sortID + 1; i < len; ++i )
		i = p.sortID + 1;
		while( i < len )
		{
			other = particles[i];
			if( ( d.x = other.position.x - p.position.x ) > _max )
      {
        break;
      }
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
				vel.incrementBy( other.angVelocity );
				++count;
			}
			++i;
		}
		if( count != 0 )
		{
			vel.scaleBy( 1 / count );
			vel.decrementBy( p.angVelocity );
			if ( vel.x != 0 || vel.y != 0 || vel.z != 0 )
			{
				factor = time * _acc / vel.length;
				if( factor > 1 ) factor = 1;
				vel.scaleBy( factor );
				p.angVelocity.incrementBy( vel );
			}
		}
	}
}
