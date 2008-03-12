package pointzero.collision;

import pointzero.math.Vector2f;
import pointzero.collision.Shape;
import pointzero.contact.Contact;
import pointzero.collision.CollisionObject;
import pointzero.util.List;

class CollisionDetector {

  private var objects : List<CollisionObject>;

  public function new () {
    this.objects = new List<CollisionObject>();
  }

  public function registerRigidBody(newObject : CollisionObject) : Void {
    this.objects.addLast(newObject);
  }

  public function unregisterRigidBody(object : CollisionObject) : Void {
    this.objects.remove(object);
  }

  public function detect() : List<Contact> {
    var contacts = new List<Contact>();

    for (a in this.objects.getIterator()) {
      for (b in this.objects.getIterator()) {
        var contact = resolveContact(a,b);
        if (contact!=null) {
          contacts.addLast(contact);
        }
      }
    }
      
    return contacts;
  }

  private function resolveContact(a : CollisionObject, b : CollisionObject) : Contact {
    return switch (a.getShape()) {
      case Circle(centerA, radiusA) :
        switch (b.getShape()) {
          case Circle(centerB, radiusB) :
            resolveCircleAndCircle(centerA, radiusA, centerB, radiusB);
          case Box(centerB, cornerB) :
            resolveBoxAndCircle(centerB, cornerB, centerA, radiusA);
        }
      case Box(centerA, cornerA) :
        switch (b.getShape()) {
          case Circle(centerB, radiusB) :
            resolveBoxAndCircle(centerA, cornerA, centerB, radiusB);
          case Box(centerB, cornerB) :
            resolveBoxAndBox(centerA, cornerA, centerB, cornerB);
        }
    }
  }

  private function resolveCircleAndCircle(centerA : Vector2f, radiusA : Float,
    centerB : Vector2f, radiusB : Float) : Contact {
    return null;
  }

  private function resolveBoxAndCircle(centerA : Vector2f, cornerA : Vector2f,
    centerB : Vector2f, radiusB : Float) : Contact {
    return null;
  }

  private function resolveBoxAndBox(centerA : Vector2f, cornerA : Vector2f,
    centerB : Vector2f, cornerB : Vector2f) : Contact {
    return null;
  }


}
