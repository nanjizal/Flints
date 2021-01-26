package flints.common.utils;
/**
 * This function is used to find a color between two other colors.
 * 
 * @param color1 The first color.
 * @param color2 The second color.
 * @param ratio The proportion of the first color to use. The rest of the color 
 * is made from the second color.
 * @return The color created.
 */
class InterpolateColors
{
	
	public static function interpolate ( color1:Int, color2:Int, ratio:Float ):Int
	{
		var inv:Float = 1 - ratio;
		var red:Int = Math.round( ( ( color1 >>> 16 ) & 255 ) * ratio + ( ( color2 >>> 16 ) & 255 ) * inv );
		var green:Int = Math.round( ( ( color1 >>> 8 ) & 255 ) * ratio + ( ( color2 >>> 8 ) & 255 ) * inv );
		var blue:Int = Math.round( ( ( color1 ) & 255 ) * ratio + ( ( color2 ) & 255 ) * inv );
		var alpha:Int = Math.round( ( ( color1 >>> 24 ) & 255 ) * ratio + ( ( color2 >>> 24 ) & 255 ) * inv );
		return ( alpha << 24 ) | ( red << 16 ) | ( green << 8 ) | blue;
	}
	
}
