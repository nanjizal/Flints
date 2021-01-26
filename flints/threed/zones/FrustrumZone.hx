package flints.threed.zones;

import openfl.geom.Matrix3D;
import openfl.geom.Rectangle;
import flints.threed.Vector3D;
import flints.threed.renderers.Camera;

/**
 * The FrustrumZone zone defines a zone in the shape of a camera frustrum. The
 * frustrum is the area of space visible using the camera. Everything in the
 * camera's field of view is inside the frustrum and everything outside the
 * camera's field of view is outside the frustrum.
 * 
 * <p>When using this zone, it is possible to adjust the view rect used when
 * calculating the frustrum so that the frustrum is slightly larger (or smaller)
 * than the camera's actual view frustrum.</p>
 */

class FrustrumZone implements Zone3D 
{
	public var camera(get, set):Camera;
	public var viewRect(get, set):Rectangle;
	
	private var _camera:Camera;
	private var _viewRect:Rectangle;
	
	/**
	 * The constructor creates a FrustrumZone zone.
	 * 
	 * @param camera The flint camera whose frustrum should be used.
	 * @param viewRect The rectangle describing the size and position
	 * of the viewing window. The camera points at position 0,0 in
	 * this rectangle, so a normal frustrum would have the form
	 * new Rectangle( -w/2, -h/2, w, h ). If using a BitmapRenderer,
	 * you could use the renderer's canvas as the viewRect, but you
	 * may want a slightly larger rectangle if this zone is used for
	 * removing particles via a DeathZone action.
	 */
	public function new( camera:Camera = null, viewRect:Rectangle = null )
	{
		_camera = camera;
		_viewRect = viewRect;
	}
			
	/**
	 * The flint camera whose frustrum should be used.
	 */
	public function get_camera() : Camera
	{
		return _camera;
	}
	public function set_camera( value : Camera ) : Camera
	{
		_camera = value;
		return _camera;
	}
	
	/**
	 * The rectangle describing the size and position
	 * of the viewing window. The camera points at position 0,0 in
	 * this rectangle, so a normal frustrum would have the form
	 * new Rectangle( -w/2, -h/2, w, h ). If using a BitmapRenderer,
	 * you could use the renderer's canvas as the viewRect, but you
	 * may want a slightly larger rectangle if this zone is used for
	 * removing particles via a DeathZone action to allow for the
	 * size of the particles.
	 */
	public function get_viewRect() : Rectangle
	{
		return _viewRect;
	}
	public function set_viewRect( value : Rectangle ) : Rectangle
	{
		_viewRect = value;
		return _viewRect;
	}

	/**
	 * The contains method determines whether a point is inside the box.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @param x The x coordinate of the location to test for.
	 * @param y The y coordinate of the location to test for.
	 * @return true if point is inside the zone, false if it is outside.
	 */
	public function contains( p:Vector3D ):Bool
	{
		var pos:Vector3D = _camera.transform.transformVector( p );
		if( pos.z < _camera.nearPlaneDistance || pos.z > _camera.farPlaneDistance )
		{
			return false;
		}
		pos.project();
		if( pos.x < _viewRect.left || pos.x > _viewRect.right
			|| pos.y < _viewRect.top || pos.y > _viewRect.bottom )
		{
			return false;
		}
		return true;
	}
	
	/**
	 * The getLocation method returns a random point inside the box.
	 * This method is used by the initializers and actions that
	 * use the zone. Usually, it need not be called directly by the user.
	 * 
	 * @return a random point inside the zone.
	 */
	public function getLocation():Vector3D
	{
		var z:Float = ( Math.random() * ( _camera.farPlaneDistance - _camera.nearPlaneDistance ) ) + _camera.nearPlaneDistance;
		var scale:Float = z / _camera.projectionDistance;
		var x:Float = ( ( Math.random() * _viewRect.width ) + _viewRect.left ) * scale;
		var y:Float = ( ( Math.random() * _viewRect.height ) + _viewRect.top ) * scale;
		var p:Vector3D = new Vector3D( x, y, z, 1 );
		var transform:Matrix3D = _camera.spaceTransform.clone();
		transform.invert();
		return transform.transformVector( p );
	}
	
	/**
	 * The getArea method returns the volume of the box.
	 * This method is used by the MultiZone class. Usually, 
	 * it need not be called directly by the user.
	 * 
	 * @return the volume of the box.
	 */
	public function getVolume():Float
	{
		var proj:Float = _viewRect.width * _viewRect.height;
		var front:Float = proj * _camera.nearPlaneDistance * _camera.nearPlaneDistance * _camera.nearPlaneDistance / ( _camera.projectionDistance * _camera.projectionDistance );
		var back:Float = proj * _camera.farPlaneDistance * _camera.farPlaneDistance * _camera.farPlaneDistance / ( _camera.projectionDistance * _camera.projectionDistance );
		return ( back - front ) / 3;
	}
}
