package algo{
    public class BozoSort extends SortAlgo{
        override public function sort(array:Array):Array{
            const MAX:int = 3000;
            var count:int = array.length-1;
            var arrays:Array = [];
            array = array.concat();
            arrays.push(array.concat());
            while(count<MAX&&!isSorted(array)){
                count+=array.length-1;
                swap(array,rand(array.length),rand(array.length))
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            if(!isSorted(array))arrays.push(">"+count);
            else arrays.push(count);
            return arrays;
        }
    }
}
