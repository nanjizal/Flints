package flints.twod.activities;

import openfl.display.DisplayObject;
import openfl.geom.Point;
import flints.common.activities.ActivityBase;
import flints.common.emitters.Emitter;
import flints.common.utils.DisplayObjectUtils;
import flints.twod.emitters.Emitter2D;

/**
 * The FollowDisplayObject activity causes the emitter to follow
 * the position and rotation of a DisplayObject. The purpose is for the emitter
 * to emit particles from the location of the DisplayObject.
 */
class FollowDisplayObject extends ActivityBase
{
	public var renderer(get, set):DisplayObject;
	public var displayObject(get, set):DisplayObject;
	
	private var _renderer:DisplayObject;
	private var _displayObject:DisplayObject;
	
	/**
	 * The constructor creates a FollowDisplayObject activity for use by 
	 * an emitter. To add a FollowDisplayObject to an emitter, use the
	 * emitter's addActvity method.
	 * 
	 * @param renderer The display object whose coordinate system the DisplayObject's position is 
	 * converted to. This is usually the renderer for the particle system created by the emitter.
	 * 
	 * @see flints.common.emitters.Emitter#addActivity()
	 */
	public function new( displayObject:DisplayObject = null, renderer:DisplayObject = null )
	{
		super();
		this.displayObject = displayObject;
		this.renderer = renderer;
	}
	
	/**
	 * The DisplayObject whose coordinate system the DisplayObject's position is converted to. This
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
	 * The display object that the emitter follows.
	 */
	private function get_displayObject():DisplayObject
	{
		return _displayObject;
	}
	private function set_displayObject( value:DisplayObject ):DisplayObject
	{
		_displayObject = value;
		return _displayObject;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, time : Float ) : Void
	{
		var e:Emitter2D = cast( emitter,Emitter2D );
		var p:Point = new Point( 0, 0 );
		p = _displayObject.localToGlobal( p );
		p = _renderer.globalToLocal( p );
		var r:Float = 0;
		r = DisplayObjectUtils.localToGlobalRotation( _displayObject, r );
		r = DisplayObjectUtils.globalToLocalRotation( _renderer, r );
		e.x = p.x;
		e.y = p.y;
		e.rotation = r;
	}
}
