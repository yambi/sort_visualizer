package algo{
    public class GoroSort extends SortAlgo{
        override public function sort(array:Array):Array{
            //const MAX:int = 3000;
            var count:int = array.length-1;
            var arrays:Array = [];
            array = array.concat();
            arrays.push(array.concat());
            while(!isSorted(array)){
                var ns:Array = [];
                var i:int;
                for (i=0;i<array.length;i++){
                    if(array[i]!=i)ns.push(array[i]);
                }
                for(i=0;i<ns.length;i++){
                    swap(array,ns[i],ns[rand(ns.length)]);
                }
                count+=ns.length-1;

                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            if(!isSorted(array))arrays.push(">"+count);
            else arrays.push(count);
            return arrays;
        }
    }
}
