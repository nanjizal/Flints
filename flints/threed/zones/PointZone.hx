package flints.threed.zones;

import flints.threed.Vector3D;
import flints.threed.geom.Vector3DUtils;

/**
 * The PointZone zone defines a zone that contains a single point.
 */

class PointZone implements Zone3D 
{
	public var point(get, set):Vector3D;
	
	private var _point:Vector3D;
	
	/**
	 * The constructor defines a PointZone zone.
	 * 
	 * @param point The point that is the zone.
	 */
	public function new( point:Vector3D = null )
	{
		this.point = point != null ? point : new Vector3D();
	}
	
	/**
	 * The point that is the zone.
	 */
	private function get_point() : Vector3D
	{
		return _point.clone();
	}
	private function set_point( value : Vector3D ) : Vector3D
	{
		_point = Vector3DUtils.clonePoint( value );
		return _point;
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
	public function contains( p:Vector3D ):Bool
	{
		return _point.equals( p );
	}
	
	/**
	 * The getLocation method returns a random point inside the zone.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @return a random point inside the zone.
	 */
	public function getLocation():Vector3D
	{
		return _point.clone();
	}
	
	/**
	 * The getArea method returns the size of the zone.
	 * This method is used by the MultiZone class. Usually, 
	 * it need not be called directly by the user.
	 * 
	 * @return A value of 1 because the zone contains a single point.
	 */
	public function getVolume():Float
	{
		// treat as one pixel cube
		return 1;
	}
}
