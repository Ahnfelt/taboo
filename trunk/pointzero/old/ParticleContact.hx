package pointzero;

import pointzero.math.Vector2f;
import pointzero.Particle;

class ParticleContact {
  
  private var a               : Particle;
  private var b               : Particle;
  private var restitution     : Float;
  private var contactNormal   : Vector2f;

  // Only sndParticle may be null...
  public function new(fstParticle : Particle, sndParticle : Particle, restitution : Float, contactNormal : Vector2f) {
    this.a = fstParticle;
    this.b = sndParticle;
    this.restitution = restitution;
    this.contactNormal = contactNormal;
  }

  private function resolve(duration : Float) : Void {
    resolveVelocity(duration);
  }

  private function calculateSeparatingVelocity() : Float {
    if (this.b==null) {
      var delta = Vector2f.sub(this.a.getVelocity(), this.b.getVelocity());
      return Vector2f.scalarProduct(delta, this.contactNormal);
    } else {
      return Vector2f.scalarProduct(a.getVelocity(), this.contactNormal);
    }
  }

  private function resolveVelocity(duration : Float) : Void {
    var separatingVelocity = calculateSeparatingVelocity();
    if (separatingVelocity <= 0) {
      var newSepVelocity = -separatingVelocity * this.restitution;
      var deltaVelocity = newSepVelocity - separatingVelocity;
      var totalInverseMass = this.a.getInverseMass();
      if (this.b!=null) 
        totalInverseMass += this.b.getInverseMass();
      if (totalInverseMass > 0) {
        var impulse = deltaVelocity / totalInverseMass;
        var impulsePerIMass = Vector2f.multiply(this.contactNormal, impulse);
        // apply impulses
        this.a.setVelocity(
          Vector2f.add(this.a.getVelocity(), Vector2f.multiply(impulsePerIMass, this.a.getInverseMass())));
        if (this.b!=null) {
          this.b.setVelocity(
            Vector2f.add(this.b.getVelocity(), Vector2f.multiply(impulsePerIMass, this.b.getInverseMass())));
        }
      } else {
        // infinant mass
        return;
      }
    } else {
      // no impulse required
      return;
    }
  }

}
