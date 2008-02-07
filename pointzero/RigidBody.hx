package pointzero;

import pointzero.math.Vector2f;
import pointzero.math.Matrix2f;
import pointzero.math.Matrix3f;
import Math;

class RigidBody {
  
  // Linear forces
  private var position : Vector2f;
  private var linearVelocity : Vector2f;
  private var linearAcceleration : Vector2f;
  private var linearForceAccum : Vector2f;
  private var linearDamping : Float;

  // Angular forces
  private var rotation  : Vector2f;
  private var torqueVelocity : Vector2f;
  private var torqueAcceleration : Vector2f;
  private var torqueAccum : Vector2f;
  private var torqueDamping : Float;

  // Body data
  private var inverseMass   : Float;
  private var inverseInertiaTensor : Matrix2f;


  // Dervied data
  private var transformMatrix : Matrix3f;
  private var inverseTransformMatrix : Matrix2f;
  private var inverseInertiaTensorWorld : Matrix3f;

  // Aux data
  private var isAwake : Bool;
  private var canSleep : Bool;
  private var motion : Float;
  private var lastFrameAcceleration : Vector2f;
 
  private function calcDerviedData() {
    return 0;
  }

  private function calcTransformMatrix() {
    return 0;
  }

  private function getPointInWorldSpace(point : Vector2f) : Vector2f {
    return new Vector2f(0,0);
  }

  public function setInertiaTensor(inertiaTensor : Matrix2f) : Void {
    this.inverseInertiaTensor = Matrix2f.inverse(inertiaTensor);
  }

  public function integrate(duration : Float) {

    // Update linear and angular accleration
    this.lastFrameAcceleration = Vector2f.add(this.linearAcceleration, Vector2f.multiply(this.linearForceAccum, this.inverseMass));
    this.torqueAcceleration = this.inverseInertiaTensorWorld.Transform(this.torqueAccum);

    // Update linear and angularvelocity
    var deltaLinearVelocity = Vector2f.multiply(this.lastFrameAcceleration, duration);
    this.linearVelocity = Vector2f.add(this.linearVelocity, deltaLinearVelocity);
    var deltaTorqueVelocity = Vector2f.multiply(this.torqueAcceleration, duration);
    this.torqueVelocity = Vector2f.add(this.torqueVelocity, deltaTorqueVelocity);

    // Apply drag
    this.linearVelocity.Multiply(Math.pow(this.linearDamping, duration));
    this.torqueVelocity.Multiply(Math.pow(this.torqueDamping, duration));
    

    // Update linear position
    var deltaMovement = Vector2f.multiply(this.linearVelocity, duration);
    this.position = Vector2f.add(this.position, deltaMovement);
    
    this.calcDerviedData();

    this.clearAccumulators();
  }
  
  public function clearAccumulators() : Void {
    this.linearForceAccum = Vector2f.ZERO;
    this.torqueAccum = Vector2f.ZERO;
  }

  public function addForce(force : Vector2f) : Void {
    this.linearForceAccum = Vector2f.add(this.linearForceAccum, force);
  }

  public function addForceAtPoint(point : Vector2f, force : Vector2f) : Void {

  }

  public function addForceAtBodyPoint(point : Vector2f, force : Vector2f) : Void {
    point = getPointInWorldSpace(point);
    addForceAtPoint(point, force);
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
    return this.linearVelocity;
  }

  public function getAcceleration() : Vector2f {
    return this.linearAcceleration;
  }

  public function setVelocity(newVelocity : Vector2f) : Void {
    this.linearVelocity = newVelocity;
  }

}

