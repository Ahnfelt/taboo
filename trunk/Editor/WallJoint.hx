class WallJoint {
    public var x(default, default): Float;
    public var y(default, default): Float;
    public var thickness(default, default): Float;
    private var connections: Array<WallJoint>;
    
    public function new(x: Float, y: Float, ?thickness: Float, ?connection: WallJoint) {
        this.x = x; 
        this.y = y;
        this.connections = [];
        this.thickness = if(thickness == null) 10.0 else thickness;
        if(connection != null) {
            addConnection(connection);
        }
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

    public function iterator(): Iterator<WallJoint> {
        return connections.iterator();
    }
}

