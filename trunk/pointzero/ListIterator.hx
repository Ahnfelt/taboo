package pointzero;

import pointzero.List;
import pointzero.ListItem;

class ListIterator<T> {

    private var current : ListItem<T>;
    private var list : List<T>;

    public function new(list : List<T> ) {
      this.list = list;
      this.current = list.getFirst();
    }    

    public function hasNext() : Bool {
      return this.current!=null;
    }

    public function next() : T {
      if (this.current!=null) {
        var temp = this.current;
        this.current = this.current.next;
        return temp.value;
      }
      else 
        return null;
    }   


 }
