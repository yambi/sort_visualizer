package algo{
    public class RandomSort extends SortAlgo{
        override public function sort(array:Array):Array{
            const MAX:int = 3000;
            var count:int = array.length-1;
            var arrays:Array = [];
            array = array.concat();
            arrays.push(array.concat());
            while(count<MAX&&!isSorted(array)){
                for(var i:int=1;i<array.length;++i){
                    var j:int = rand(i-1);
                    if(array[i]<array[j])swap(array,i,j);
                }
                count+=array.length-1;
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            if(!isSorted(array))arrays.push(">"+count);
            else arrays.push(count);
            return arrays;
        }
    }
}
