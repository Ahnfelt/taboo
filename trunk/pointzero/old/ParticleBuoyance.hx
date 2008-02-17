package pointzero;

import pointzero.math.Vector2f;
import pointzero.Particle;
import pointzero.ParticleForceGenerator;

class ParticleBuoyance implements ParticleForceGenerator {
  
  private var volume        : Float;
  private var maxDepth      : Float;
  private var waterHeight   : Float;
  private var liquidDensity : Float;

  public function new(volume : Float, maxDepth : Float, waterHeight : Float, liquidDensity : Float) {
    this.volume = volume;
    this.maxDepth = maxDepth;
    this.waterHeight = waterHeight;
    this.liquidDensity = liquidDensity;
  }

  public function updateForce(particle : Particle, duration : Float) : Void { 
    var depth = particle.getPosition().getY();
    if (depth > this.waterHeight + this.maxDepth) {
      var force = new Vector2f(0,0);
      if (depth >= this.waterHeight - this.maxDepth) {
        force.setY(this.liquidDensity * this.volume);
        particle.addForce(force);
      } else {
        force.setY(this.liquidDensity * this.volume 
          * (depth - this.maxDepth - waterHeight) / 2 * maxDepth);
        particle.addForce(force);
      }
    } else {
      return;
    }
  }

}
