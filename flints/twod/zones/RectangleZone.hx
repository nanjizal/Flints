package flints.twod.zones;

import openfl.geom.Point;
import flints.twod.particles.Particle2D;

/**
 * The RectangleZone zone defines a rectangular shaped zone.
 */

class RectangleZone implements Zone2D
{
	public var top(get, set):Float;
	public var right(get, set):Float;
	public var left(get, set):Float;
	public var bottom(get, set):Float;
	
	private var _left : Float;
	private var _top : Float;
	private var _right : Float;
	private var _bottom : Float;
	private var _width : Float;
	private var _height : Float;
	
	/**
	 * The constructor creates a RectangleZone zone.
	 * 
	 * @param left The left coordinate of the rectangle defining the region of the zone.
	 * @param top The top coordinate of the rectangle defining the region of the zone.
	 * @param right The right coordinate of the rectangle defining the region of the zone.
	 * @param bottom The bottom coordinate of the rectangle defining the region of the zone.
	 */
	public function new( left:Float = 0, top:Float = 0, right:Float = 0, bottom:Float = 0 )
	{
		_left = left;
		_top = top;
		_right = right;
		_bottom = bottom;
		_width = right - left;
		_height = bottom - top;
	}
	
	/**
	 * The left coordinate of the rectangle defining the region of the zone.
	 */
	private function get_left() : Float
	{
		return _left;
	}
	private function set_left( value : Float ) : Float
	{
		_left = value;
		if( !Math.isNaN( _right ) && !Math.isNaN( _left ) )
		{
			_width = right - left;
		}
		return _left;
	}

	/**
	 * The right coordinate of the rectangle defining the region of the zone.
	 */
	private function get_right() : Float
	{
		return _right;
	}
	private function set_right( value : Float ) : Float
	{
		_right = value;
		if( !Math.isNaN( _right ) && !Math.isNaN( _left ) )
		{
			_width = right - left;
		}
		return _right;
	}

	/**
	 * The top coordinate of the rectangle defining the region of the zone.
	 */
	private function get_top() : Float
	{
		return _top;
	}
	private function set_top( value : Float ) : Float
	{
		_top = value;
		if( !Math.isNaN( _top ) && !Math.isNaN( _bottom ) )
		{
			_height = bottom - top;
		}
		return _top;
	}

	/**
	 * The bottom coordinate of the rectangle defining the region of the zone.
	 */
	private function get_bottom() : Float
	{
		return _bottom;
	}
	private function set_bottom( value : Float ) : Float
	{
		_bottom = value;
		if( !Math.isNaN( _top ) && !Math.isNaN( _bottom ) )
		{
			_height = bottom - top;
		}
		return _bottom;
	}

	/**
	 * The contains method determines whether a point is inside the zone.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @param x The x coordinate of the location to test for.
	 * @param y The y coordinate of the location to test for.
	 * @return true if point is inside the zone, false if it is outside.
	 */
	public function contains( x:Float, y:Float ):Bool
	{
		return x >= _left && x <= _right && y >= _top && y <= _bottom;
	}
	
	/**
	 * The getLocation method returns a random point inside the zone.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @return a random point inside the zone.
	 */
	public function getLocation():Point
	{
		return new Point( _left + Math.random() * _width, _top + Math.random() * _height );
	}
	
	/**
	 * The getArea method returns the size of the zone.
	 * This method is used by the MultiZone class. Usually, 
	 * it need not be called directly by the user.
	 * 
	 * @return a random point inside the zone.
	 */
	public function getArea():Float
	{
		return _width * _height;
	}

	/**
	 * Manages collisions between a particle and the zone. Particles will collide with the edges 
	 * of the rectangle defined for this zone, from inside or outside the zone. The collisionRadius
	 * of the particle is used when calculating the collision.
	 * 
	 * @param particle The particle to be tested for collision with the zone.
	 * @param bounce The coefficient of restitution for the collision.
	 * 
	 * @return Whether a collision occured.
	 */
	public function collideParticle(particle:Particle2D, bounce:Float = 1):Bool
	{
		var position:Float;
		var previousPosition:Float;
		var intersect:Float;
		var collision:Bool = false;
		
		if ( particle.velX > 0 )
		{
			position = particle.x + particle.collisionRadius;
			previousPosition = particle.previousX + particle.collisionRadius;
			if( previousPosition < _left && position >= _left )
			{
				intersect = particle.previousY + ( particle.y - particle.previousY ) * ( _left - previousPosition ) / ( position - previousPosition );
				if( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius )
				{
					particle.velX = -particle.velX * bounce;
					particle.x += 2 * ( _left - position );
					collision = true;
				}
			}
			else if( previousPosition <= _right && position > _right )
			{
				intersect = particle.previousY + ( particle.y - particle.previousY ) * ( _right - previousPosition ) / ( position - previousPosition );
				if( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius )
				{
					particle.velX = -particle.velX * bounce;
					particle.x += 2 * ( _right - position );
					collision = true;
				}
			}
		}
		else if ( particle.velX < 0 )
		{
			position = particle.x - particle.collisionRadius;
			previousPosition = particle.previousX - particle.collisionRadius;
			if( previousPosition > _right && position <= _right )
			{
				intersect = particle.previousY + ( particle.y - particle.previousY ) * ( _right - previousPosition ) / ( position - previousPosition );
				if( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius )
				{
					particle.velX = -particle.velX * bounce;
					particle.x += 2 * ( _right - position );
					collision = true;
				}
			}
			else if( previousPosition >= _left && position < _left )
			{
				intersect = particle.previousY + ( particle.y - particle.previousY ) * ( _left - previousPosition ) / ( position - previousPosition );
				if( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius )
				{
					particle.velX = -particle.velX * bounce;
					particle.x += 2 * ( _left - position );
					collision = true;
				}
			}
		}

		if ( particle.velY > 0 )
		{
			position = particle.y + particle.collisionRadius;
			previousPosition = particle.previousY + particle.collisionRadius;
			if( previousPosition < _top && position >= _top )
			{
				intersect = particle.previousX + ( particle.x - particle.previousX ) * ( _top - previousPosition ) / ( position - previousPosition );
				if( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius )
				{
					particle.velY = -particle.velY * bounce;
					particle.y += 2 * ( _top - position );
					collision = true;
				}
			}
			else if( previousPosition <= _bottom && position > _bottom )
			{
				intersect = particle.previousX + ( particle.x - particle.previousX ) * ( _bottom - previousPosition ) / ( position - previousPosition );
				if( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius )
				{
					particle.velY = -particle.velY * bounce;
					particle.y += 2 * ( _bottom - position );
					collision = true;
				}
			}
		}
		else if ( particle.velY < 0 )
		{
			position = particle.y - particle.collisionRadius;
			previousPosition = particle.previousY - particle.collisionRadius;
			if( previousPosition > _bottom && position <= _bottom )
			{
				intersect = particle.previousX + ( particle.x - particle.previousX ) * ( _bottom - previousPosition ) / ( position - previousPosition );
				if( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius )
				{
					particle.velY = -particle.velY * bounce;
					particle.y += 2 * ( _bottom - position );
					collision = true;
				}
			}
			else if( previousPosition >= _top && position < _top )
			{
				intersect = particle.previousX + ( particle.x - particle.previousX ) * ( _top - previousPosition ) / ( position - previousPosition );
				if( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius )
				{
					particle.velY = -particle.velY * bounce;
					particle.y += 2 * ( _top - position );
					collision = true;
				}
			}
		}
		
		return collision;
	}
}
