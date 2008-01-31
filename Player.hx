enum Key {
    Left;
    Right;
    Jump;
    Duck;
    Action;
}

class Player {
    private var keyDownMap: Hash<Bool>;
    
    public function new() {
        keyDownMap = new Hash<Bool>();
    }

    public function getKey(key: Key): Bool {
        return keyDownMap.get(Std.string(key));
    }
    
    public function setKey(key: Key, down: Bool): Void {
        keyDownMap.set(Std.string(key), down);
    }
}

