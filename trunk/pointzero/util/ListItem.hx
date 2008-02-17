package pointzero.util;

class ListItem<T> {
    public var value : T;
    public var next : ListItem<T>;
    public var prev : ListItem<T>;

    public function new (value : T , next : ListItem<T>, prev : ListItem<T>) {
      this.value = value;
      this.next = next;
      this.prev = prev;
    }
}
