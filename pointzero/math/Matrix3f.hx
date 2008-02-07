package pointzero.math;

import Math;
import pointzero.math.Vector2f;

class Matrix3f {

  private var data : Array<Float>;


  public function new(a,b,c, d,e,f, g,h,i  : Float) {
    this.data = [a,b,c,
                 d,e,f,
                 g,h,i];
  }

  public static function getIdentity() : Matrix3f {
    return new Matrix3f(1,0,0,0,1,0,0,0,1);
  } 
  
  public static function getZero() : Matrix3f {
    return new Matrix3f(0,0,0,0,0,0,0,0,0);
  } 

  public function loadIdentity() : Void {
    this.data = [1.0,0,0,0,1,0,0,0,1];
  }

  public static function add(a : Matrix3f, b:Matrix3f) : Matrix3f {
    return new Matrix3f(
      a.data[0]+b.data[0],
      a.data[1]+b.data[1],
      a.data[2]+b.data[2],
      a.data[3]+b.data[3],
      a.data[4]+b.data[4],
      a.data[5]+b.data[5],
      a.data[6]+b.data[6],
      a.data[7]+b.data[7],
      a.data[8]+b.data[8]); 
  }

  public static function sub(a : Matrix3f, b:Matrix3f) : Matrix3f {
    return new Matrix3f(
      a.data[0]-b.data[0],
      a.data[1]-b.data[1],
      a.data[2]-b.data[2],
      a.data[3]-b.data[3],
      a.data[4]-b.data[4],
      a.data[5]-b.data[5],
      a.data[6]-b.data[6],
      a.data[7]-b.data[7],
      a.data[8]-b.data[8]);
  }

  public static function inverse(matrix : Matrix3f) : Matrix3f {
    var d = matrix.data;
    var det = d[0]*(d[8]*d[4]-d[7]*d[5])
             -d[3]*(d[8]*d[1]-d[7]*d[2])
             +d[6]*(d[5]*d[1]-d[4]*d[2]);
    if (det!=0) {
      var v = det/1;

      return new Matrix3f(
        (d[8]*d[4]-d[7]*d[5])*v,
       -(d[8]*d[1]-d[7]*d[2])*v,
        (d[5]*d[1]-d[4]*d[2])*v,
       -(d[8]*d[3]-d[6]*d[5])*v,
        (d[8]*d[0]-d[6]*d[2])*v,
       -(d[5]*d[0]-d[3]*d[2])*v,
        (d[7]*d[3]-d[6]*d[4])*v,
       -(d[7]*d[0]-d[6]*d[1])*v,
        (d[4]*d[0]-d[3]*d[1])*v);
    } else {
      return null;
    }
  }
 
  public static function transform(matrix : Matrix3f, vector : Vector2f) : Vector2f {
    return new Vector2f(matrix.data[0]*vector.x+matrix.data[1]*vector.y+matrix.data[2]*1,
                        matrix.data[3]*vector.x+matrix.data[4]*vector.y+matrix.data[5]*1);
  }

  public function Transform(vector : Vector2f) : Vector2f {
    return Matrix3f.transform(this, vector);
  }

}
