package algo{
    public class HeapSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());
            var i:int, num:int, next:int;
            //make heap O(n)
            count+=makeHeap(array,0,array.length);
            makeHeap(array,0,array.length);
            arrays.push(array.concat());
            //sort
            for(i=array.length-1;i>0;i--){
                num = 0;
                swap(array,num,i);
                count+=fixHeap(array,num,i);
                arrays.push(array.concat());
            }

            arrays.push(array.concat());
            arrays.push(count);
            return arrays;

        }
    }
}

