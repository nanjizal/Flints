package flints.threed.renderers;

import openfl.errors.Error;
import openfl.geom.Matrix3D;
import flints.threed.Vector3D;
import openfl.Vector;
import flints.threed.geom.Matrix3DUtils;
import flints.threed.geom.Vector3DUtils;
import flints.threed.renderers.controllers.CameraController;

/**
 * The camera class is used by Flint's internal 3D renderers to manage the view on the 3D
 * world that is displayed by the renderer. Each renderer has a camera property, which is
 * its camera object.
 */
class Camera 
{
	public var controller(get, set):CameraController;
	public var down(get, set):Vector3D;
	public var target(get, set):Vector3D;
	public var _direction(get, never):Vector3D;
	public var nearPlaneDistance(get, set):Float;
	public var spaceTransform(get, never):Matrix3D;
	public var _front(get, never):Vector3D;
	public var _track(get, never):Vector3D;
	public var transform(get, never):Matrix3D;
	public var projectionDistance(get, set):Float;
	public var direction(get, set):Vector3D;
	public var farPlaneDistance(get, set):Float;
	public var position(get, set):Vector3D;
	
	private var _projectionDistance:Float;
	private var _nearDistance:Float;
	private var _farDistance:Float;

	private var _transform:Matrix3D;
	private var _spaceTransform:Matrix3D;
	
	private var _position:Vector3D;
	private var _down:Vector3D;
	private var _target:Vector3D;
	
	private var _controller:CameraController;
	
	/*
	 * These properties have private getters because they can be
	 * invalidated when other properties are set - the getter
	 * recalculates the value if it has been invalidated
	 */
	private var _pDirection:Vector3D;
	private var _pTrack:Vector3D;
	private var _pFront:Vector3D;
	
	private var _realDown:Vector3D;
	private var _projectionTransform:Matrix3D;
	
	/**
	 * The constructor creates a Camera object. Usually, users don't need to create camera
	 * objects, but will use the camera objects that are properties of Flint's renderers.
	 */
	public function new()
	{
		_projectionDistance = 400;
		_nearDistance = 10;
		_farDistance = 2000;
		_position = new Vector3D( 0, 0, 0, 1 );
		_target = new Vector3D( 0, 0, 0, 1 );
		_down = new Vector3D( 0, 1, 0 );
		_pDirection = new Vector3D( 0, 0, 1 );
		_realDown = new Vector3D();
		_projectionTransform = new Matrix3D();
	}

	/**
	 * The point that the camera looks at. Setting this will
	 * invalidate any setting for the camera direction - the direction
	 * will be recalculated based on the position and the target.
	 * 
	 * @see #direction
	 */
	private function get_target():Vector3D
	{
		return _target.clone();
	}
	private function set_target( value:Vector3D ):Vector3D
	{
		_target = Vector3DUtils.clonePoint( value );
		_pDirection = null;
		_pTrack = null;
		_spaceTransform = null;
		return value;
	}
	
	/**
	 * The location of the camera.
	 */
	private function get_position():Vector3D
	{
		return _position.clone();
	}
	private function set_position( value:Vector3D ):Vector3D
	{
		_position = Vector3DUtils.clonePoint( value );
		_spaceTransform = null;
		if( _target != null )
		{
			_pDirection = null;
			_pTrack = null;
		}
		return value;
	}
	
	/**
	 * The direction the camera is pointing. Setting this will invalidate any
	 * setting for the target, since the camera now points in this direction
	 * rather than pointing towards the target.
	 * 
	 * @see #target
	 */
	private function get_direction():Vector3D
	{
		return _direction.clone();
	}
	private function set_direction( value:Vector3D ):Vector3D
	{
		_pDirection = Vector3DUtils.cloneUnit( value );
		_target = null;
		_spaceTransform = null;
		_pTrack = null;
		return value;
	}
	
	/**
	 * The down direction for the camera. If this is not perpendicular to the direction the camera points, 
	 * the camera is tilted down or up from this up direction to point in the direction or at the target.
	 */
	private function get_down():Vector3D
	{
		return _down.clone();
	}
	private function set_down( value:Vector3D ):Vector3D
	{
		_down = Vector3DUtils.cloneUnit( value );
		_spaceTransform = null;
		_pTrack = null;
		return value;
	}
	
	/**
	 * The transform matrix that converts positions in world space to positions in camera space.
	 * The projection transform is part of this transform - so vectors need only to have their
	 * project method called to get their position in 2D camera space.
	 */
	private function get_transform():Matrix3D
	{
		if( _spaceTransform == null || _transform == null )
		{
			_transform = spaceTransform.clone();
			//_projectionTransform.rawData = Vector<Float>( [
				//_projectionDistance, 0, 0, 0,
				//0, _projectionDistance, 0, 0,
				//0, 0, 1, 1,
				//0, 0, 0, 0
			//] );
			var vec:Vector<Float> = new Vector<Float>();
			vec.push(_projectionDistance);
			vec.push(0);
			vec.push(0);
			vec.push(0);
			vec.push(0);
			vec.push(_projectionDistance);
			vec.push(0);
			vec.push(0);
			vec.push(0);
			vec.push(0);
			vec.push(1);
			vec.push(1);
			vec.push(0);
			vec.push(0);
			vec.push(0);
			vec.push(0);
			_projectionTransform.rawData = vec;
			_transform.append( _projectionTransform );
		}
		return _transform;
	}

