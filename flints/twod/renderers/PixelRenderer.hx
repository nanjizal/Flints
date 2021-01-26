package flints.twod.renderers;

import openfl.geom.Rectangle;
import flints.twod.particles.Particle2D;

/**
 * The PixelRenderer draws particles as single pixels on a Bitmap display object. The
 * region of the particle system covered by this bitmap object must be defined
 * in the canvas property of the PixelRenderer. Particles outside this region
 * are not drawn.
 * 
 * <p>The PixelRenderer allows the use of BitmapFilters to modify the appearance
 * of the bitmap. Every frame, under normal circumstances, the Bitmap used to
 * display the particles is wiped clean before all the particles are redrawn.
 * However, if one or more filters are added to the renderer, the filters are
 * applied to the bitmap instead of wiping it clean. This enables various trail
 * effects by using blur and other filters. You can also disable the clearing
 * of the particles by setting the clearBetweenFrames property to false.</p>
 * 
 * <p>The PixelRenderer has mouse events disabled for itself and any 
 * display objects in its display list. To enable mouse events for the renderer
 * or its children set the mouseEnabled or mouseChildren properties to true.</p>
 */
class PixelRenderer extends BitmapRenderer
{
	/**
	 * The constructor creates a PixelRenderer. After creation it should be
	 * added to the display list of a DisplayObjectContainer to place it on 
	 * the stage and should be applied to an Emitter using the Emitter's
	 * renderer property.
	 */
	public function new( canvas:Rectangle )
	{
		super( canvas );
	}
	
	/**
	 * Used internally to draw the particles.
	 */
	override private function drawParticle( particle:Particle2D ):Void
	{
		_bitmapData.setPixel32( Math.round( particle.x - _canvas.x ), Math.round( particle.y - _canvas.y ), particle.color );
	}
}
