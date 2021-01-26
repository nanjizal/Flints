package flints.twod.renderers;

import openfl.events.Event;
import flints.common.emitters.Emitter;
import flints.common.events.EmitterEvent;
import flints.common.renderers.SpriteRendererBase;
import flints.twod.particles.Particle2D;


/**
 * The VectorLineRenderer draws particles as continuous lines mapping the 
 * path the particle travels. This is useful for effects like hair and
 * grass.
 * 
 * <p>The VectorLineRenderer uses the color and alpha of the particle
 * for the color of the current line segment, and uses the scale of
 * the particle for the line width.</p>
 * 
 * <p>If you don't want users to see the lines growing, the runAhead 
 * method of the emitter can be used to jump straight to the final image.</p>
 * 
 * @see flints.common.emitters.Emitter#runAhead()
 */
class VectorLineRenderer extends SpriteRendererBase
{
	/**
	 * The constructor creates a VectorLineRenderer. After creation it should
	 * be added to the display list of a DisplayObjectContainer to place it on 
	 * the stage and should be applied to an Emitter using the Emitter's
	 * renderer property.
	 * 
	 * @see flints.twoD.emitters.Emitter#renderer
	 */
	public function new()
	{
		super();
	}
	
	/**
	 * @inheritDoc
	 */
	override private function renderParticles( particles:Array<Dynamic> ):Void
	{
		var particle:Particle2D = null;
		var len:Int = particles.length;
		//for( var i:Int = 0; i < len; ++i )
		for( i in 0 ... len )
		{
			particle = cast( particles[i],Particle2D );
			graphics.lineStyle( particle.scale, particle.color & 0xFFFFFF, particle.color >>> 24 );
			graphics.moveTo( particle.previousX, particle.previousY );
			graphics.lineTo( particle.x, particle.y );
		}
	}

	override private function emitterUpdated( ev:EmitterEvent ):Void
	{
		renderParticles( cast( ev.target,Emitter ).particlesArray );
	}
	override private function updateParticles( ev:Event ):Void
	{
	}
}