	/**
	 * The transform matrix that converts positions in world space to positions in camera space.
	 * The projection transform is not part of this transform.
	 */
	private function get_spaceTransform():Matrix3D
	{
		if( _spaceTransform == null )
		{
			// This is more efficient than
			//_realDown = _direction.crossProduct( _track );
			_realDown.x = _direction.y * _track.z - _direction.z * _track.y;
			_realDown.y = _direction.z * _track.x - _direction.x * _track.z;
			_realDown.z = _direction.x * _track.y - _direction.y * _track.x;
			
			_spaceTransform = Matrix3DUtils.newBasisTransform(
				Vector3DUtils.cloneUnit( _track ),
				Vector3DUtils.cloneUnit( _realDown ),
				Vector3DUtils.cloneUnit( _direction ) );
			_spaceTransform.prependTranslation( -_position.x, -_position.y, -_position.z );
		}
		return _spaceTransform;
	}
			
	/**
	 * Dolly or Track the camera in/out in the direction it's facing.
	 * 
	 * @param distance The distance to move the camera. Positive values track in and
	 * negative values track out.
	 */
	public function dolly( distance:Float ):Void
	{
		var dollyVector:Vector3D = _direction.clone();
		dollyVector.scaleBy( distance );
		_position.incrementBy( dollyVector );
		_spaceTransform = null;
	}
	
	/**
	 * Raise or lower the camera.
	 * 
	 * @param distance The distance to lift the camera. Positive values raise the camera
	 * and negative values lower the camera.
	 */
	public function lift( distance:Float ):Void
	{
		var liftVector:Vector3D = _down.clone();
		liftVector.scaleBy( -distance );
		_position.incrementBy( liftVector );
		_spaceTransform = null;
	}
	
	/**
	 * Dolly or Track the camera left/right.
	 * 
	 * @param distance The distance to move the camera. Positive values move the camera to the
	 * right, negative values move it to the left.
	 */
	public function track( distance:Float ):Void
	{
		var trackVector:Vector3D = _track.clone();
		trackVector.scaleBy( distance );
		_position.incrementBy( trackVector );
		_spaceTransform = null;
	}
	
	/**
	 * Tilt the camera up or down.
	 * 
	 * @param The angle (in radians) to tilt the camera. Positive values tilt up,
	 * negative values tilt down.
	 */
	public function tilt( angle:Float ):Void
	{
		var m:Matrix3D = Matrix3DUtils.newRotate( angle, _track );
		_pDirection = m.transformVector( _direction );
		_spaceTransform = null;
		_target = null;
	}
	
	/**
	 * Pan the camera left or right.
	 * 
	 * @param The angle (in radians) to pan the camera. Positive values pan right,
	 * negative values pan left.
	 */
	public function pan( angle:Float ):Void
	{
		var m:Matrix3D = Matrix3DUtils.newRotate( angle, _down );
		_pDirection = m.transformVector( _direction );
		_pTrack = null;
		_spaceTransform = null;
		_target = null;
	}

	/**
	 * Roll the camera clockwise or counter-clockwise.
	 * 
	 * @param The angle (in radians) to roll the camera. Positive values roll clockwise,
	 * negative values roll counter-clockwise.
	 */
	public function roll( angle:Float ):Void
	{
		var m:Matrix3D = Matrix3DUtils.newRotate( angle, _front );
		_down = m.transformVector( _down );
		_pTrack = null;
		_spaceTransform = null;
	}
	
	/**
	 * Orbit the camera around the target.
	 * 
	 * @param The angle (in radians) to orbit the camera. Positive values orbit to the right,
	 * negative values orbit to the left.
	 */
	public function orbit( angle:Float ):Void
	{
		if( _target == null )
		{
			throw new Error( "Attempting to orbit camera when no target is set" );
		}
		var m:Matrix3D = Matrix3DUtils.newRotate( -angle, down );
		_position = m.transformVector( _position );
		_pDirection = null;
		_pTrack = null;
		_spaceTransform = null;
	}
	 
	/**
	 * The distance to the camera's near plane
	 * - particles closer than this are not rendered.
	 * 
	 * The default value is 10.
	 */
	private function get_nearPlaneDistance():Float
	{
		return _nearDistance;
	}
	private function set_nearPlaneDistance( value:Float ):Float
	{
		_nearDistance = value;
		return value;
	}
	
	/**
	 * The distance to the camera's far plane
	 * - particles farther away than this are not rendered.
	 * 
	 * The default value is 2000.
	 */
	private function get_farPlaneDistance():Float
	{
		return _farDistance;
	}
	private function set_farPlaneDistance( value:Float ):Float
	{
		_farDistance = value;
		return value;
	}
	
	/**
	 * The distance to the camera's projection distance. Particles this
	 * distance from the camera are rendered at their normal size. Perspective
	 * will cause closer particles to appear larger than normal and more 
	 * distant particles to appear smaller than normal.
	 * 
	 * The default value is 400.
	 */
	private function get_projectionDistance():Float
	{
		return _projectionDistance;
	}
	private function set_projectionDistance( value:Float ):Float
	{
		_projectionDistance = value;
		_transform = null;
		return value;
	}
	
	/*
	 * private getters for properties that can be invaliadated.
	 */
	private function get__track():Vector3D
	{
		if( _pTrack == null )
		{
			_pTrack = _down.crossProduct( _direction );
		}
		_pFront == null;
		return _pTrack;
	}

	private function get__front():Vector3D
	{
		if( _pFront == null )
		{
			_pFront = _track.crossProduct( _down );
		}
		return _pFront;
	}
	
	private function get__direction():Vector3D
	{
		if( _pDirection == null && _target != null )
		{
			_pDirection = _target.subtract( _position );
			_pDirection.normalize();
		}
		return _pDirection;
	}
	
	public function get_controller():CameraController
	{
		return _controller;
	}
	public function set_controller( value:CameraController ):CameraController
	{
		if( _controller != null )
		{
			_controller.camera = null;
		}
		_controller = value;
		_controller.camera = this;
		return _controller;
	}
}
