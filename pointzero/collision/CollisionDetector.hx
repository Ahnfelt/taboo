package pointzero.collision;

import pointzero.math.Vector2f;
import pointzero.collision.Shape;
import pointzero.RigidBody;
import pointzero.util.List;

class CollisionDetector {

  private var rigidBodies : List<RigidBody>;

  public function new () {
    this.rigidBodies = new List<RigidBody>();
  }

  public function registerRigidBody(newRigidBody : RigidBody) : Void {
    this.rigidBodies.addLast(newRigidBody);
  }

  public function unregisterRigidBody(newRigidBody : RigidBody) : Void {
    throw "Not implemented";
  }

}
