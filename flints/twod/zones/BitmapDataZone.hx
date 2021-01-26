package flints.twod.zones;

import openfl.display.BitmapData;
import openfl.geom.Point;
import flints.common.utils.FastWeightedArray;
import flints.twod.particles.Particle2D;


/**
 * The BitmapData zone defines a shaped zone based on a BitmapData object.
 * The zone contains all pixels in the bitmap that are not transparent -
 * i.e. they have an alpha value greater than zero.
 */

class BitmapDataZone implements Zone2D 
{
	public var offsetX(get, set):Float;
	public var offsetY(get, set):Float;
	public var bitmapData(get, set):BitmapData;
	public var scaleY(get, set):Float;
	public var scaleX(get, set):Float;
	
	private var _bitmapData : BitmapData;
	private var _offsetX : Float;
	private var _offsetY : Float;
	private var _scaleX : Float;
	private var _scaleY : Float;
	private var _validPoints : FastWeightedArray;
	
	/**
	 * The constructor creates a BitmapDataZone object.
	 * 
	 * @param bitmapData The bitmapData object that defines the zone.
	 * @param xOffset A horizontal offset to apply to the pixels in the BitmapData object 
	 * to reposition the zone
	 * @param yOffset A vertical offset to apply to the pixels in the BitmapData object 
	 * to reposition the zone
	 * @param scaleX A scale factor to stretch the bitmap horizontally
	 * @param scaleY A scale factor to stretch the bitmap vertically
	 */
	public function new( bitmapData : BitmapData = null, offsetX : Float = 0, offsetY : Float = 0, scaleX:Float = 1, scaleY:Float = 1 )
	{
		_bitmapData = bitmapData;
		_offsetX = offsetX;
		_offsetY = offsetY;
		_scaleX = scaleX;
		_scaleY = scaleY;
		invalidate();
	}
	
	/**
	 * The bitmapData object that defines the zone.
	 */
	private function get_bitmapData() : BitmapData
	{
		return _bitmapData;
	}
	private function set_bitmapData( value : BitmapData ) : BitmapData
	{
		_bitmapData = value;
		invalidate();
		return _bitmapData;
	}

	/**
	 * A horizontal offset to apply to the pixels in the BitmapData object 
	 * to reposition the zone
	 */
	private function get_offsetX() : Float
	{
		return _offsetX;
	}
	private function set_offsetX( value : Float ) : Float
	{
		_offsetX = value;
		return _offsetX;
	}

	/**
	 * A vertical offset to apply to the pixels in the BitmapData object 
	 * to reposition the zone
	 */
	private function get_offsetY() : Float
	{
		return _offsetY;
	}
	private function set_offsetY( value : Float ) : Float
	{
		_offsetY = value;
		return _offsetY;
	}

	/**
	 * A scale factor to stretch the bitmap horizontally
	 */
	private function get_scaleX() : Float
	{
		return _scaleX;
	}
	private function set_scaleX( value : Float ) : Float
	{
		_scaleX = value;
		return _scaleX;
	}

	/**
	 * A scale factor to stretch the bitmap vertically
	 */
	private function get_scaleY() : Float
	{
		return _scaleY;
	}
	private function set_scaleY( value : Float ) : Float
	{
		_scaleY = value;
		return _scaleY;
	}

	/**
	 * This method forces the zone to revaluate itself. It should be called whenever the 
	 * contents of the BitmapData object change. However, it is an intensive method and 
	 * calling it frequently will likely slow your code down.
	 */
	public function invalidate():Void
	{
		if( _bitmapData == null )
		{
			return;
		}
		_validPoints = new FastWeightedArray();
		//for( var x : Int = 0; x < _bitmapData.width ; ++x )
		for( x in 0 ... _bitmapData.width )
		{
			//for( var y : Int = 0; y < _bitmapData.height ; ++y )
			for( y in 0 ... _bitmapData.height )
			{
				var pixel : Int = _bitmapData.getPixel32( x, y );
				var ratio : Float = ( pixel >> 24 & 0xFF ) / 0xFF;
				if ( ratio != 0 )
				{
					_validPoints.add( new Point( x, y ), ratio );
				}
			}
		}
	}

	/**
	 * The contains method determines whether a point is inside the zone.
	 * 
	 * @param point The location to test for.
	 * @return true if point is inside the zone, false if it is outside.
	 */
	public function contains( x : Float, y : Float ) : Bool
	{
		if( x >= _offsetX && x <= _offsetX + _bitmapData.width * scaleX
			&& y >= _offsetY && y <= _offsetY + _bitmapData.height * scaleY )
		{
			var pixel : Int = _bitmapData.getPixel32( Math.round( ( x - _offsetX ) / _scaleX ), Math.round( ( y - _offsetY ) / _scaleY ) );
			return ( pixel >> 24 & 0xFF ) != 0;
		}
		return false;
	}

	/**
	 * The getLocation method returns a random point inside the zone.
	 * 
	 * @return a random point inside the zone.
	 */
	public function getLocation() : Point
	{
		var p:Point = cast( _validPoints.getRandomValue(),Point ).clone();
		p.x = p.x * _scaleX + _offsetX;
		p.y = p.y * _scaleY + _offsetY;
		return p; 
	}
	
	/**
	 * The getArea method returns the size of the zone.
	 * It's used by the MultiZone class to manage the balancing between the
	 * different zones.
	 * 
	 * @return the size of the zone.
	 */
	public function getArea() : Float
	{
		return _validPoints.totalRatios * _scaleX * _scaleY;
	}

	/**
	 * Manages collisions between a particle and the zone. The particle will collide with the edges of
	 * the zone, from the inside or outside. In the interests of speed, these collisions do not take 
	 * account of the collisionRadius of the particle and they do not calculate an accurate bounce
	 * direction from the shape of the zone. Priority is placed on keeping particles inside 
	 * or outside the zone.
	 * 
	 * @param particle The particle to be tested for collision with the zone.
	 * @param bounce The coefficient of restitution for the collision.
	 * 
	 * @return Whether a collision occured.
	 */
	public function collideParticle(particle:Particle2D, bounce:Float = 1):Bool
	{
		if( contains( particle.x, particle.y ) != contains( particle.previousX, particle.previousY ) )
		{
			particle.x = particle.previousX;
			particle.y = particle.previousY;
			particle.velX = - bounce * particle.velX;
			particle.velY = - bounce * particle.velY;
			return true;
		}
		else
		{
			return false;
		}
	}
}
