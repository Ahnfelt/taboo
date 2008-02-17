package pointzero;

import pointzero.math.Vector2f;
import pointzero.Particle;
import pointzero.ParticleForceGenerator;

class ParticleBungee implements ParticleForceGenerator {
  
  private var other           : Particle;
  private var springConstant  : Float;
  private var restlength      : Float;

  public function new(otherParticle : Particle, springConstant : Float, restlength : Float) {
    this.other = otherParticle;
    this.springConstant = springConstant;
    this.restlength = restlength;
  }

  public function updateForce(particle : Particle, duration : Float) : Void { 
    var force = Vector2f.sub(particle.getPosition(), this.other.getPosition());
    
    var magnitude = force.Magnitude();
    if (magnitude > this.restlength) {
      magnitude *= this.springConstant;
      force.Normalize();
      force.Multiply(-magnitude);
      particle.addForce(force);
    } else {
      return;
    }
  }
}
