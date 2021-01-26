package flints.threed.particles;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.geom.Vector3D;
import openfl.Vector;
import flints.common.particles.Particle;
import flints.common.particles.ParticleFactory;

/**
 * Utility methods for working with three-d particles.
 */
class Particle3DUtils 
{
	public static function createPixelParticlesFromBitmapData( bitmapData:BitmapData, factory:ParticleFactory = null, offset:Vector3D = null ):Vector<Particle>
	{
		if( offset == null )
		{
			offset = new Vector3D( 0, 0, 0, 1 );
		}
		var particles:Vector<Particle> = new Vector<Particle>();
		var width:Int = bitmapData.width;
		var height:Int = bitmapData.height;
		var y:Int;
		var x:Int;
		var p:Particle3D;
		var color:Int;
		if( factory != null )
		{
			for (y in 0...height) 
			{
				for (x in 0...width) 
				{
					color = bitmapData.getPixel32( x, y );
					if( color >>> 24 > 0 )
					{
						p = cast( factory.createParticle(), Particle3D );
						p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
						p.color = color;
						particles.push( p );
					}
				}
			}
		}
		else
		{
			for (y in 0...height) 
			{
				for (x in 0...width) 
				{
					color = bitmapData.getPixel32( x, y );
					if( color >>> 24 > 0 )
					{
						p = new Particle3D();
						p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
						p.color = color;
						particles.push( p );
					}
				}
			}
		}
		return particles;
	}
	
	public static function createRectangleParticlesFromBitmapData( bitmapData:BitmapData, size:Int, factory:ParticleFactory = null, offset:Vector3D = null ):Vector<Particle>
	{
		if( offset == null )
		{
			offset = new Vector3D( 0, 0, 0, 1 );
		}
		var particles:Vector<Particle> = new Vector<Particle>();
		var width:Int = bitmapData.width;
		var height:Int = bitmapData.height;
		var y:Int;
		var x:Int;
		var halfSize:Float = size * 0.5;
		offset.x += halfSize;
		offset.y += halfSize;
		var p:Particle3D;
		var b:BitmapData;
		var m:Bitmap;
		var s:Sprite;
		var zero:Point = new Point( 0, 0 );
		if( factory != null )
		{
			//for( y = 0; y < height; y += size )
			var y = 0;
			while( y < height )
			{
				//for( x = 0; x < width; x += size )
				var x = 0;
				while( x < width )
				{
					p = cast( factory.createParticle(), Particle3D );
					p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
					b = new BitmapData( size, size, true, 0 );
					b.copyPixels( bitmapData, new Rectangle( x, y, size, size ), zero );
					m = new Bitmap( b );
					m.x = -halfSize;
					m.y = -halfSize;
					s = new Sprite();
					s.addChild( m );
					p.image = s;
					p.collisionRadius = halfSize;
					particles.push( p );
					x += size;
				}
				 y += size;
			}
		}
		else
		{
			for (y in 0...height) 
			{
				for (x in 0...width) 
				{
					p = new Particle3D();
					p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
					b = new BitmapData( size, size, true, 0 );
					b.copyPixels( bitmapData, new Rectangle( x, y, size, size ), zero );
					m = new Bitmap( b );
					m.x = -halfSize;
					m.y = -halfSize;
					s = new Sprite();
					s.addChild( m );
					p.image = s;
					p.collisionRadius = halfSize;
					particles.push( p );
				}
			}
		}
		return particles;
	}
}
