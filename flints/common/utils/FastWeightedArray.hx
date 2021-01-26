package flints.common.utils;

//import openfl.Vector;
import flints.common.utils.FastWeightedArray;

/**
 * A FastWeightedArray performes the same purpose as a WeightedArray 
 * but this array is optimized to select random items in a large array 
 * much more rapidly. In improving the speed of the array, it is necessary
 * to loose the functionality to remove items from the FastWeightedArray, so
 * the original WeightedArray is also still available.
 * 
 * <p>The FastWeightedArray is a collection of values that are weighted. When 
 * a random value is required from the collection, the value returned
 * is randomly selected based on the weightings.</p>
 * 
 * <p>Due to the nature of a FastWeightedArray, there are no facilities
 * to push, unshift or splice items into the array. All items are 
 * added to the FastWeightedArray using the add method.</p>
 */
class FastWeightedArray
{
	public var length(get, never):Int;
	public var totalRatios(get, never):Float;
	
	private var _values:Array<Pair>;
	private var _totalRatios:Float;
	
	/**
	 * Then constructor function is used to create a FastWeightedArray
	 */
	public function new()
	{
		_values = new Array<Pair>();
		_totalRatios = 0;
	}
	
	/**
	 * Adds a value to the FastWeightedArray.
	 * 
	 * @param value the value to add
	 * @param weight the weighting to place on the item
	 * @return the length of the FastWeightedArray
	 */
	public function add( value:Dynamic, ratio:Float ):Int
	{
		_totalRatios += ratio;
		_values.push( new Pair( _totalRatios, value ) );
		return _values.length;
	}
	
	/**
	 * Empties the FastWeightedArray. After calling this method the FastWeightedArray 
	 * contains no items.
	 */
	public function clear():Void
	{
		_values.length = 0;
		_totalRatios = 0;
	}
	
	/**
	 * The number of items in the FastWeightedArray
	 */
	private function get_length():Int
	{
		return _values.length;
	}
	
	/**
	 * The sum of the weights of all the values.
	 */
	private function get_totalRatios():Float
	{
		return _totalRatios;
	}

	/**
	 * Returns a random value from the FastWeightedArray. The weighting of the values is
	 * used when selcting the random value, so items with a higher weighting are
	 * more likely to be seleted.
	 * 
	 * @return A randomly selected item from the array.
	 */
	public function getRandomValue():Dynamic
	{
		var position:Float = Math.random() * _totalRatios;
		var low:Int = 0;
		var mid:Int;
		var high:Int = _values.length;
		while( low < high )
		{
			mid = Math.floor( ( low + high ) * 0.5 );
			if( _values[ mid ].topWeight < position )
			{
				low = mid + 1;
			}
			else
			{
				high = mid;
			}
		}
		return _values[low].value;
	}
}

class Pair
{
	public var topWeight:Float;
	public var value:Dynamic;

	public function new( topWeight:Float, value:Dynamic )
	{
		this.topWeight = topWeight;
		this.value = value;
	}
}
