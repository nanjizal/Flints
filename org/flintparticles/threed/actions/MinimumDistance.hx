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

package org.flintparticles.threed.actions;

import openfl.geom.Vector3D;
import org.flintparticles.common.emitters.Emitter;
import org.flintparticles.common.particles.Particle;
import org.flintparticles.common.actions.ActionBase;
import org.flintparticles.threed.emitters.Emitter3D;
import org.flintparticles.threed.particles.Particle3D;


/**
 * The MinimumDistance action applies an acceleration to the particle to maintain a minimum
 * distance between it and its neighbours.
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
	
	/*
	 * Temporary variables created as class members to avoid creating new objects all the time
	 */
	private var d:Vector3D;
	private var move:Vector3D;
	
	/**
	 * The constructor creates a ApproachNeighbours action for use by 
	 * an emitter. To add a ApproachNeighbours to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see org.flintparticles.common.emitters.Emitter#addAction()
	 * 
	 * @param minimum The minimum distance, in pixels, that this action maintains between 
	 * particles.
	 * @param acceleration The acceleration force applied to avoid the other particles.
	 */
	public function new( minimum:Float = 0, acceleration:Float = 0 )
	{
		super();
		priority = 10;
		d = new Vector3D();
		move = new Vector3D();
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
	 * @inheritDoc
	 */
	override public function addedToEmitter( emitter:Emitter ) : Void
	{
		cast( emitter, Emitter3D ).spaceSort = true;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var e:Emitter3D = cast( emitter, Emitter3D );
		var particles:Array<Dynamic> = e.particlesArray;
		var other:Particle3D;
		var i:Int;
		var len:Int = particles.length;
		var distanceInv:Float;
		var distanceSq:Float;
		var factor:Float;
		
		move.x = 0;
		move.y = 0;
		move.z = 0;
		
		//for( i = p.sortID - 1; i >= 0; --i )
		var i = p.sortID - 1;
		while( i >= 0 )
		{
			other = particles[i];
			if( ( d.x = p.position.x - other.position.x ) > _min )
      {
        break;
      }
			d.y = p.position.y - other.position.y;
			if( d.y > _min || d.y < -_min )
      {
        --i;
        continue;
      }
			d.z = p.position.z - other.position.z;
			if( d.z > _min || d.z < -_min )
      {
        --i;
        continue;
      }
			distanceSq = d.lengthSquared;
			if( distanceSq <= _minSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				d.scaleBy( distanceInv );
				move.incrementBy( d );
			}
			--i;
		}
		//for( i = p.sortID + 1; i < len; ++i )
		i = p.sortID + 1;
		while( i < len )
		{
			other = particles[i];
			if( ( d.x = p.position.x - other.position.x ) < -_min )
      {
        break;
      }
			d.y = p.position.y - other.position.y;
			if( d.y > _min || d.y < -_min )
      {
        ++i;
        continue;
      }
			d.z = p.position.z - other.position.z;
			if( d.z > _min || d.z < -_min )
      {
        ++i;
        continue;
      }
			distanceSq = d.lengthSquared;
			if( distanceSq <= _minSq && distanceSq > 0 )
			{
				distanceInv = 1 / Math.sqrt( distanceSq );
				d.scaleBy( distanceInv );
				move.incrementBy( d );
			}
			++i;
		}
		if ( move.x != 0 || move.y != 0 || move.z != 0 )
		{
			factor = time * _acc / move.length;
			move.scaleBy( factor );
			p.velocity.incrementBy( move );
		}
	}
}
