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

package flints.twod.actions;

import flints.common.particles.Particle;
import flints.common.actions.ActionBase;
import flints.common.emitters.Emitter;
import flints.twod.emitters.Emitter2D;
import flints.twod.particles.Particle2D;

/**
 * The MinimumDistance action applies an acceleration to the particle to 
 * maintain a minimum distance between it and its neighbours.
 * 
 * <p>This action has a priority of 10, so that it executes 
 * before other actions.</p>
 */
class MinimumDistance extends ActionBase
{
	public var acceleration(get, set):Float;
	public var minimum(get, set):Float;
	
	private var _min:Float;
	private var _acc:Float;
	private var _minSq:Float;
	
	/**
	 * The constructor creates a MinimumDistance action for use by an emitter. 
	 * To add a MinimumDistance to all particles created by an emitter, use 
	 * the emitter's addAction method.
	 * 
	 * @see flints.common.emitters.Emitter#addAction()
	 * 
	 * @param minimum The minimum distance, in pixels, that this action 
	 * maintains between particles.
	 * @param acceleration The acceleration force applied to avoid the 
	 * other particles.
	 */
	public function new( minimum:Float = 0, acceleration:Float = 0 )
	{
		super();
		priority = 10;
		this.minimum = minimum;
		this.acceleration = acceleration;
	}
	
	/**
	 * The minimum distance, in pixels, that this action maintains between 
	 * particles.
	 */
	private function get_minimum():Float
	{
		return _min;
	}
	private function set_minimum( value:Float ):Float
	{
		_min = value;
		_minSq = value * value;
		return _min;
	}
	
	/**
	 * The acceleration force applied to avoid the other particles.
	 */
	private function get_acceleration():Float
	{
		return _acc;
	}
	private function set_acceleration( value:Float ):Float
	{
		_acc = value;
		return _acc;
	}

	/**
	 * Instructs the emitter to produce a sorted particle array for optimizing
	 * the calculations in the update method of this action.
	 * 
	 * @param emitter The emitter this action has been added to.
	 * 
	 * @see flints.common.actions.Action#addedToEmitter()
	 */
	override public function addedToEmitter( emitter:Emitter ) : Void
	{
		cast( emitter,Emitter2D ).spaceSort = true;
	}
	
	/**
	 * Checks for particles closer than the minimum distance to the current 
	 * particle and if any are found applies the acceleration to move the 
	 * particles apart.
	 * 
	 * <p>This method is called by the emitter and need not be called by the 
	 * user.</p>
	 * 
	 * @param emitter The Emitter that created the particle.
	 * @param particle The particle to be updated.
	 * @param time The duration of the frame - used for time based updates.
	 * 
	 * @see flints.common.actions.Action#update()
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle2D = cast( particle,Particle2D );
		var e:Emitter2D = cast( emitter,Emitter2D );
		var particles:Array<Dynamic> = e.particlesArray;
		var other:Particle2D;
		var i:Int;
		var len:Int = particles.length;
		var distanceInv:Float;
		var distanceSq:Float;
		var dx:Float;
		var dy:Float;
		var moveX:Float = 0;
		var moveY:Float = 0;
		var factor:Float;
		//for( i = p.sortID - 1; i >= 0; --i )
		i = p.sortID - 1;
		while( i >= 0 )
		{
			other = particles[i];
			if( ( dx = p.x - other.x ) > _min )
      {
        break;
      }
			dy = p.y - other.y;
			if( dy > _min || dy < -_min )
      {
        --i;
        continue;
      }
			distanceSq = dy * dy + dx * dx;
			if( distanceSq <= _minSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				moveX += dx * distanceInv;
				moveY += dy * distanceInv;
			}
			--i;
		}
		//for( i = p.sortID + 1; i < len; ++i )
		i = p.sortID + 1;
		while( i < len )
		{
			other = particles[i];
			if( ( dx = p.x - other.x ) < -_min )
      {
        break;
      }
			dy = p.y - other.y;
			if( dy > _min || dy < -_min )
      {
        ++i;
        continue;
      }
			distanceSq = dy * dy + dx * dx;
			if( distanceSq <= _minSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				moveX += dx * distanceInv;
				moveY += dy * distanceInv;
			}
			++i;
		}
		if( moveX != 0 || moveY != 0 )
		{
			factor = time * _acc / Math.sqrt( moveX * moveX + moveY * moveY );
			p.velX += factor * moveX;
			p.velY += factor * moveY;
		}
	}
}
