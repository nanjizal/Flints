package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.emitters.Emitter2D;
import flints.twod.particles.Particle2D;

/**
 * The ApproachNeighbours action applies an acceleration to the particle to 
 * draw it towards other nearby particles. The size of the acceleration 
 * is constant, only the direction varies. This differentiates this action
 * from the MutualGravity action, where the acceleration is proportional
 * to the distance between the particles.
 * 
 * <p>ApproachNeighbours is most commonly used when creating flocking
 * behaviours. Flocking is usually a combination of ApproachNeighbours
 * to draw particles together, MinimumDistance to stop them getting too close
 * and MatchVelocity to make them match speed and direction of motion.</p>
 * 
 * <p>This action has a priority of 10, so that it executes 
 * before other actions.</p>
 * 
* 	 * @see flints.twod.actions.MinimumDistance
 * @see flints.twod.actions.MatchVelocity
 */

class ApproachNeighbours extends ActionBase
{
	public var acceleration(get, set):Float;
	public var maxDistance(get, set):Float;
	
	private var _max:Float;
	private var _acc:Float;
	private var _maxSq:Float;
	
	/**
	 * The constructor creates an ApproachNeighbours action for use by an emitter. 
	 * To add an ApproachNeighbours to all particles created by an emitter, 
	 * use the emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param maxDistance The maximum distance, in pixels, over which this action 
	 * operates. Particles further apart than this distance ignore each other.
	 * @param acceleration The size of the acceleration applied to approach the 
	 * other particles.
	 */
	public function new( maxDistance:Float = 0, acceleration:Float = 0 )
	{
		super();
		priority = 10;
		this.maxDistance = maxDistance;
		this.acceleration = acceleration;
	}
	
	/**
	 * The maximum distance, in pixels, over which this action operates.
	 * Particles further apart than this distance ignore each other.
	 */
	public function get_maxDistance():Float
	{
		return _max;
	}
	public function set_maxDistance( value:Float ):Float
	{
		_max = value;
		_maxSq = value * value;
		return _max;
	}
	
	/**
	 * The acceleration applied to approach the other particles.
	 */
	public function get_acceleration():Float
	{
		return _acc;
	}
	public function set_acceleration( value:Float ):Float
	{
		_acc = value;
		return _acc;
	}

	/**
	 * Instructs the emitter to produce a sorted particle array for optimizing
	 * the calculations in the update method of this action.
	 * 
	 * @param emitter The emitter this action has been added to.
	 * 
	 * @see flints.common.actions.Action#addedToEmitter()
	 */
	override public function addedToEmitter( emitter:Emitter ) : Void
	{
		cast( emitter,Emitter2D ).spaceSort = true;
	}
	
	/**
	 * Checks all particles near the current particle and applies the 
	 * acceleration to move the particle towards their average position.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user.</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle2D = cast( particle,Particle2D );
		var e:Emitter2D = cast( emitter,Emitter2D );
		var particles:Array<Dynamic> = e.particlesArray;
		var other:Particle2D;
		var i:Int;
		var len:Int = particles.length;
		var distanceInv:Float;
		var distanceSq:Float;
		var dx:Float;
		var dy:Float;
		var moveX:Float = 0;
		var moveY:Float = 0;
		var factor:Float;
		//for( i = p.sortID - 1; i >= 0; --i )
		i = p.sortID - 1;
		while( i >= 0 )
		{
			other = particles[i];
			if( ( dx = other.x - p.x ) < - _max )
      {
        break;
      }
			dy = other.y - p.y;
			if( dy > _max || dy < -_max )
      {
        --i;
        continue;
      }
			distanceSq = dy * dy + dx * dx;
			if( distanceSq <= _maxSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				moveX += dx * distanceInv;
				moveY += dy * distanceInv;
			}
			--i;
		}
		//for( i = p.sortID + 1; i < len; ++i )
		i = p.sortID + 1;
		while( i < len )
		{
			other = particles[i];
			if( ( dx = other.x - p.x ) > _max )
      {
        break;
      }
			dy = other.y - p.y;
			if( dy > _max || dy < -_max )
      {
        ++i;
        continue;
      }
			distanceSq = dy * dy + dx * dx;
			if( distanceSq <= _maxSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				moveX += dx * distanceInv;
				moveY += dy * distanceInv;
			}
			++i;
		}
		if( moveX != 0 || moveY != 0 )
		{
			factor = time * _acc / Math.sqrt( moveX * moveX + moveY * moveY );
			p.velX += factor * moveX;
			p.velY += factor * moveY;
		}
	}
}
