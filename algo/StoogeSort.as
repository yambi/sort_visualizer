package algo{
    public class StoogeSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            var stackLeft:Array = [0];
            var stackRight:Array = [array.length-1];
            arrays.push(array.concat());
            while(stackLeft.length>0){
                var left:int = stackLeft.pop();
                var right:int = stackRight.pop();
                if(array[left]>array[right]){
                    swap(array,left,right);
                    arrays.push(array.concat());
                }
                count++;
                if(right-left<=1)continue;

                var t:int = Math.floor((right-left+1)/3);
                stackLeft.push(left);
                stackRight.push(right-t);
                stackLeft.push(left+t);
                stackRight.push(right);
                stackLeft.push(left);
                stackRight.push(right-t);
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
    }
}

