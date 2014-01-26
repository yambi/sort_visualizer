package algo{                                                                                                                                                             
    public class SelectionSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());

            var i:int = 0;
            var min:int, argmin:int;
            while(i<array.length){
                min = array[i];
                argmin = i;
                for(var j:int=i+1;j<array.length;++j){
                    count++;
                    if(min>array[j]){
                        min = array[j];
                        argmin = j;
                    }
                }
                swap(array,i,argmin);
                arrays.push(array.concat());
                i++;
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
    }
}

