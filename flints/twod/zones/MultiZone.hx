package flints.twod.zones;

import openfl.errors.Error;
import openfl.geom.Point;
import flints.twod.particles.Particle2D;


/**
 * The MutiZone zone defines a zone that combines other zones into one larger zone.
 */

class MultiZone implements Zone2D 
{
	private var _zones : Array<Dynamic>;
	private var _areas : Array<Dynamic>;
	private var _totalArea : Float;
	
	/**
	 * The constructor defines a MultiZone zone.
	 */
	public function new()
	{
		_zones = new Array<Dynamic>();
		_areas = new Array<Dynamic>();
		_totalArea = 0;
	}
	
	/**
	 * The addZone method is used to add a zone into this MultiZone object.
	 * 
	 * @param zone The zone you want to add.
	 */
	public function addZone( zone:Zone2D ):Void
	{
		_zones.push( zone );
		var area:Float = zone.getArea();
		_areas.push( area );
		_totalArea += area;
	}
	
	/**
	 * The removeZone method is used to remove a zone from this MultiZone object.
	 * 
	 * @param zone The zone you want to add.
	 */
	public function removeZone( zone:Zone2D ):Void
	{
		var len:Int = _zones.length;
		//for( var i:Int = 0; i < len; ++i )
		for( i in 0 ... len )
		{
			if( _zones[i] == zone )
			{
				_totalArea -= _areas[i];
				_areas.splice( i, 1 );
				_zones.splice( i, 1 );
				return;
			}
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function contains( x:Float, y:Float ):Bool
	{
		var len:Int = _zones.length;
		//for( var i:Int = 0; i < len; ++i )
		for( i in 0 ... len )
		{
			if( cast( _zones[i],Zone2D ).contains( x, y ) )
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * @inheritDoc
	 */
	public function getLocation():Point
	{
		var selectZone:Float = Math.random() * _totalArea;
		var len:Int = _zones.length;
		//for( var i:Int = 0; i < len; ++i )
		for( i in 0 ... len )
		{
			if( ( selectZone -= _areas[i] ) <= 0 )
			{
				return cast( _zones[i],Zone2D ).getLocation();
			}
		}
		if( _zones.length == 0 )
		{
			throw new Error( "Attempt to use a MultiZone object that contains no Zones" );
		}
		else
		{
			return cast( _zones[0],Zone2D ).getLocation();
		}
		return null;
	}
	
	/**
	 * @inheritDoc
	 */
	public function getArea():Float
	{
		return _totalArea;
	}
	
	/**
	 * @inheritDoc
	 */
	public function collideParticle( particle:Particle2D, bounce:Float = 1 ):Bool
	{
		var collide:Bool = false;
		for( zone in _zones.iterator() )
		{
			collide = zone.collideParticle( particle, bounce ) || collide;
		}
		return collide;
	}
}
