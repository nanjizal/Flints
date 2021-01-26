package flints.common.initializers;

//import openfl.display.DisplayObject;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.SharedImage;
import flints.common.initializers.InitializerBase;


/**
 * The SharedImage Initializer sets the DisplayObject to use to draw
 * the particle. It is used with the BitmapRenderer. When using the
 * DisplayObjectRenderer the ImageClass Initializer must be used.
 * 
 * With the BitmapRenderer, the DisplayObject is copied into the bitmap
 * using the particle's property to place the image correctly. So
 * many particles can share the same DisplayObject because it is
 * only indirectly used to display the particle.
 */

class SharedImage extends InitializerBase
{
	public var image(get, set):DisplayObject;
	
	private var _image:DisplayObject;
	
	/**
	 * The constructor creates a SharedImage initializer for use by 
	 * an emitter. To add a SharedImage to all particles created by 
	 * an emitter, use the emitter's addInitializer method.
	 * 
	 * @param image The DisplayObject to use for each particle created by the emitter.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( image:DisplayObject = null )
	{
		super();
		_image = image;
	}
	
	/**
	 * The DisplayObject to use for each particle created by the emitter.
	 */
	private function get_image():DisplayObject
	{
		return _image;
	}
	private function set_image( value:DisplayObject ):DisplayObject
	{
		_image = value;
		return _image;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		particle.image = _image;
	}
}
