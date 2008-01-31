class PArray
{
   public static function indexOf(array:Array<Dynamic>,value:Dynamic) : Int
   {
      for(i in 0...array.length)
         if (array[i]==value)
            return i;
      return -1;
   }
}
