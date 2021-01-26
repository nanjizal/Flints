package flints.common.initializers;

import flints.common.initializers.ImageInitializerBase;
import flints.common.initializers.ImageClass;

/**
 * The ImageClass Initializer sets the DisplayObject to use to draw
 * the particle. It is used with the DisplayObjectRenderer. When using the
 * BitmapRenderer it is more efficient to use the SharedImage Initializer.
 * 
 * <p>This class includes an object pool for reusing DisplayObjects when particles die.</p>
 * 
 * <p>To enable use of the object pool, it was necessary to alter the constructor so the 
 * parameters for the image class are passed as an array rather than as plain values.</p>
 */
class ImageClass extends ImageInitializerBase
{
	public var imageClass(get, set):Dynamic;
	public var parameters(get, set):Array<Dynamic>;
	
	private var _imageClass:Dynamic;
	private var _parameters:Array<Dynamic>;
	
	/**
	 * The constructor creates an ImageClass initializer for use by 
	 * an emitter. To add an ImageClass to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param imageClass The class to use when creating
	 * the particles' DisplayObjects.
	 * @param parameters The parameters to pass to the constructor
	 * for the image class.
	 * @param usePool Indicates whether particles should be reused when a particle dies.
	 * @param fillPool Indicates how many particles to create immediately in the pool, to
	 * avoid creating them when the particle effect is running.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( imageClass:Dynamic = null, parameters : Array<Dynamic> = null, usePool:Bool = false, fillPool:Int = 0 )
	{
		super( usePool );
		_imageClass = imageClass;
		_parameters = parameters != null ? parameters : [];
		if( fillPool > 0 )
		{
			this.fillPool( fillPool );
		}
		
	}
	
	/**
	 * The class to use when creating
	 * the particles' DisplayObjects.
	 */
	private function get_imageClass():Dynamic
	{
		return _imageClass;
	}
	private function set_imageClass( value:Dynamic ):Dynamic
	{
		_imageClass = value;
		if( _usePool )
		{
			clearPool();
		}
		return _imageClass;
	}
	
	/**
	 * The parameters to pass to the constructor
	 * for the image class.
	 */
	private function get_parameters():Array<Dynamic>
	{
		return _parameters;
	}
	private function set_parameters( value:Array<Dynamic> ):Array<Dynamic>
	{
		_parameters = value;
		if( _usePool )
		{
			clearPool();
		}
		return _parameters;
	}
	
	/**
	 * Used internally, this method creates an image object for displaying the particle 
	 * by calling the image class constructor with the supplied parameters.
	 */
	override public function createImage() : Dynamic
	{
		//return construct( _imageClass, _parameters );
		return Type.createInstance( _imageClass, _parameters );
	}
}
