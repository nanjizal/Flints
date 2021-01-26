package flints.threed.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.common.events.ParticleEvent;
import flints.threed.particles.Particle3D;

/**
 * The BoundingBox action confines each particle to a box. The 
 * box is aligned to the coordinate system axes. The 
 * particle bounces back off the side of the box when it reaches 
 * the edge. The bounce treats the particle as a circular body
 * and displays no loss of energy in the collision.
 * 
 * This action has a priority of -20, so that it executes after 
 * all movement has occured.
 */

class BoundingBox extends ActionBase
{
	public var minY(get, set):Float;
	public var minX(get, set):Float;
	public var bounce(get, set):Float;
	public var maxX(get, set):Float;
	public var maxY(get, set):Float;
	public var maxZ(get, set):Float;
	public var minZ(get, set):Float;
	
	private var _minX : Float;
	private var _maxX : Float;
	private var _minY : Float;
	private var _maxY : Float;
	private var _minZ : Float;
	private var _maxZ : Float;
	private var _bounce : Float;

	/**
	 * The constructor creates a BoundingBox action for use by an emitter. 
	 * To add a BoundingBox to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param minX The minX coordinate of the box.
	 * @param maxX The maxX coordinate of the box.
	 * @param minY The minY coordinate of the box.
	 * @param maxY The maxY coordinate of the box.
	 * @param minZ The minZ coordinate of the box.
	 * @param maxZ The maxZ coordinate of the box.
	 * @param bounce The coefficient of restitution when the particles bounce off the
	 * sides of the box. A value of 1 gives a pure elastic collision, with no energy loss. 
	 * A value between 0 and 1 causes the particle to loose enegy in the collision. A value 
	 * greater than 1 causes the particle to gain energy in the collision.
	 */
	public function new( minX:Float = 0, maxX:Float = 0, minY:Float = 0, maxY:Float = 0, minZ:Float = 0, maxZ:Float = 0, bounce:Float = 1 )
	{
		super();
		priority = -20;
		this.minX = minX;
		this.maxX = maxX;
		this.minY = minY;
		this.maxY = maxY;
		this.minZ = minZ;
		this.maxZ = maxZ;
		this.bounce = bounce;
	}
	
	/**
	 * The minX coordinate of the box.
	 */
	private function get_minX():Float
	{
		return _minX;
	}
	private function set_minX( value:Float ):Float
	{
		_minX = value;
		return _minX;
	}

	/**
	 * The maxX coordinate of the box.
	 */
	private function get_maxX():Float
	{
		return _maxX;
	}
	private function set_maxX( value:Float ):Float
	{
		_maxX = value;
		return _maxX;
	}

	/**
	 * The minY coordinate of the box.
	 */
	private function get_minY():Float
	{
		return _minY;
	}
	private function set_minY( value:Float ):Float
	{
		_minY = value;
		return _minY;
	}

	/**
	 * The maxY coordinate of the box.
	 */
	private function get_maxY():Float
	{
		return _maxY;
	}
	private function set_maxY( value:Float ):Float
	{
		_maxY = value;
		return _maxY;
	}

	/**
	 * The minZ coordinate of the box.
	 */
	private function get_minZ():Float
	{
		return _minZ;
	}
	private function set_minZ( value:Float ):Float
	{
		_minZ = value;
		return _minZ;
	}

	/**
	 * The maxZ coordinate of the box.
	 */
	private function get_maxZ():Float
	{
		return _maxZ;
	}
	private function set_maxZ( value:Float ):Float
	{
		_maxZ = value;
		return _maxZ;
	}

	/**
	 * The coefficient of restitution when the particles bounce off the
	 * sides of the box. A value of 1 gives a pure pure elastic collision, with no energy loss. 
	 * A value between 0 and 1 causes the particle to loose enegy in the collision. A value 
	 * greater than 1 causes the particle to gain energy in the collision.
	 */
	private function get_bounce():Float
	{
		return _bounce;
	}
	private function set_bounce( value:Float ):Float
	{
		_bounce = value;
		return _bounce;
	}

	/**
	 * Tests whether the particle is at the edge of the box and, if so,
	 * adjusts its velocity to bounce in back towards the center of the
	 * box.
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
	override public function update( emitter : Emitter, particle : Particle, time : Float ) : Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var radius:Float = p.collisionRadius;
		var position:Float;
		if ( p.velocity.x > 0 && ( position = p.position.x + radius ) >= _maxX )
		{
			p.velocity.x = -p.velocity.x * _bounce;
			p.position.x += 2 * ( _maxX - position );
			if ( emitter.hasEventListener( ParticleEvent.BOUNDING_BOX_COLLISION ) )
			{
				emitter.dispatchEvent( new ParticleEvent( ParticleEvent.BOUNDING_BOX_COLLISION, p ) );
			}
		}
		else if ( p.velocity.x < 0 && ( position = p.position.x - radius ) <= _minX )
		{
			p.velocity.x = -p.velocity.x * _bounce;
			p.position.x += 2 * ( _minX - position );
			if ( emitter.hasEventListener( ParticleEvent.BOUNDING_BOX_COLLISION ) )
			{
				emitter.dispatchEvent( new ParticleEvent( ParticleEvent.BOUNDING_BOX_COLLISION, p ) );
			}
		}
		if ( p.velocity.y > 0 && ( position = p.position.y + radius ) >= _maxY )
		{
			p.velocity.y = -p.velocity.y * _bounce;
			p.position.y += 2 * ( _maxY - position );
			if ( emitter.hasEventListener( ParticleEvent.BOUNDING_BOX_COLLISION ) )
			{
				emitter.dispatchEvent( new ParticleEvent( ParticleEvent.BOUNDING_BOX_COLLISION, p ) );
			}
		}
		else if ( p.velocity.y < 0 && ( position = p.position.y - radius ) <= _minY )
		{
			p.velocity.y = -p.velocity.y * _bounce;
			p.position.y += 2 * ( _minY - position );
			if ( emitter.hasEventListener( ParticleEvent.BOUNDING_BOX_COLLISION ) )
			{
				emitter.dispatchEvent( new ParticleEvent( ParticleEvent.BOUNDING_BOX_COLLISION, p ) );
			}
		}
		if ( p.velocity.z > 0 && ( position = p.position.z + radius ) >= _maxZ )
		{
			p.velocity.z = -p.velocity.z * _bounce;
			p.position.z += 2 * ( _maxZ - position );
			if ( emitter.hasEventListener( ParticleEvent.BOUNDING_BOX_COLLISION ) )
			{
				emitter.dispatchEvent( new ParticleEvent( ParticleEvent.BOUNDING_BOX_COLLISION, p ) );
			}
		}
		else if ( p.velocity.z < 0 && ( position = p.position.z - radius ) <= _minZ )
		{
			p.velocity.z = -p.velocity.z * _bounce;
			p.position.z += 2 * ( _minZ - position );
			if ( emitter.hasEventListener( ParticleEvent.BOUNDING_BOX_COLLISION ) )
			{
				emitter.dispatchEvent( new ParticleEvent( ParticleEvent.BOUNDING_BOX_COLLISION, p ) );
			}
		}
	}
}
