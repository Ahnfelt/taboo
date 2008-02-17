package pointzero;

import pointzero.List;
import pointzero.RigidBody;

class PointZeroEngine {
  
  private var maxContacts : Int;
  private var iterations : Int;
  private var bodies : List<RigidBody>;

  public function new(maxContacts, iterations) {
    this.iterations = iterations;
    this.maxContacts = maxContacts;
    this.bodies = new List<RigidBody>();
  }

  public function beginFrame() : Void {
    
  }

  public function runFrame(duration : Float) : Void {

  }

  public function generateContacts() : Int {
    return -1;
  }

  
}
