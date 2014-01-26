package algo{
    public class IntroSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var i:int, start:int, end:int;
            array = array.concat();
            var count:int = 0;
            var arrays:Array = [];
            arrays.push(array);
            var stackLeft:Array = [0];
            var stackRight:Array = [array.length-1];
            while(stackLeft.length>0){
                var left:int = stackLeft.pop();
                var right:int = stackRight.pop();
                var size:int = right-left+1;
                if(size<=3){
                    manualSort(array,left,right);
                    count += size;
                    continue;
                }
                var pivot:int = partition(array,left,right);
                count+=right-left;
                arrays.push(array.concat());
                if(left<pivot-1){
                    stackLeft.push(left);
                    stackRight.push(pivot-1);
                }
                if(pivot+1<right){
                    stackLeft.push(pivot+1);
                    stackRight.push(right);
                }
            }
            arrays.push(array);
            arrays.push(count);
            return arrays;
        }

    }
}
