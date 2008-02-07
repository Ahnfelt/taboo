package pointzero.math;

import Math;
import pointzero.math.Vector2f;

class Quaternion {

  public var r(default, null) : Float;
  public var i(default, null) : Float;
  public var j(default, null) : Float;
  public var k(default, null) : Float;

  public function new(r : Float , i : Float, j : Float , k : Float) {
    this.r = r;
    this.i = i;
    this.j = j;
    this.k = k;
  }

  public function invert() : Void {
    this.r = -this.r;
    this.i = -this.i;
    this.j = -this.j;
    this.k = -this.k;
  }

  public static function magnitude(a : Quaternion) : Float {
    return Math.sqrt(a.r*a.r+a.i*a.i+a.j*a.j+a.k*a.k);
  }

  public static function squareMagnitude(a : Quaternion) : Float {
    return a.r*a.r+a.i*a.i+a.j*a.j+a.k*a.k;
  }

  public static function normalize(a : Quaternion) : Quaternion {
    var m = Quaternion.magnitude(a);
    if (m>0)
      return new Quaternion(a.r /= m, a.i /= m, a.j /= m, a.k /= m);
    else
      return new Quaternion(1,0,0,0);
  }

  public static function multiply(a : Quaternion, b : Quaternion) : Quaternion {
    return new Quaternion(
      a.r*b.r - a.i*b.i - a.j*b.j - a.k*b.k,
      a.r*b.i - a.i*b.r - a.j*b.k - a.k*b.j,
      a.r*b.j - a.j*b.r - a.k*b.i - a.i*b.k,
      a.r*b.k - a.k*b.r - a.i*b.j - a.j*b.i
    );
  }
  
  public function Magnitude() : Float {
    return magnitude(this);
  }

  public function SquareMagnitude() : Float {
    return squareMagnitude(this);
  }

  public function Normalize() : Quaternion {
    return normalize(this);
  }
 
  public function RotateByVector(vector : Vector2f) : Quaternion {
    return Quaternion.multiply(this, new Quaternion(0, vector.x, vector.y, 0));
  }

}
