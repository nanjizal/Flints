package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.SetImageProperties;
import flints.common.initializers.InitializerBase;

/**
 * The SetImageProperties Initializer can be used to set any properties of a particle's
 * image object. This Initializer has a single property that is any object whose properties
 * should be copied to the image object.
 * 
 * This Initializer has a priority of -10 so that it runs after the image setting Initializers,
 * which have a priority of zero.
 */

class SetImageProperties extends InitializerBase
{
	public var properties(get, set):Dynamic;
	
	private var _properties:Dynamic;
	
	/**
	 * The constructor creates a SetImageProperties initializer for use by 
	 * an emitter. To apply a SetImageProperties to all particles created by an emitter,
	 * use the emitter's addInitializer method.
	 * 
	 * @param properties An object or dictionary containing the properties to set on the 
	 * particle's image object. The name of the properties on this object must match the
	 * names of the properties on the particle's image object.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( properties : Dynamic )
	{
		super();
		_priority = -10;
		_properties = properties;
	}
	
	/**
	 * An object or dictionary containing the properties to set on the particle's image 
	 * object. The name of the properties on this object must match the names of the 
	 * properties on the particle's image object.
	 */
	private function get_properties():Dynamic
	{
		return _properties;
	}
	private function set_properties( value:Dynamic ):Dynamic
	{
		_properties = value;
		return _properties;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		if( particle.image == null )
		{
			throw new haxe.Exception("Attempting to set image properties when no image is set" );
		}
        // TODO: YUK!! - rethink this!
		var img:Dynamic = particle.image;
		for( name in Reflect.fields(_properties) )
		{
			//if( img.hasOwnProperty( name ) )
			if( Reflect.hasField(img, name) )
			{
				//img[name] = _properties[name];
				Reflect.setField(img, name, Reflect.field(_properties, name));
			}
		}
	}
}
