class WallJoint {
    public var x(default, default): Float;
    public var y(default, default): Float;
    public var thickness(default, default): Float;
    public var connections(default, null): Array<WallJoint>;
    public var id(default, null): Int;
    private static var nextId = 1;
    
    public function new(x: Float, y: Float, ?id: Int) {
        if(id == null) {
            this.id = nextId++;
        } else {
            if(id >= nextId)
                nextId = id + 1;
            this.id = id;
        }
        this.x = x; 
        this.y = y;
        this.thickness = 10.0;
        this.connections = [];
    }

    public function dispose(): Void {
        for(connection in connections) {
            connection.connections.remove(this);
        }
    }

    public function addConnection(connection: WallJoint): Void {
        if(!Lambda.has(connections, connection))
            connections.push(connection);
        if(!Lambda.has(connection.connections, this))
            connection.connections.push(this);
    }
    
    public function setXY(x: Float, y: Float): Void {
        this.x = x; 
        this.y = y;
    }

}

