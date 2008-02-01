class Player {
    private var keyDownMap: Hash<Bool>;
    private var jumpWaiting: Bool;
    
    public function new() {
        keyDownMap = new Hash<Bool>();
        jumpWaiting = false;
    }
    
    public function getKey(key: Key): Bool {
        return keyDownMap.get(Std.string(key));
    }
    
    public function setKey(key: Key, down: Bool): Void {
        if(key == Key.Jump) {
            jumpWaiting = down && !keyDownMap.get(Std.string(key));
        }
        keyDownMap.set(Std.string(key), down);
    }

    public function consumeJump(): Bool {
        var result = jumpWaiting;
        jumpWaiting = false;
        return result;
    }
}

