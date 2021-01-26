package flints.common.initializers;

import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.DictionaryInitializer;

/**
 * The Dictionary Initializer copies properties from an initializing object to a particle's dictionary.
 */
class DictionaryInitializer extends InitializerBase 
{
	public var initValues(get, set):Dynamic;
	private var _initValues:Dynamic;
	
	/**
	 * The constructor creates a DictionaryInit initializer for use by 
	 * an emitter. To add a DictionaryInit to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 * 
	 * @param initValues The object containing the properties for copying to the particle's dictionary.
	 * May be an object or a dictionary.
	 * 
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new( initValues:Dynamic )
	{
		super();
		_initValues = initValues;
	}
	
	/**
	 * The object containing the properties for copying to the particle's dictionary.
	 * May be an object or a dictionary.
	 */
	private function get_initValues():Dynamic
	{
		return _initValues;
	}
	private function set_initValues( value:Dynamic ):Dynamic
	{
		_initValues = value;
		return _initValues;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize( emitter:Emitter, particle:Particle ):Void
	{
		if ( _initValues == null )
		{
			return;
		}
		for( key in Reflect.fields(_initValues) )
		{
			//particle.dictionary[ key ] = _initValues[ key ];
			particle.dictionary.set(key, Reflect.field(_initValues, key));
		}
	}
}
