package pointzero.math;

import Math;

class Matrix2f {

  private var data : Array<Float>;

  public function new(x,y,z,w : Float) {
    this.data = [x,y,z,w];
  }

  public static function getIdentity() : Matrix2f {
    return new Matrix2f(1,0,0,1);
  } 

  public static function getZero() : Matrix2f {
    return new Matrix2f(0,0,0,0);
  }

  public function loadIdentity() : Void {
    this.data = [1.0,0,0,1];
  }

  public static function add(a : Matrix2f, b : Matrix2f) : Matrix2f {
    return new Matrix2f(a.data[0]+b.data[0],
                        a.data[1]+b.data[1],
                        a.data[2]+b.data[2],
                        a.data[3]+b.data[3]); 
  }


  public static function sub(a : Matrix2f, b : Matrix2f) : Matrix2f {
    return new Matrix2f(a.data[0]-b.data[0],
                        a.data[1]-b.data[1],
                        a.data[2]-b.data[2],
                        a.data[3]-b.data[3]); 
  }

  public static function inverse(a : Matrix2f) : Matrix2f {
    var div = a.data[0]*a.data[3]-a.data[1]*a.data[2];
    if (div!=0) {
      var value = 1/div;
      return new Matrix2f(a.data[3]*value, -a.data[1]*value, -a.data[2]*value, a.data[0]*value);
    } else {
      return null;
    }
  }

  

}
