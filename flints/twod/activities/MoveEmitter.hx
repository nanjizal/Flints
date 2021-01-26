package flints.twod.activities;

import flints.common.activities.ActivityBase;
import flints.common.emitters.Emitter;
import flints.twod.emitters.Emitter2D;

/**
 * The MoveEmitter activity moves the emitter at a constant velocity.
 */
class MoveEmitter extends ActivityBase
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private var _velX:Float;
	private var _velY:Float;
	
	/**
	 * The constructor creates a MoveEmitter activity for use by 
	 * an emitter. To add a MoveEmitter to an emitter, use the
	 * emitter's addActvity method.
	 * 
	 * @see flints.common.emitters.Emitter#addActivity()
	 * 
	 * @param x The x coordinate of the velocity to move the emitter, 
	 * in pixels per second.
	 * @param y The y coordinate of the velocity to move the emitter, 
	 * in pixels per second.
	 */
	public function new( x:Float = 0, y:Float = 0 )
	{
		super();
		this.x = x;
		this.y = y;
	}
	
	/**
	 * The x coordinate of the velocity to move the emitter, 
	 * in pixels per second
	 */
	private function get_x():Float
	{
		return _velX;
	}
	private function set_x( value:Float ):Float
	{
		_velX = value;
		return _velX;
	}
	
	/**
	 * The y coordinate of the velocity to move the emitter, 
	 * in pixels per second
	 */
	private function get_y():Float
	{
		return _velY;
	}
	private function set_y( value:Float ):Float
	{
		_velY = value;
		return _velY;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter : Emitter, time : Float ) : Void
	{
		var e:Emitter2D = cast( emitter,Emitter2D );
		e.x += _velX * time;
		e.y += _velY * time;
	}
}
