package algo{                                                                                                                                                             
    public class GnomeSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            array = array.concat();
            arrays.push(array.concat());

            var i:int = 0;
            var max:int = 0;
            while(i<array.length){
                if(i==0 || array[i-1]<=array[i])i++;
                else swap(array,i--,i-1);
                if(max<i){
                    max = i;
                    arrays.push(array.concat());
                }
            }
            arrays.push(array.concat());

            return arrays;
        }
    }
}


