import org.cove.ape.APEngine;
import org.cove.ape.AbstractCollection;
import org.cove.ape.AbstractConstraint;
import org.cove.ape.AbstractItem;
import org.cove.ape.AbstractParticle;
import org.cove.ape.CircleParticle;
import org.cove.ape.Collision;
import org.cove.ape.CollisionDetector;
import org.cove.ape.CollisionResolver;
import org.cove.ape.Composite;
import org.cove.ape.Group;
import org.cove.ape.Interval;
import org.cove.ape.MathUtil;
import org.cove.ape.RectangleParticle;
import org.cove.ape.RimParticle;
import org.cove.ape.SpringConstraint;
import org.cove.ape.SpringConstraintParticle;
import org.cove.ape.Vector;
import org.cove.ape.WheelParticle;

class Capsule extends Composite {
    public function new(x: Float, y: Float, width: Float, thickness: Float, radians: Float) {
        super();
        var left = new CircleParticle(x, y, thickness / 2);
        var right = new CircleParticle(x + width, y, thickness / 2);
        addConstraint(new SpringConstraint(left, right, 1, true, thickness));
        for(particle in [left, right])
            addParticle(particle);
    }
}

