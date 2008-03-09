package pointzero.collision;

import pointzero.math.Vector2f;

enum Shape {
  Circle ( center : Vector2f, radius : Float);
  Box ( center : Vector2f, corner: Vector2f);  
}
