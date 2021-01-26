package flints.twod.renderers;

import openfl.display.Shape;
import openfl.events.Event;
import openfl.geom.Rectangle;
import flints.common.emitters.Emitter;
import flints.common.events.EmitterEvent;
import flints.twod.particles.Particle2D;


/**
 * The BitmapLineRenderer draws particles as continuous lines on a Bitmap display object.
 * This is useful for effects like hair and grass.
 * 
 * <p>The BitmapLineRenderer uses the color and alpha of the particle
 * for the color of the current line segment, and uses the scale of
 * the particle for the line width.</p>
 * 
 * <p>The region of the particle system covered by this bitmap object must be defined
 * in the canvas property of the BitmapLineRenderer. Particles outside this region
 * are not drawn.</p>
 * 
 * <p>The BitmapLineRenderer allows the use of BitmapFilters to modify the appearance
 * of the bitmap.</p>
 * 
 * @see flints.twoD.renderers.FullStagePixelRenderer
 * @see flints.common.emitters.Emitter#runAhead()
 */
class BitmapLineRenderer extends BitmapRenderer
{
	private var _shape:Shape;
	/**
	 * The constructor creates a PixelRenderer. After creation it should be
	 * added to the display list of a DisplayObjectContainer to place it on 
	 * the stage and should be applied to an Emitter using the Emitter's
	 * renderer property.
	 */
	public function new( canvas:Rectangle, smoothing:Bool = false )
	{
		super( canvas, smoothing );
		_clearBetweenFrames = false;
		_shape = new Shape();
	}
	
	/**
	 * Used internally to draw the particles.
	 */
	override private function drawParticle( particle:Particle2D ):Void
	{
		_shape.graphics.clear();
		_shape.graphics.lineStyle( particle.scale, particle.color & 0xFFFFFF, particle.color >>> 24 );
		_shape.graphics.moveTo( particle.previousX -_canvas.x, particle.previousY - _canvas.y );
		_shape.graphics.lineTo( particle.x -_canvas.x, particle.y - _canvas.y );
		_bitmapData.draw( _shape );
	}
	
	override private function emitterUpdated( ev:EmitterEvent ):Void
	{
		renderParticles( cast( ev.target,Emitter ).particlesArray );
	}
	override private function updateParticles( ev:Event ):Void
	{
	}
}
