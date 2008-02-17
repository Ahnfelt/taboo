package pointzero;

import pointzero.Particle;

interface ParticleForceGenerator {
  
 function updateForce(particle : Particle, duration : Float) : Void;

}
