import flash.Lib;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.display.Graphics;
import flash.display.Sprite;

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

class Main {
    static function main() {
        var g: Graphics = Lib.current.graphics;
        g.beginFill(0xFF0000);
        g.drawRoundRect(0, 0, 800, 600, 20);
        g.endFill();
        
        new Game();
    }
}

private class Game extends Sprite {
    private var fps: FPS;
    private var man: Composite;
    private var body: AbstractParticle;
    private var direction: Int;
    private var players: Array<Player>;

    public function new() {
        super();
        Lib.current.addChild(this);
        
        players = new Array();
        players.push(new Player());

        APEngine.init(1 / 4);
        APEngine.container = this;
        APEngine.addMasslessForce(new Vector(0, 9));
        // APEngine.addGroup( ... ); - add objects
        // - set up collisions
        var group: Group = new Group();
        group.collideInternal = true;
        APEngine.addGroup(group);
        
        group.addComposite(new Box(50, 100, 30, 30, Std.random(600) / 100.0));
        group.addComposite(new Capsule(50, 50, 60, 20, Std.random(600) / 100.0));
        
        for(i in 0...10)
            group.addParticle(new WheelParticle(200 + Std.random(100), 10 - Std.random(100), 10));
        group.addParticle(new RectangleParticle(200, 300, 350, 50, 0.5, true));
        group.addParticle(new RectangleParticle(420, 300, 300, 50, -1, true));

        /*
        var man = new Composite();
        var leftFoot = new CircleParticle(200, 50, 5);
        var rightFoot = new CircleParticle(220, 50, 5);
        var bodyParticle = new CircleParticle(210, 35, 10);
		var leftLeg = new SpringConstraint(body, leftFoot, 0.5, true, 5);
		var rightLeg = new SpringConstraint(body, rightFoot, 0.5, true, 5);
		var footChains = new SpringConstraint(leftFoot, rightFoot, 1, true, 5);
		var leftHand = new CircleParticle(200, 20, 4, false, 0.01);
		var rightHand = new CircleParticle(220, 20, 4, false, 0.01);
		man.addParticle(leftHand);
		man.addParticle(rightHand);
		man.addConstraint(new SpringConstraint(leftFoot, leftHand, 1, false, 6));
		man.addConstraint(new SpringConstraint(rightFoot, rightHand, 1, false, 6));
		man.addConstraint(new SpringConstraint(leftHand, rightHand, 1, false, 4));
		man.addConstraint(new SpringConstraint(bodyParticle, leftHand, 1, false, 2));
		man.addConstraint(new SpringConstraint(bodyParticle, rightHand, 1, false, 2));
		leftFoot.mass = 2;
		rightFoot.mass = 2;
		man.addParticle(leftFoot);
		man.addParticle(rightFoot);
		man.addParticle(bodyParticle);
		man.addConstraint(leftLeg);
		man.addConstraint(rightLeg);
		man.addConstraint(footChains);
		group.addComposite(man);
		*/

        body = new RectangleParticle(210, 50, 30, 10, 1.6, false, 1, 0);		
		group.addParticle(body);
        
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        
        fps = new FPS(10, 10);
        addChild(fps);
    }
    
    private function enterFrameHandler(event: Event) {
        // Alternatively this can be done in a game loop
        fps.BeginCalc();
        APEngine.step();
        fps.EndCalc();
        APEngine.paint();
        
        if(players[0].consumeKey(Key.Jump)) {
            body.addMasslessForce(new Vector(0, -150));
        }
        if(players[0].getKey(Key.Left) && body.velocity.x > -3) {
            body.addMasslessForce(new Vector(-20, 0));
        }
        if(players[0].getKey(Key.Right) && body.velocity.x < 3) {
            body.addMasslessForce(new Vector(20, 0));
        }
    }

    private function keyDownHandler(event: KeyboardEvent): Void {
        switch(event.keyCode) {
            case Keyboard.UP:
                players[0].setKey(Key.Jump, true);
            case Keyboard.DOWN:
                players[0].setKey(Key.Duck, true);
            case Keyboard.SPACE:
                players[0].setKey(Key.Action, true);
            case Keyboard.LEFT:
                players[0].setKey(Key.Left, true);
            case Keyboard.RIGHT:
                players[0].setKey(Key.Right, true);
        }
    }
    
    private function keyUpHandler(event: KeyboardEvent): Void {
        switch(event.keyCode) {
            case Keyboard.UP:
                players[0].setKey(Key.Jump, false);
            case Keyboard.DOWN:
                players[0].setKey(Key.Duck, false);
            case Keyboard.SPACE:
                players[0].setKey(Key.Action, false);
            case Keyboard.LEFT:
                players[0].setKey(Key.Left, false);
            case Keyboard.RIGHT:
                players[0].setKey(Key.Right, false);
        }
    }
}


