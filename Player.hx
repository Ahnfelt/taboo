class Player {
    private var keyDownMap: Hash<Bool>;
    private var keyWaitingMap: Hash<Bool>;
    
    public function new() {
        keyDownMap = new Hash<Bool>();
        keyWaitingMap = new Hash<Bool>();
    }
    
    /**
     * Sets the status of a key (true means it's pressed).
     */
    public function setKey(key: Key, down: Bool): Void {
        if(!down || !keyDownMap.get(Std.string(key)))
            keyWaitingMap.set(Std.string(key), down);
        keyDownMap.set(Std.string(key), down);
    }

    /**
     * Returns true if the key is currently pressed.
     */
    public function getKey(key: Key): Bool {
        return keyDownMap.get(Std.string(key));
    }
    
    /**
     * If this key has been pressed, the function returns
     * true. Subsequent calls return true until the key
     * is released and pressed again.
     */
    public function consumeKey(key: Key): Bool {
        var result = keyWaitingMap.get(Std.string(key));
        keyWaitingMap.set(Std.string(key), false);
        return result;
    }
}

