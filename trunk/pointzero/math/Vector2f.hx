package pointzero.math;

import Math;

class Vector2f {

  private var x : Float;
  private var y : Float;

  public static var UP    : Vector2f = new Vector2f(0,1);
  public static var DOWN  : Vector2f = new Vector2f(0,-1);
  public static var RIGHT : Vector2f = new Vector2f(1,0);
  public static var LEFT  : Vector2f = new Vector2f(-1,0);
  public static var ZERO  : Vector2f = new Vector2f(0,0);

  public function new(x : Float, y : Float) {
    this.x = x;
    this.y = y;
  }

  public function invert() : Void {
    this.x = -this.x;
    this.y = -this.y;
  }

  public static function magnitude(a : Vector2f) : Float {
    return Math.sqrt(a.x*a.x+a.y*a.y);
  }

  public static function squareMagnitude(a : Vector2f) : Float {
    return a.x*a.x+a.y*a.y;
  }

  public static function normalize(a :Vector2f) : Vector2f {
    var m = magnitude(a);
    if (m>0)
      return new Vector2f(a.x /= m, a.y /= m);
    else
      return new Vector2f(0,0);
  }

  public static function multiply(a : Vector2f, f : Float) : Vector2f {
    return new Vector2f(a.x *= f, a.y *= f); 
  }

  public static function add(a : Vector2f, b : Vector2f) : Vector2f {
    return new Vector2f(a.x+b.x, a.y+b.y);
  }

  public static function sub(a : Vector2f, b : Vector2f) : Vector2f {
    return new Vector2f(a.x-b.x, a.y-b.y);
  }

  public static function component(a : Vector2f) : Vector2f {
    return new Vector2f(a.y, -a.x);
  }

  public static function scalarProduct(a : Vector2f, b : Vector2f) : Float { 
    return a.x*b.x+a.y*b.y;
  }

  public function Magnitude() : Float {
    return magnitude(this);
  }

  public function SquareMagnitude() : Float {
    return squareMagnitude(this);
  }

  public function Normalize() : Vector2f {
    return normalize(this);
  }
  
  public function Multiply(f : Float) : Vector2f {
    return multiply(this, f);
  }

  public function Component() : Vector2f {
    return component(this);
  }

  public function getX() : Float {
    return this.x;
  }

  public function getY() : Float {
    return this.y;
  }

  public function setX(newX : Float) : Void {
    this.x = newX;
  }
  
  public function setY(newY : Float) : Void {
    this.y = newY;
  }

}
