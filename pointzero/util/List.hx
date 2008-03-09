package pointzero.util;

import pointzero.util.ListItem;
import pointzero.util.ListIterator;

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

    public function remove(element : T) : Void {
      if (this.first.value==element || this.last.value==element) {
        if (this.size==1) {
          this.first = null;
          this.last = null;
        } else {
          if (this.first.value==element) {
            this.first = this.first.next;
          } else {
            this.last = this.last.prev;
          }
        }
      } else {
        var current = this.first;
        while (current!=this.last) {
          if (current.value==element) {
            current.prev.next = current.next;
            current.next.prev = current.prev;
            break;            
          }
        }
      }
      this.size--;
    }

    public function getFirst() : ListItem<T> {
      return this.first;
    }

    public function getIterator() : ListIterator<T> {
      return new ListIterator<T>(this);
    }

 }
