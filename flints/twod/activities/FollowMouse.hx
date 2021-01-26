package flints.twod.activities;

import openfl.display.DisplayObject;
import flints.common.activities.ActivityBase;
import flints.common.emitters.Emitter;
import flints.twod.emitters.Emitter2D;


/**
 * The FollowMouse activity causes the emitter to follow
 * the position of the mouse pointer. The effect is for
 * it to emit particles from the mouse pointer location.
 */
class FollowMouse extends ActivityBase
{
	public var renderer(get, set):DisplayObject;
	
	private var _renderer:DisplayObject;
	
	/**
	 * The constructor creates a FollowMouse activity for use by 
	 * an emitter. To add a FollowMouse to an emitter, use the
	 * emitter's addActvity method.
	 * 
	 * @param renderer The display object whose coordinate system the mouse position is 
	 * converted to. This is usually the renderer for the particle system created by the emitter.
	 * 
	 * @see flints.common.emitters.Emitter#addActivity()
	 */
	public function new( renderer:DisplayObject = null )
	{
		super();
		this.renderer = renderer;
	}
	
	/**
	 * The display object whose coordinate system the mouse position is converted to. This
	 * is usually the renderer for the particle system created by the emitter.
	 */
	private function get_renderer():DisplayObject
	{
		return _renderer;
	}
	private function set_renderer( value:DisplayObject ):DisplayObject
	{
		_renderer = value;
		return _renderer;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, time : Float ) : Void
	{
		var e:Emitter2D = cast( emitter,Emitter2D );
		e.x = _renderer.mouseX;
		e.y = _renderer.mouseY;
	}
}
