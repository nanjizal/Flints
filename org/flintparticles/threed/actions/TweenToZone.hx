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
import org.flintparticles.common.particles.Particle;
import org.flintparticles.common.actions.ActionBase;
import org.flintparticles.common.emitters.Emitter;
import org.flintparticles.threed.particles.Particle3D;
import org.flintparticles.threed.zones.Zone3D;

/**
 * The TweenToZone action adjusts the particle's position between two
 * locations as it ages. The start location is wherever the particle starts
 * from, depending on the emitter and the initializers. The end position is
 * a random point within the specified zone. The current position is relative 
 * to the particle's energy,
 * which changes as the particle ages in accordance with the energy easing
 * function used. This action should be used in conjunction with the Age action.
 */
class TweenToZone extends ActionBase
{
	public var zone(get, set):Zone3D;
	
	private var _zone:Zone3D;
	
	/**
	 * The constructor creates a TweenToZone action for use by an emitter. 
	 * To add a TweenToZone to all particles created by an emitter, use the
	 * emitter's addAction method.
	 * 
	 * @see org.flintparticles.common.emitters.Emitter#addAction()
	 * 
	 * @param zone The zone for the particle's position when its energy is 0.
	 */
	public function new( zone:Zone3D = null )
	{
		super();
		_zone = zone;
	}
	
	/**
	 * The zone for the particle's position when its energy is 0.
	 */
	private function get_zone():Zone3D
	{
		return _zone;
	}
	private function set_zone( value:Zone3D ):Zone3D
	{
		_zone = value;
		return _zone;
	}
	
	/**
	 * @inheritDoc
	 */
	override public function update( emitter:Emitter, particle:Particle, time:Float ):Void
	{
		var p:Particle3D = cast( particle, Particle3D );
		var data:TweenToZoneData;
		if( ! p.dictionary.exists(this) )
		{
			var pt:Vector3D = _zone.getLocation();
			data = new TweenToZoneData( p.position, pt );
			p.dictionary.set(this,data);
		}
		else
		{
			data = p.dictionary.get(this);
		}
		
		var pos:Vector3D = p.position;
		var diff:Vector3D = data.diff;
		var end:Vector3D = data.end;
		var energy:Float = p.energy;
		pos.x = diff.x * energy + end.x;
		pos.y = diff.y * energy + end.y;
		pos.z = diff.z * energy + end.z;
	}
}

class TweenToZoneData
{
	public var diff:Vector3D;
	public var end:Vector3D;

	public function new( start:Vector3D, end:Vector3D )
	{
		this.diff = start.subtract( end );
		this.end = end.clone();
	}
}
