package flints.integration.flare3d.initializers;
	import flints.common.particles.Particle;
	import flints.common.emitters.Emitter;
	import flints.integration.flare3d.initializers.F3DCloneMaterial;
	import flints.common.initializers.InitializerBase;


	/**
	 * @author Richard
	 */
	class F3DCloneMaterial extends InitializerBase
	{
		public var material(get, set):Material3D;
		private var _material : Material3D;

		public function new( material : Material3D )
		{
			_material = material;
			_priority = -10;
		}
		
		public function get_material() : Material3D
		{
			return _material;
		}
		
		public function set_material( value:Material3D ):Material3D
		{
			return _material = material;
		}
		
		override public function initialize( emitter:Emitter, particle:Particle ) : Void
		{
			if( particle.image && particle.image is Pivot3D )
			{
				Pivot3D( particle.image ).setMaterial( _material.clone() );
			}
		}
	}
