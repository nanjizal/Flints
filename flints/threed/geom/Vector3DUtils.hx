package flints.threed.geom;

import flints.threed.Vector3D;

/**
 * Utility methods for working with the Vector3D class.
 */
class Vector3DUtils 
{
	public static function cloneVector( v:Vector3D ):Vector3D
	{
		return new Vector3D( v.x, v.y, v.z, 0 );
	}
	
	public static function clonePoint( v:Vector3D ):Vector3D
	{
		return new Vector3D( v.x, v.y, v.z, 1 );
	}

	public static function cloneUnit( v:Vector3D ):Vector3D
	{
		var temp:Vector3D = new Vector3D( v.x, v.y, v.z, 0 );
		temp.normalize();
		return temp;
	}

	public static function distanceSquared( v:Vector3D, u:Vector3D ):Float
	{
		var dx:Float = v.x - u.x;
		var dy:Float = v.y - u.y;
		var dz:Float = v.z - u.z;
		return Math.sqrt( dx * dx + dy * dy + dz * dz );
	}
	
	public static function getPerpendiculars( normal:Vector3D ):Array<Dynamic>
	{
		var p1:Vector3D = getPerpendicular( normal );
		var p2:Vector3D = normal.crossProduct( p1 );
		p2.normalize();
		return [ p1, p2 ];
	}
	
	public static function getPerpendicular( v:Vector3D ):Vector3D
	{
		if( v.x == 0 )
		{
			return new Vector3D( 1, 0, 0 );
		}
		else
		{
			var temp:Vector3D = new Vector3D( v.y, -v.x, 0 );
			temp.normalize();
			return temp;
		}
	}
}
