package pointzero;

import pointzero.math.Vector2f;
import pointzero.Particle;
import pointzero.ParticleForceGenerator;

// Use this if the spring is stiff.
class ParticleFakeSpring implements ParticleForceGenerator {
  
  private var anchor          : Vector2f;
  private var springConstant  : Float;
  private var damping         : Float;

  public function new(anchor : Vector2f, springConstant : Float, damping : Float) {
    this.anchor = anchor;
    this.springConstant = springConstant;
    this.damping = damping;
  }

  public function updateForce(particle : Particle, duration : Float) : Void { 
    if (particle.hasFiniteMass()) {
      // calc the constants
      var vector = Vector2f.sub(particle.getPosition(), this.anchor);
      var gamma = 0.5*Math.sqrt(4*this.springConstant - this.damping*this.damping);
      if (gamma!=0) {
        // calc target position
        var c = Vector2f.add(
          Vector2f.multiply(vector, this.damping / (2*gamma)),
          Vector2f.multiply(particle.getVelocity(), 1/gamma));

        var target = Vector2f.add(
          Vector2f.multiply(vector, Math.cos(gamma*duration)),
          Vector2f.multiply(c, Math.sin(gamma*duration)));
        target.Multiply(Math.exp(-0.5*duration*damping));

        var acceleration = Vector2f.sub(
          Vector2f.multiply(Vector2f.sub(target,vector), 1/(duration*duration)),
          Vector2f.multiply(particle.getVelocity(), duration));
        acceleration.Multiply(particle.getMass());

        particle.addForce(acceleration);

      } else {
        return;
      }
    } else {
      return;
    }
  }

}
