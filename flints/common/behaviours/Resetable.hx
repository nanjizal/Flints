package flints.common.behaviours;

import flints.common.behaviours.Resetable;
/**
 * This interface is for behaviours whose state changes over time. It enables
 * them to be reset to their original state.
 */
interface Resetable 
{
	/**
	 * Resets the behaviours state to its original condition.
	 */
	function reset():Void;
}
