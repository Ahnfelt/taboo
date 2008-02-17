package pointzero;


class ParticleForceRegistration {
  public var particle : Particle;
  public var particleForceGenerator : ParticleForceGenerator;

  public function new(particle : Particle, particleForceGenerator : ParticleForceGenerator) {
    this.particle = particle;
    this.particleForceGenerator = particleForceGenerator;
  }
}

class ParticleForceRegistry {  
  
  private var registrations : List<ParticleForceRegistration>;

  public function new() {
    this.registrations = new List<ParticleForceRegistration>();
  }

  public function add(particle : Particle, particleForceGenerator : ParticleForceGenerator) : Void {
    var item = new ParticleForceRegistration(particle, particleForceGenerator);
    this.registrations.add(item);
  }

  public function remove(particle : Particle, particleForceGenerator : ParticleForceGenerator) : Void {
    for (item in this.registrations) {
      if (item.particle == particle
          && item.particleForceGenerator == particleForceGenerator) {
        this.registrations.remove(item);
        return;
      }
    }
  }

  public function clear() : Void {
    this.registrations.clear();
  }

  public function updateForces(duration : Float) {
    for (item in this.registrations) {
      item.particleForceGenerator.updateForce(item.particle, duration);
    }
  }
}
