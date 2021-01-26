package flints.threed.renderers.controllers;

import openfl.display.DisplayObject;
import flints.threed.renderers.Camera;

/**
 * Sets keyboard input to make a renderer's camera orbit around a point in response to 
 * keyboard input.
 * 
 * <p>After assigning a camera to an instance of this class, the camera responds to the
 * following keyboard input</p>
 * 
 * <ul>
 * <li>W or Up arrow keys - track towards the target.</li>
 * <li>S or Down arrow keys - track away from the target.</li>
 * <li>A or Left arrow keys - orbit left around the target.</li>
 * <li>D or Right arrow keys - orbit right around the target.</li>
 * </ul>
 */
class OrbitCamera extends KeyboardControllerBase
{
	public var rotationRate(get, set):Float;
	public var trackRate(get, set):Float;
	
	private var _rotationRate:Float;
	private var _trackRate:Float;
	
	/**
	 * The constructor creates an OrbitCamera controller.
	 * 
	 * @param stage The display object on which to listen for keyboard input. This should usually
	 * be a reference to the stage.
	 * @param camera The camera to control with this controller.
	 * @param rotationRate The rate at which to rotate the camera when the appropriate keys are 
	 * pressed, in radians per second.
	 * @param trackRate The rate at which to track the camera when the appropriate keys are 
	 * pressed, in units per second.
	 * @param useInternalTick Indicates whether the camera controller should use its
	 * own tick event to update its state. The internal tick process is tied
	 * to the framerate and updates the camera every frame.
	 */
	public function new( stage:DisplayObject = null, camera:Camera = null, rotationRate:Float = 1, trackRate:Float = 100, useInternalTick:Bool = true )
	{
		super();
		if( camera != null )
		{
			this.camera = camera;
		}
		if( stage != null )
		{
			this.stage = stage;
		}
		this.rotationRate = rotationRate;
		this.trackRate = trackRate;
		this.useInternalTick = useInternalTick;
	}
	
	/**
	 * The rate at which to rotate the camera when the appropriate keys are 
	 * pressed, in radians per second.
	 */
	private function get_rotationRate():Float
	{
		return _rotationRate;
	}
	private function set_rotationRate( value:Float ):Float
	{
		_rotationRate = value;
		return _rotationRate;
	}
	
	/**
	 * The rate at which to track the camera when the appropriate keys are 
	 * pressed, in units per second.
	 */
	private function get_trackRate():Float
	{
		return _trackRate;
	}
	private function set_trackRate( value:Float ):Float
	{
		_trackRate = value;
		return _trackRate;
	}

	override private function updateCamera( time:Float ):Void
	{
		if( upDown || wDown )
		{
			camera.dolly( _trackRate * time );
		}
		if( downDown || sDown )
		{
			camera.dolly( -_trackRate * time );
		}
		if( leftDown || aDown )
		{
			camera.orbit( -_rotationRate * time );
		}
		if( rightDown || dDown )
		{
			camera.orbit( _rotationRate * time );
		}
	}
}
