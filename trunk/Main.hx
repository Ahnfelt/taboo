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
    private var ball: AbstractParticle;
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
        ball = new WheelParticle(200 + Std.random(100), 10 - Std.random(100), 10);
        group.addParticle(ball);
        group.addParticle(new RectangleParticle(200, 300, 300, 50, 0.5, true));
        group.addParticle(new RectangleParticle(420, 300, 300, 50, -1, true));
        APEngine.addGroup(group);
        
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
            ball.velocity = ball.velocity.plus(new Vector(0, -10));
        }
        if(players[0].getKey(Key.Left) && ball.velocity.x > -5) {
            ball.addMasslessForce(new Vector(-5, 0));
        }
        if(players[0].getKey(Key.Right) && ball.velocity.x < 5) {
            ball.addMasslessForce(new Vector(5, 0));
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

