import flash.Lib;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.MovieClip;

class Main {
    static function main() {
        var g: Graphics = Lib.current.graphics;
        g.beginFill(0xFF0000);
        g.drawRoundRect(0, 0, 800, 600, 20);
        g.endFill();
        new Editor();
    }
}

private class Editor extends Sprite {
    var selectedJoint: WallJoint;
    var joints: Array<WallJoint>;
    var mouse: {x: Float, y: Float};
    var gridStep: {x: Float, y: Float};

    public function new() {
        super();
    
        gridStep = {x: 30.0, y: 30.0};
        selectedJoint = null;
        joints = [];
        mouse = {x: mouseX, y: mouseY};
        draw();

        Lib.current.addChild(this);

        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
        Lib.current.stage.addEventListener(MouseEvent.CLICK, mouseClickHandler);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
    }
    
    private function draw() {
        var g: Graphics = this.graphics;
        g.clear();
        for(joint in joints) {
            for(connection in joint) {
                g.lineStyle(Math.min(joint.thickness, connection.thickness), 
                    0xFFFFFF, 100);
                g.beginFill(0xFFFFFF);
                g.moveTo(joint.x, joint.y);
                g.lineTo(connection.x, connection.y);
                g.endFill();
            }
        }
        for(joint in joints) {
            g.lineStyle(0, 0x000000, 1000);
            g.beginFill(0xFFFFFF);
            g.drawCircle(joint.x, joint.y, joint.thickness / 2.0);
            g.endFill();
        }
        if(selectedJoint != null) {
            g.lineStyle(1, 0xFFFFFF, 100);
            g.beginFill(0x000000);
            g.drawCircle(selectedJoint.x, selectedJoint.y, 3.0);
            g.endFill();
        }
    }

    private function jointAt(x: Float, y: Float): WallJoint {
        for(joint in joints) {
            var deltaX = joint.x - x;
            var deltaY = joint.y - y;
            var distanceSquared = deltaX * deltaX + deltaY * deltaY;
            var thicknessSquared = joint.thickness * joint.thickness;
            if(distanceSquared < thicknessSquared)
                return joint;
        }
        return null;
    }

    private function mouseClickHandler(event: MouseEvent): Void {
        var newJoint = jointAt(mouse.x, mouse.y);
        if(newJoint == null) {
            newJoint = new WallJoint(mouse.x, mouse.y);
            joints.push(newJoint);
        }
        if(selectedJoint != null && event.shiftKey)
            newJoint.addConnection(selectedJoint);
        selectedJoint = newJoint;
        draw();
    }

    private function mouseMoveHandler(event: MouseEvent): Void {
        mouse.x = event.stageX;
        mouse.y = event.stageY;
        if(!event.ctrlKey) {
            mouse.x = Math.round(mouse.x / gridStep.x) * gridStep.x;
            mouse.y = Math.round(mouse.y / gridStep.y) * gridStep.y;
        }
        draw();
    }
    
    private function keyHandler(event: KeyboardEvent): Void {
        var pressed = event.type == KeyboardEvent.KEY_DOWN;
        switch(event.keyCode) {
            case Keyboard.DELETE:
                if(pressed && selectedJoint != null) {
                    selectedJoint.dispose();
                    joints.remove(selectedJoint);
                    selectedJoint = null;
                }
            case Keyboard.SHIFT:
                //shiftKey = state;
            case Keyboard.CONTROL:
                //controlKey = state;
        }
        draw();
    }
}


