package flints.common.initializers;

import openfl.display.DisplayObject;
import openfl.filters.BitmapFilter;
import flints.common.particles.Particle;
import flints.common.emitters.Emitter;
import flints.common.initializers.InitializerBase;
import flints.common.initializers.ApplyFilter;

/**
 * The ApplyFilter Initializer applies a filter to the particle's image.
 */
class ApplyFilter extends InitializerBase {
	public var filter(get, set):BitmapFilter;

	private var _filter:BitmapFilter;

	/**
	 * The constructor creates an ApplyFilter initializer for use by
	 * an emitter. To add an ApplyFilter to all particles created by an emitter, use the
	 * emitter's addInitializer method.
	 *
	 * <p>This initializer has a priority of -10 to ensure it occurs after the
	 * image assignment initializers like ImageClass.</p>
	 *
	 * @param filter The filter to apply.
	 *
	 * @see flints.common.emitters.Emitter#addInitializer()
	 */
	public function new(filter:BitmapFilter = null) {
		super();
		priority = -10;
		_filter = filter;
	}

	/**
	 * The filter to apply to each particle's image when it is created.
	 */
	private function get_filter():BitmapFilter {
		return _filter;
	}

	private function set_filter(value:BitmapFilter):BitmapFilter {
		_filter = value;
		return _filter;
	}

	/**
	 * @inheritDoc
	 */
	override public function initialize(emitter:Emitter, particle:Particle):Void {
		if (particle.image != null && Std.is(particle.image, DisplayObject)) {
			var img:DisplayObject = particle.image;
			if (img.filters != null) {
				var filters:Array<BitmapFilter> = img.filters;
				filters.push(_filter);
				img.filters = filters;
			} else {
				img.filters = [_filter];
			}
		}
	}
}
