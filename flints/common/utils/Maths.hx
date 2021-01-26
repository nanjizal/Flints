package flints.common.utils;

import flints.common.utils.Maths;

/**
 * The MathsAngles class contains a coupleof useful methods for use in maths functions.
 */
// changed name from Maths to MathsAngles
class MathsAngles
{
    // 180 / Math.PI
	private static inline var RADTODEG:Float = 57.2957795131;

    // Math.PI / 180
	private static inline var DEGTORAD:Float = 0.0174532925199;
	
	/**
	 * Converts an angle from radians to degrees
	 * 
	 * @param radians The angle in radians
	 * @return The angle in degrees
	 */
	public static function asDegrees( radians:Float ):Float
	{
		return radians * RADTODEG;
	}
	
	/**
	 * Converts an angle from degrees to radians
	 * 
	 * @param radians The angle in degrees
	 * @return The angle in radians
	 */
	public static function asRadians( degrees:Float ):Float
	{
		return degrees * DEGTORAD;
	}
}
