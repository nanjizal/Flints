package flints.common.renderers;

import flints.common.emitters.Emitter;
import flints.common.renderers.Renderer;

/**
 * The Renderer interface must be implemented by all renderers. A renderer 
 * is a class that draws the particles that are managed by an emitter. A 
 * renderer can display the contents of a number of emitters.
 */
interface Renderer
{
	/**
	 * Add an emitter to this renderer. The renderer should draw all the 
	 * particles that are being managed by the emitter.
	 * 
	 * @param emitter The emitter whose particles should be drawn by the 
	 * renderer
	 */
	function addEmitter( emitter : Emitter ) : Void;

	/**
	 * Stop rendering particles that are managed by this emitter.
	 * 
	 * @param emitter The emitter whose particles should no longer be
	 * drawn by the renderer.
	 */
	function removeEmitter( emitter : Emitter ) : Void;
}
