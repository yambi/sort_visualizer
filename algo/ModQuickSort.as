package algo{
    public class ModQuickSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var i:int, start:int, end:int;
            array = array.concat();
            var count:int = 0;
            var arrays:Array = [];
            arrays.push(array.concat());
            var queueLeft:Array = [0];
            var queueRight:Array = [array.length-1];
            var queueDepth:Array = [1];
            var dep:int = 0;
            while(queueLeft.length>0){
                var left:int = queueLeft.shift();
                var right:int = queueRight.shift();
                var cdep:int = queueDepth.shift();
                var size:int = right-left+1;
                if(size<=3){
                    manualSort(array,left,right);
                    count += size;
                }
                var pivot:int = partition(array,left,right);
                count+=right-left;
                if(left<pivot-1){
                    queueLeft.push(left);
                    queueRight.push(pivot-1);
                    queueDepth.push(cdep+1);
                }
                if(pivot+1<right){
                    queueLeft.push(pivot+1);
                    queueRight.push(right);
                    queueDepth.push(cdep+1);
                }
                if(dep<cdep){
                    dep=cdep;
                    arrays.push(array.concat());
                }
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }

    }
}

// package algo{
//     public class ModQuickSort extends SortAlgo{
//         override public function sort(array:Array):Array{
//             var i:int, start:int, end:int;
//             array = array.concat();
//             var count:int = 0;
//             var arrays:Array = [];
//             arrays.push(array.concat());
//             var stackLeft:Array = [0];
//             var stackRight:Array = [array.length-1];
//             while(stackLeft.length>0){
//                 var left:int = stackLeft.pop();
//                 var right:int = stackRight.pop();
//                 var size:int = right-left+1;
//                 if(size<=3){
//                     manualSort(array,left,right);
//                     count += size;
//                 }
//                 var pivot:int = partition(array,left,right);
//                 count+=right-left;
//                 arrays.push(array.concat());
//                 if(left<pivot-1){
//                     stackLeft.push(left);
//                     stackRight.push(pivot-1);
//                 }
//                 if(pivot+1<right){
//                     stackLeft.push(pivot+1);
//                     stackRight.push(right);
//                 }
//             }
//             arrays.push(array);
//             arrays.push(count);
//             return arrays;
//         }

//     }
// }
