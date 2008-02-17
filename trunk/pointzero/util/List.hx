package pointzero;

import pointzero.ListItem;
import pointzero.ListIterator;

/*
enum Item<T> {
  empty;
  cons( value : T, next : Item<T>, prev: Item<T> );
}
*/

class List<T> {

    private var first : ListItem<T>;
    private var last : ListItem<T>;    
    private var size(default, null) : Int;

    public function new() {
      this.first = null;
      this.last = this.first;
      this.size = 0;
    }

    public function empty() {
      this.first = null;
      this.last = this.first;
      this.size = 0;
    }

    public function addLast(value : T) : Void {
      this.size++;
      var newLast = new ListItem(value, null, this.last);
      if (this.last!=null) {
        this.last.next = newLast; 
        this.last = newLast;
      } else {
        this.last = newLast;
      }      
      if (this.first==null) 
        this.first = this.last;

    }

    public function addFirst(value : T) : Void {
      this.size++;
      var newFirst = new ListItem(value, this.first, null);
      if (this.first!=null) {
        this.first.prev = newFirst;
        this.first = newFirst;
      } else {
        this.first = newFirst;
      }
      if (this.last==null) {
        this.last = this.first;
      }
    }

    public function removeLast() : Void {
      if (this.last!=null) {
        if (this.last==this.first) {
          this.last = null;
          this.first = null;
        } else {
          this.last = this.last.prev;
        }
      }
    }

    public function removeFist() : Void {
      if (this.first!=null) {
        if (this.last==this.first) {
          this.last = null;
          this.first = null;
        } else {
          this.first = this.first.next;
        }
      }
    }

    public function getFirst() : ListItem<T> {
      return this.first;
    }

    public function getIterator() : ListIterator<T> {
      return new ListIterator<T>(this);
    }

 }
