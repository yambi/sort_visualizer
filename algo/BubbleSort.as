package algo{
    public class BubbleSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());
            var i:int, j:int;
            i=array.length;
            while(i>0){
                var min:int = 0;
                for(j=1;j<i;j++){
                    count++;if(array[j-1]>array[j]){
                        swap(array,j-1,j);
                        min = j;
                    }
                }
                i=min;
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
    }
}
