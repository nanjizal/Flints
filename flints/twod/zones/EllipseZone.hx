package flints.twod.zones;

import openfl.geom.Point;
import flints.twod.particles.Particle2D;

/**
	 * The EllipseZone zone defines a elliptical zone.
	 * NOTE :: it has not been written to support collision.
	 */
class EllipseZone implements Zone2D {
    public var center(get, set) : Point;
    public var centerX(get, set) : Float;
    public var centerY(get, set) : Float;
    public var xRadius(get, set) : Float;
    public var yRadius(get, set) : Float;

    private var _center : Point;
    private var _xRadius : Float;
    private var _yRadius : Float;
    
    private static var TWOPI : Float = Math.PI * 2;
    
    /**
		 * The constructor defines a OvalZone zone.
		 * 
		 * @param center The centre of the disc.
		 * @param outerRadius The radius of the outer edge of the disc.
		 * @param innerRadius If set, this defines the radius of the inner
		 * edge of the disc. Points closer to the center than this inner radius
		 * are excluded from the zone. If this parameter is not set then all 
		 * points inside the outer radius are included in the zone.
		 */
    public function new(center : Point = null, xRadius : Float = 0, yRadius : Float = 0) {
        if (center == null) {
            _center = new Point(0, 0);
        }
        else {
            _center = center;
        }
        _xRadius = xRadius;
        _yRadius = yRadius;
    }
    
    /**
		 * The centre of the disc.
		 */
    private function get_center() : Point {
        return _center;
    }
    
    private function set_center(value : Point) : Point {
        _center = value;
        return value;
    }
    
    /**
		 * The x coordinate of the point that is the center of the disc.
		 */
    private function get_centerX() : Float {
        return _center.x;
    }
    
    private function set_centerX(value : Float) : Float {
        _center.x = value;
        return value;
    }
    
    /**
		 * The y coordinate of the point that is the center of the disc.
		 */
    private function get_centerY() : Float {
        return _center.y;
    }
    
    private function set_centerY(value : Float) : Float {
        _center.y = value;
        return value;
    }
    
    /**
		 * The radius of the inner edge of the disc.
		 */
    private function get_xRadius() : Float {
        return _xRadius;
    }
    
    private function set_xRadius(value : Float) : Float {
        _xRadius = value;
        return value;
    }
    
    /**
		 * The radius of the outer edge of the disc.
		 */
    private function get_yRadius() : Float {
        return _yRadius;
    }
    
    private function set_yRadius(value : Float) : Float {
        _yRadius = value;
        return value;
    }
    
    /**
		 * The contains method determines whether a point is inside the zone.
		 * This method is used by the initializers and actions that
		 * use the zone. Usually, it need not be called directly by the user.
		 * 
		 * @param x The x coordinate of the location to test for.
		 * @param y The y coordinate of the location to test for.
		 * @return true if point is inside the zone, false if it is outside.
		 */
    public function contains(x : Float, y : Float) : Bool {
    // delete   vv   those 2 back slashes to comment out what i have done
        
        ///*// was not working, so I reworked it the way I thought it should work
        var point : Point = new Point(x, y);
        var distance : Float = Point.distance(point, _center);
        var direction : Float = Math.atan2(point.y - _center.y, point.x - _center.x);
        
        var xDistance : Float = Math.abs(Math.cos(direction) * distance);
        var yDistance : Float = Math.abs(Math.sin(direction) * distance);
        
        if (xDistance > xRadius || yDistance > _yRadius) {
            return false;
        }
        
        return true;
        //*/
        x -= Math.abs(x - _center.x);
        y -= Math.abs(y - _center.y);
        return ((x <= _xRadius) && (y <= _yRadius));
    }
    
    /**
		 * The getLocation method returns a random point inside the zone.
		 * This method is used by the initializers and actions that
		 * use the zone. Usually, it need not be called directly by the user.
		 * 
		 * @return a random point inside the zone.
		 */
    public function getLocation() : Point {
        var angle : Float = Math.random() * TWOPI;
        var point : Point = new Point();
        point.x = Math.cos(angle) * (Math.sqrt(Math.random()) * _xRadius) + _center.x;
        point.y = Math.sin(angle) * (Math.sqrt(Math.random()) * _yRadius) + _center.y;
        return point;
    }
    
    /**
		 * The getArea method returns the size of the zone.
		 * This method is used by the MultiZone class. Usually, 
		 * it need not be called directly by the user.
		 * 
		 * @return a random point inside the zone.
		 */
    public function getArea() : Float {
        return Math.PI * (_xRadius * _yRadius);
    }
    
    /**
		 * NOTE :: This method does not work yet. -bard
		 * Manages collisions between a particle and the zone. The particle will collide with the edges of
		 * the disc defined for this zone, from inside or outside the disc.  The collisionRadius of the 
		 * particle is used when calculating the collision.
		 * 
		 * @param particle The particle to be tested for collision with the zone.
		 * @param bounce The coefficient of restitution for the collision.
		 * 
		 * @return Whether a collision occured.
		 */
    public function collideParticle(particle : Particle2D, bounce : Float = 1) : Bool {
        return false;
    }
}

