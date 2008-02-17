package pointzero;

import pointzero.math.Vector2f;
import Math;

class Particle {
  
  private var position      : Vector2f;
  private var velocity      : Vector2f;
  private var acceleration  : Vector2f;
  private var forceAccum    : Vector2f;
  private var damping       : Float;
  private var inverseMass   : Float;

  public function integrate(duration : Float) {
    // Update linear position
    var deltaMovement = Vector2f.multiply(this.velocity, duration);
    this.position = Vector2f.add(this.position, deltaMovement);

    // Calc acceleration
    var resultingAcc = Vector2f.multiply(this.forceAccum, this.inverseMass);
    
    // Update velocity
    var deltaVelocity = Vector2f.multiply(resultingAcc, duration);
    this.velocity = Vector2f.add(this.velocity, deltaVelocity);

    // Impose drag
    this.velocity = Vector2f.multiply(this.velocity, Math.pow(this.damping, duration));

    // Clear forces
    this.clearAccumulator();
  }
  
  public function clearAccumulator() {
    this.forceAccum = Vector2f.ZERO;
  }

  public function addForce(force : Vector2f) {
    this.forceAccum = Vector2f.add(this.forceAccum, force);
  }

  public function hasFiniteMass() : Bool {
    return this.inverseMass!=0;
  }

  public function getMass() : Float {
    if (this.inverseMass!=0) {
      return 1/this.inverseMass;
    } else {
      throw "Particle's mass is not finite!";
    }
  }

  public function getInverseMass() : Float {
    return this.inverseMass;
  }

  public function getPosition() : Vector2f {
    return this.position;
  }

  public function getVelocity() : Vector2f {
    return this.velocity;
  }

  public function getAcceleration() : Vector2f {
    return this.acceleration;
  }

  public function setVelocity(newVelocity : Vector2f) : Void {
    this.velocity = newVelocity;
  }

}

