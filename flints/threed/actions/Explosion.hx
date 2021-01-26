package flints.threed.actions;

import flints.threed.Vector3D;
import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.activities.FrameUpdatable;
import flints.common.activities.UpdateOnFrame;
import flints.common.behaviours.Resetable;
import flints.common.emitters.Emitter;
import flints.threed.geom.Vector3DUtils;
import flints.threed.particles.Particle3D;


/**
 * The Explosion action applies a force on the particle to push it away from
 * a single point - the center of the explosion. The force occurs instantaneously at the central point 
 * of the explosion and then ripples out in a shock wave.
 */

class Explosion extends ActionBase implements Resetable implements FrameUpdatable
{
	public var x(get, set):Float;
	public var depth(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var power(get, set):Float;
	public var epsilon(get, set):Float;
	public var expansionRate(get, set):Float;
	public var center(get, set):Vector3D;
	
	private static inline var POWER_FACTOR:Float = 100000;
	
	private var _updateActivity:UpdateOnFrame;
	private var _center:Vector3D;
	private var _power:Float;
	private var _depth:Float;
	private var _invDepth:Float;
	private var _epsilonSq:Float;
	private var _oldRadius:Float;
	private var _radius:Float;
	private var _radiusChange:Float;
	private var _expansionRate:Float;
	
	/**
	 * The constructor creates an Explosion action for use by 
	 * an emitter. To add an Explosion to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param power The strength of the explosion - larger numbers produce a stronger 
	 * force.  (The scale of value has been altered from previous versions
	 * so small numbers now produce a visible effect.)
	 * @param center The center of the explosion.
	 * @param expansionRate The rate at which the shockwave moves out from the explosion, in pixels per second.
	 * @param depth The depth (front-edge to back-edge) of the shock wave.
	 * @param epsilon The minimum distance for which the explosion force is calculated. 
	 * Particles closer than this distance experience the explosion as it they were 
	 * this distance away. This stops the explosion effect blowing up as distances get 
	 * small.
	 */
	public function new( power:Float = 0, center:Vector3D = null, expansionRate:Float = 300, depth:Float = 10, epsilon:Float = 1 )
	{
		super();
		_oldRadius = 0;
		_radius = 0;
		_radiusChange = 0;
		_expansionRate = 500;
		this.power = power;
		this.center = center != null ? center : new Vector3D();
		this.expansionRate = expansionRate;
		this.depth = depth;
		this.epsilon = epsilon;
	}
	
	/**
	 * The strength of the explosion - larger numbers produce a stronger force.
	 */
	private function get_power():Float
	{
		return _power / POWER_FACTOR;
	}
	private function set_power( value:Float ):Float
	{
		_power = value * POWER_FACTOR;
		return _power;
	}
	
	/**
	 * The strength of the explosion - larger numbers produce a stronger force.
	 */
	private function get_expansionRate():Float
	{
		return _expansionRate;
	}
	private function set_expansionRate( value:Float ):Float
	{
		_expansionRate = value;
		return _expansionRate;
	}
	
	/**
	 * The strength of the explosion - larger numbers produce a stronger force.
	 */
	private function get_depth():Float
	{
		return _depth * 2;
	}
	private function set_depth( value:Float ):Float
	{
		_depth = value * 0.5;
		_invDepth = 1 / _depth;
		return _depth;
	}
	
	/**
	 * The center of the explosion.
	 */
	private function get_center():Vector3D
	{
		return _center;
	}
	private function set_center( value:Vector3D ):Vector3D
	{
		_center = Vector3DUtils.clonePoint( value );
		return _center;
	}
	
	/**
	 * The x coordinate of the center of the explosion.
	 */
	private function get_x():Float
	{
		return _center.x;
	}
	private function set_x( value:Float ):Float
	{
		_center.x = value;
		return value;
	}
	
	/**
	 * The y coordinate of  the center of the explosion.
	 */
	private function get_y():Float
	{
		return _center.y;
	}
	private function set_y( value:Float ):Float
	{
		_center.y = value;
		return value;
	}
	
	/**
	 * The z coordinate of the center of the explosion.
	 */
	private function get_z():Float
	{
		return _center.z;
	}
	private function set_z( value:Float ):Float
	{
		_center.z = value;
		return value;
	}

	/**
	 * The minimum distance for which the explosion force is calculated. 
	 * Particles closer than this distance experience the explosion as it they were 
	 * this distance away. This stops the explosion effect blowing up as distances get 
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
	 * Adds an UpdateOnFrame activity to the emitter to call this objects
	 * frameUpdate method once per frame.
	 * 
	 * @param emitter The emitter this action has been added to.
	 * 
	 * @see frameUpdate()
	 * @see flints.common.activities.UpdateOnFrame
	 * @see flints.common.actions.Action#addedToEmitter()
	 */
	override public function addedToEmitter( emitter:Emitter ):Void
	{
		_updateActivity = new UpdateOnFrame( this );
		emitter.addActivity( _updateActivity );
	}
	
	/**
	 * Removes the UpdateOnFrame activity that was added to the emitter in the
	 * addedToEmitter method.
	 * 
	 * @param emitter The emitter this action has been added to.
	 * 
	 * @see addedToEmitter()
	 * @see flints..common.activities.UpdateOnFrame
	 * @see flints.common.actions.Action#removedFromEmitter()
	 */
	override public function removedFromEmitter( emitter:Emitter ):Void
	{
		if( _updateActivity != null )
		{
			emitter.removeActivity( _updateActivity );
		}
	}
	
	/**
	 * Resets the explosion to its initial state, so it can start again.
	 */
	public function reset():Void
	{
		_radius = 0;
		_oldRadius = 0;
		_radiusChange = 0;
	}
	
	/**
	 * Called every frame before the particles are updated. This method is called via the FrameUpdateable
	 * interface which is called by the emitter by using an UpdateOnFrame activity.
	 */
	public function frameUpdate( emitter:Emitter, time:Float ):Void
	{
		_oldRadius = _radius;
		_radiusChange = _expansionRate * time;
		_radius += _radiusChange;
	}
	
	/**
	 * Calculates the effect of the blast and shockwave on the particle at this
	 * time.
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
		var p:Particle3D = cast( particle, Particle3D );
		var dist:Vector3D = p.position.subtract( _center );
		var dSq:Float = dist.lengthSquared;
		if( dSq == 0 )
		{
			return;
		}
		var d:Float = Math.sqrt( dSq );
		
		if( d < _oldRadius - _depth )
		{
			return;
		}
		if( d > _radius + _depth )
		{
			return;
		}
		
		var offset:Float = d < _radius ? _depth - _radius + d : _depth - d + _radius;
		var oldOffset:Float = d < _oldRadius ? _depth - _oldRadius + d : _depth - d + _oldRadius;
		offset *= _invDepth;
		oldOffset *= _invDepth;
		if( offset < 0 )
		{
			time = time * ( _radiusChange + offset ) / _radiusChange;
			offset = 0;
		}
		if( oldOffset < 0 )
		{
			time = time * ( _radiusChange + oldOffset ) / _radiusChange;
			oldOffset = 0;
		}
		
		var factor:Float;
		if( d < _oldRadius || d > _radius )
		{
			factor = time * _power * ( offset + oldOffset ) / ( _radius * 2 * d * p.mass );
		}
		else
		{
			var ratio:Float = ( 1 - oldOffset ) / _radiusChange;
			var f1:Float = ratio * time * _power * ( oldOffset + 1 );
			var f2:Float = ( 1 - ratio ) * time * _power * ( offset + 1 );
			factor = ( f1 + f2 ) / ( _radius * 2 * d * p.mass );
		}
		dist.scaleBy( factor );
		p.velocity.incrementBy( dist );
	}
}
