package flints.common.utils;

//import openfl.display.DisplayObject;
import flints.common.utils.DisplayObjectUtils;

/**
 * Utility methods for use with display objects.
 */
class DisplayObjectUtils 
{
	/**
	 * Converts a rotation in the coordinate system of a display object 
	 * to a global rotation relative to the stage.
	 * 
	 * @param obj The display object
	 * @param rotation The rotation
	 * 
	 * @return The rotation relative to the stage's coordinate system.
	 */
	public static function localToGlobalRotation( obj:DisplayObject, rotation:Float ):Float
	{
		var rot:Float = rotation + obj.rotation;
		var current:DisplayObject = obj.parent;
		while(  current != null && current != obj.stage )
		{
			rot += current.rotation;
			current = current.parent;
		}
		return rot;
	}

	/**
	 * Converts a global rotation in the coordinate system of the stage 
	 * to a local rotation in the coordinate system of a display object.
	 * 
	 * @param obj The display object
	 * @param rotation The rotation
	 * 
	 * @return The rotation relative to the display object's coordinate system.
	 */
	public static function globalToLocalRotation( obj:DisplayObject, rotation:Float ):Float
	{
		var rot:Float = rotation - obj.rotation;
		var current:DisplayObject = obj.parent;
		while( current != null && current != obj.stage )
		{
			rot -= current.rotation;
			current = current.parent;
		}
		return rot;
	}
}
