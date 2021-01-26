package flints.twod.particles;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Vector;
import flints.common.particles.Particle;
import flints.common.particles.ParticleFactory;
import flints.common.utils.DisplayObjectUtils;
import flints.common.utils.Maths;


/**
 * Utility methods for working with two-d particles.
 */
class Particle2DUtils 
{
	/**
	 * Adds existing display objects as particles to the emitter. This allows you, for example, 
	 * to take an existing image and subject it to the actions of the emitter.
	 * 
	 * <p>This method moves all the display objects into the emitter's renderer,
	 * removing them from their current position within the display list. It will
	 * only work if a renderer has been defined for the emitter and the renderer has
	 * been added to the display list.</p>
	 * 
	 * @param renderer The display object whose coordinate system the display object's position
	 * is converted to. This is usually the renderer for the particle system created by the emitter.
	 * @param objects Each parameter is another display object for adding to the emitter.
	 * If you pass an array as the parameter, each item in the array should be another
	 * display object for adding to the emitter.
	 */
	public static function createParticles2DFromDisplayObjects( displayObjects:Array<Dynamic>, renderer:DisplayObject = null, factory:ParticleFactory = null ):Vector<Particle>
	{
		var particles:Vector<Particle> = new Vector<Particle>();
		//for( var i:Float = 0; i < displayObjects.length; ++i )
		for( i in 0 ... displayObjects.length )
		{
			particles.push( createParticle2DFromDisplayObject( displayObjects[i], renderer, factory ) );
		}
		return particles;
	}
	
	/*
	 * Used internally to add an individual display object to the emitter
	 */
	public static function createParticle2DFromDisplayObject( obj:DisplayObject, renderer:DisplayObject = null, factory:ParticleFactory = null ):Particle2D
	{
		var particle:Particle2D;
		if( factory != null )
		{
			particle = cast( factory.createParticle(),Particle2D );
		}
		else
		{
			particle = new Particle2D();
		}
		if ( obj.parent != null && renderer != null )
		{
			var p : Point = renderer.globalToLocal( obj.localToGlobal( new Point( 0, 0 ) ) );
			particle.x = p.x;
			particle.y = p.y;
			var r : Float = DisplayObjectUtils.globalToLocalRotation( renderer, DisplayObjectUtils.localToGlobalRotation( obj, 0 ) );
			particle.rotation = Maths.asRadians( r );
			obj.parent.removeChild( obj );
		}
		else
		{
			particle.x = obj.x;
			particle.y = obj.y;
			particle.rotation = Maths.asRadians( obj.rotation );
		}
		particle.image = obj;
		var rad:Float = ( obj.width + obj.height ) / 4;
		if( rad != 0 )
		{
			particle.collisionRadius = rad;
		}
		return particle;
	}

	public static function createPixelParticlesFromBitmapData( bitmapData:BitmapData, factory:ParticleFactory = null, offsetX:Float = 0, offsetY:Float = 0 ):Vector<Particle>
	{
		var particles:Vector<Particle> = new Vector<Particle>();
		var width:Int = bitmapData.width;
		var height:Int = bitmapData.height;
		var y:Int;
		var x:Int;
		var p:Particle2D;
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
						p = cast( factory.createParticle(),Particle2D );
						p.x = x + offsetX;
						p.y = y + offsetY;
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
						p = new Particle2D();
						p.x = x + offsetX;
						p.y = y + offsetY;
						p.color = color;
						particles.push( p );
					}
				}
			}
		}
		return particles;
	}
	
	public static function createRectangleParticlesFromBitmapData( bitmapData:BitmapData, size:Int, factory:ParticleFactory = null, offsetX:Float = 0, offsetY:Float = 0 ):Vector<Particle>
	{
		var particles:Vector<Particle> = new Vector<Particle>();
		var width:Int = bitmapData.width;
		var height:Int = bitmapData.height;
		var y:Int;
		var x:Int;
		var halfSize:Float = size * 0.5;
		offsetX += halfSize;
		offsetY += halfSize;
		var p:Particle2D;
		var b:BitmapData;
		var m:Bitmap;
		var s:Sprite;
		var zero:Point = new Point( 0, 0 );
		if( factory != null )
		{
			//for( y = 0; y < height; y += size )
			y = 0;
			while( y < height )
			{
				//for( x = 0; x < width; x += size )
				x = 0;
				while( x < width )
				{
					p = cast( factory.createParticle(),Particle2D );
					p.x = x + offsetX;
					p.y = y + offsetY;
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
					p = new Particle2D();
					p.x = x + offsetX;
					p.y = y + offsetY;
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
