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

class Box extends Composite {
    public function new(x: Float, y: Float, width: Float, height: Float, radians: Float) {
        super();
        var nw = new CircleParticle(x, y, 1);
        var ne = new CircleParticle(x + width, y, 1);
        var sw = new CircleParticle(x, y + width, 1);
        var se = new CircleParticle(x + width, y + width, 1);
        for(particle in [nw, ne, sw, se])
            addParticle(particle);
        addConstraint(new SpringConstraint(nw, ne, 1, true, 2));
        addConstraint(new SpringConstraint(ne, se, 1, true, 2));
        addConstraint(new SpringConstraint(se, sw, 1, true, 2));
        addConstraint(new SpringConstraint(sw, nw, 1, true, 2));
        addConstraint(new SpringConstraint(nw, se, 1, true, 2));
        addConstraint(new SpringConstraint(ne, sw, 1, true, 2));
    }
}

