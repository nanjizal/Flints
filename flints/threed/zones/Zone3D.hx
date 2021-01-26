package flints.threed.zones;

import flints.threed.Vector3D;

/**
 * The Zones interface must be implemented by all zones.
 * 
 * <p>A zone is a class that defined a region in 2d space. The two required methods 
 * make it easy to get a random point within the zone and to find whether a specific
 * point is within the zone. Zones are used to define the start location for particles
 * (in the Position initializer), to define the start velocity for particles (in the
 * Velocity initializer), and to define zones within which the particles die.</p>
 */
interface Zone3D
{
	/**
	 * The contains method determines whether a point is inside the zone.
	 * 
	 * @param x The x coordinate of the location to test for.
	 * @param y The y coordinate of the location to test for.
	 * @return true if point is inside the zone, false if it is outside.
	 */
	function contains( p:Vector3D ):Bool;

	/**
	 * The getLocation method returns a random point inside the zone.
	 * 
	 * @return a random point inside the zone.
	 */
	function getLocation():Vector3D;
	

	/**
	 * The getArea method returns the size of the zone.
	 * It's used by the MultiZone class to manage the balancing between the
	 * different zones.
	 * 
	 * @return the size of the zone.
	 */
	function getVolume():Float;
}
