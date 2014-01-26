package algo{
    public class ShakerSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());
            var upper:int =array.length;
            var lower:int =0;
            while(true){
                var i:int;
                var temp:int = 0;
                for(i=lower+1;i<upper;i++){
                    count++;
                    if(array[i-1]>array[i]){
                        swap(array,i-1,i);
                        temp = i;
                    }
                }
                upper=temp;
                arrays.push(array.concat());
                if(lower>=upper)break;
                for(i=upper-1;i>lower;i--){
                    count++;
                    if(array[i-1]>array[i]){
                        swap(array,i-1,i);
                        temp = i;
                    }
                }
                lower=temp;
                arrays.push(array.concat());
                if(lower>=upper)break;
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
    }
}
