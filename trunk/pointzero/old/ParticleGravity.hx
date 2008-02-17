package pointzero;

import pointzero.math.Vector2f;
import pointzero.ParticleForceGenerator;

class ParticleGravity implements ParticleForceGenerator {
    
    private var gravity : Vector2f;

    public function new(gravity : Vector2f) {
      this.gravity = gravity;
    }

    public function updateForce(particle : Particle, duration : Float) : Void {
      if (!particle.hasFiniteMass())  {
        return;
      } else {
        var force = Vector2f.multiply(this.gravity, particle.getMass());
        particle.addForce(force);
      }
    }
}
