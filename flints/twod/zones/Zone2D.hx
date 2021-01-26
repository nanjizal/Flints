package flints.twod.zones;

import openfl.geom.Point;
import flints.twod.particles.Particle2D;


/**
 * The Zones interface must be implemented by all zones.
 * 
 * <p>A zone is a class that defined a region in 2d space. The two required methods 
 * make it easy to get a random point within the zone and to find whether a specific
 * point is within the zone. Zones are used to define the start location for particles
 * (in the Position initializer), to define the start velocity for particles (in the
 * Velocity initializer), and to define zones within which the particles die.</p>
 */
interface Zone2D
{
	/**
	 * Determines whether a point is inside the zone.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @param x The x coordinate of the location to test for.
	 * @param y The y coordinate of the location to test for.
	 * @return true if point is inside the zone, false if it is outside.
	 */
	function contains( x:Float, y:Float ):Bool;

	/**
	 * Returns a random point inside the zone.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @return a random point inside the zone.
	 */
	function getLocation():Point;

	/**
	 * Returns the size of the zone.
	 * This method is used by the MultiZone class to manage the balancing between the
	 * different zones.
	 * 
	 * @return the size of the zone.
	 */
	function getArea():Float;
	
	/**
	 * Manages collisions between a particle and the zone. This method handles altering the
	 * particle's position and velocity in response to the collision.
	 * 
	 * @param particle The particle to be tested for collision with the zone.
	 * @param bounce The coefficient of restitution for the collision.
	 * 
	 * @return Whether a collision occured.
	 */
	function collideParticle( particle:Particle2D, bounce:Float = 1 ):Bool;
}
