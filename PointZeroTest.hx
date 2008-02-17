import flash.Lib;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.display.Graphics;
import flash.display.Sprite;

import pointzero.List;
import pointzero.RigidBody;
import pointzero.PointZeroEngine;
import pointzero.List;
import pointzero.ListIterator;


class PointZeroTest {
    static function main() {
        var g: Graphics = Lib.current.graphics;
        g.beginFill(0x0000FF);
        g.drawRoundRect(0, 0, 800, 600, 20);
        g.endFill();              

        new Game();
      	new PointZeroEngine(25, 5);
    }
}

private class Game extends Sprite {
    private var direction: Int;

    private var offset : Int;

    private function print(text : String) : Void {
        var tf = new flash.text.TextField();
        tf.text = text;
        tf.y = offset;
        Lib.current.addChild(tf);
        this.offset += 15;
    }

    public function new() {
        super();
        Lib.current.addChild(this);
        this.offset = 0;
        print("Hello World !");

        var list  = new List<String>();
        list.addLast("3");
        list.addLast("4");
        list.addLast("5");
        list.addFirst("2");
        list.addFirst("1");


        for (i in list.getIterator()) {
          print(i);          
        }
        print("wgat..");

        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        
        //addChild(fps);
    }
    
    private function enterFrameHandler(event: Event) {
        // Alternatively this can be done in a game loop

    }

    private function keyDownHandler(event: KeyboardEvent): Void {
        switch(event.keyCode) {
            case Keyboard.UP:
            case Keyboard.DOWN:
            case Keyboard.SPACE:
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
        }
    }
    
    private function keyUpHandler(event: KeyboardEvent): Void {
        switch(event.keyCode) {
            case Keyboard.UP:
            case Keyboard.DOWN:
            case Keyboard.SPACE:
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
        }
    }
}


