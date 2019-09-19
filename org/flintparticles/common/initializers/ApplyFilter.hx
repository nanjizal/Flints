/*
 * FLINT PARTICLE SYSTEM
 * .....................
 *
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2011
 * http://flintparticles.org
 *
 *
 * Licence Agreement
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.flintparticles.common.initializers;

import openfl.display.DisplayObject;
import openfl.filters.BitmapFilter;
import org.flintparticles.common.particles.Particle;
import org.flintparticles.common.emitters.Emitter;
import org.flintparticles.common.initializers.InitializerBase;
import org.flintparticles.common.initializers.ApplyFilter;

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
	 * @see org.flintparticles.common.emitters.Emitter#addInitializer()
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
