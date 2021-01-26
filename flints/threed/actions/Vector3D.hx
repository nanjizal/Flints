package flints.threed;
// import flints.threed.Vector3D
// Temp minimal implementation of openfl Vector3D
/** 
   { x, y, z }
**/
@:structInit
class Vector3D {
    public var x = 0.; 
    public var y = 0.;
    public var z = 0.; 
    function new( x: Float, y: Float, z: Float ){
        this.x = x; 
        this.y = y;
        this.z = z;
    }
}