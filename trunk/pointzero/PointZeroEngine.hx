package pointzero;

import pointzero.util.List;
import pointzero.contact.Contact;
import pointzero.contact.ContactResolver;
import pointzero.contact.ContactGenerator;
import pointzero.RigidBody;

class PointZeroEngine {
  
  private var maxContacts : Int;
  private var iterations : Int;

  private var bodies : List<RigidBody>;
  private var contacts : List<Contact>;
  private var contactGenerators : List<ContactGenerator>;

  private var contactResolver : ContactResolver;

  public function new(maxContacts : Int, iterations : Int) {
    this.iterations = iterations;
    this.maxContacts = maxContacts;
    this.bodies = new List<RigidBody>();
    this.contacts = new List<Contact>();
    this.contactGenerators = new List<ContactGenerator>();
    this.contactResolver = new ContactResolver(0);
  }

  public function beginFrame() : Void {
    for (body in this.bodies.getIterator()) {
      body.clearAccumulators();
      body.calcDerviedData();
    }
  }

  public function runFrame(duration : Float) : Void {
    for (body in this.bodies.getIterator()) {
      body.integrate(duration);
    }
    var contacts = generateContacts();
    this.contactResolver.setIterations(this.iterations*4);
    this.contactResolver.resolveContacts();
  }

  private function generateContacts() : Int {
    var counter = this.maxContacts;
    for (generator in this.contactGenerators.getIterator()) {
      //generator.addContact(
    }
    return -1;
  }

  
}
