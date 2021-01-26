package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.threed.emitters.Emitter3D;
import flints.threed.particles.Particle3D;

/**
 * The MutualGravity Action applies forces to attract each particle towards 
 * the other particles.
 * 
 * <p>This action has a priority of 10, so that it executes 
 * before other actions.</p>
 */
class MutualGravity extends ActionBase
{
	public var power(get, set):Float;
	public var epsilon(get, set):Float;
	public var maxDistance(get, set):Float;
	
	private var _power:Float;
	private var _maxDistance:Float;
	private var _maxDistanceSq:Float;
	private var _epsilonSq:Float;
	private var _gravityConst:Float; // scale sthe power
	
	/*
	 * Temporary variables created as class members to avoid creating new objects all the time
	 */
	private var d:Vector3D;
	
	/**
	 * The constructor creates a MutualGravity action for use by 
	 * an emitter. To add a MutualGravity to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param power The strength of the gravitational pull between the particles.
	 * @param maxDistance The maximum distance between particles for the gravitational
	 * effect to be calculated. You can speed up this action by reducing the maxDistance
	 * since often only the closest other particles have a significant effect on the 
	 * motion of a particle.
	 */
	public function new( power:Float = 0, maxDistance:Float = 0, epsilon:Float = 1 )
	{
		super();
		_gravityConst = 1000;
		priority = 10;
		d = new Vector3D();
		this.power = power;
		this.maxDistance = maxDistance;
		this.epsilon = epsilon;
	}
	
	/**
	 * The strength of the gravity force.
	 */
	private function get_power():Float
	{
		return _power / _gravityConst;
	}
	private function set_power( value:Float ):Float
	{
		_power = value * _gravityConst;
		return _power;
	}
	
	/**
	 * The maximum distance between particles for the gravitational
	 * effect to be calculated. You can speed up this action by reducing the maxDistance
	 * since often only the closest other particles have a significant effect on the 
	 * motion of a particle.
	 */
	private function get_maxDistance():Float
	{
		return _maxDistance;
	}
	private function set_maxDistance( value:Float ):Float
	{
		_maxDistance = value;
		_maxDistanceSq = value * value;
		return _maxDistance;
	}
	
	/**
	 * The minimum distance for which the gravity force is calculated. 
	 * Particles closer than this distance experience the gravity as it they were 
	 * this distance away. This stops the gravity effect blowing up as distances get 
	 * small.
	 */
	private function get_epsilon():Float
	{
		return Math.sqrt( _epsilonSq );
	}
	private function set_epsilon( value:Float ):Float
	{
		_epsilonSq = value * value;
		return _epsilonSq;
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
	override public function update( emitter : Emitter, particle : Particle, time : Float ) : Void
	{
		if( particle.mass == 0 )
		{
			return;
		}
		var p:Particle3D = cast( particle, Particle3D );
		var e:Emitter3D = cast( emitter, Emitter3D );
		var particles:Array<Dynamic> = e.particlesArray;
		var other:Particle3D;
		var i:Int;
		var len:Int = particles.length;
		var factor:Float;
		var distance:Float;
		var distanceSq:Float;
		
		//for( i = p.sortID + 1; i < len; ++i )
		var i = p.sortID + 1;
		while( i < len )
		{
			other = particles[i];
			if( other.mass == 0 )
			{
        ++i;
				continue;
			}
			if( ( d.x = other.position.x - p.position.x ) > _maxDistance )
      {
        break;
      }
			d.y = other.position.y - p.position.y;
			if( d.y > _maxDistance || d.y < -_maxDistance )
      {
        ++i;
        continue;
      }
			d.z = other.position.z - p.position.z;
			if( d.z > _maxDistance || d.z < -_maxDistance )
      {
        ++i;
        continue;
      }
			distanceSq = d.lengthSquared;
			if( distanceSq <= _maxDistanceSq && distanceSq > 0 )
			{
				distance = Math.sqrt( distanceSq );
				if( distanceSq < _epsilonSq )
				{
					distanceSq = _epsilonSq;
				}
				factor = ( _power * time ) / ( distanceSq * distance );
				d.scaleBy( factor * other.mass );
				p.velocity.incrementBy( d );
				d.scaleBy( p.mass / other.mass );
				other.velocity.decrementBy( d );
			}
			++i;
		}
	}
}
