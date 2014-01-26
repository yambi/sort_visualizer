package algo{
    public class BinarySort extends SortAlgo{
        import mx.controls.*;
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());
            var i:int,j:int,temp:int;
            for(i=1;i<array.length;i++){
                count+=binaryInsert(array,i);
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
        public function binaryInsert(array:Array,pos:int):int{
            var count:int = 0;
            var pivot:int = array[pos];
            var left:int = 0;
            var right:int = pos;
            while(left<right){
                count++;
                var mid:int = (left + right)>>>1;
                if(pivot<array[mid])right=mid;
                else left = mid + 1;
            }
            rotate(array,left,pos);
            return count;
        }
    }
}

