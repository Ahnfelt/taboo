class Player {
    private var keyDownMap: Hash<Bool>;
    private var jumpWaiting: Bool;
    
    public function new() {
        keyDownMap = new Hash<Bool>();
        jumpWaiting = false;
    }
    
    /**
     * Returns true if the key is currently pressed.
     */
    public function getKey(key: Key): Bool {
        return keyDownMap.get(Std.string(key));
    }
    
    /**
     * Sets the status of a key (true means it's pressed).
     */
    public function setKey(key: Key, down: Bool): Void {
        if(key == Key.Jump) {
            jumpWaiting = down && !keyDownMap.get(Std.string(key));
        }
        keyDownMap.set(Std.string(key), down);
    }

    /**
     * If there is a jump waiting to happen, the function returns
     * true and the waiting jump is then cleared.
     */
    public function consumeJump(): Bool {
        var result = jumpWaiting;
        jumpWaiting = false;
        return result;
    }
}

