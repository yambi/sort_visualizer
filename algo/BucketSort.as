package algo{                                                                                                                                                             
    public class BucketSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            arrays.push(array.concat());
            var i:int, j:int;
            var bucket:Array = new Array(array.length);
            for(i=0;i<array.length;i++)bucket[i]=0;
            for(i=0;i<array.length;i++)bucket[array[i]]++;
            array = [];
            for (i=0;i<bucket.length;i++)for(j=0;j<bucket[i];j++)array.push(i);
            arrays.push(array);
            arrays.push(0);
            return arrays;
        }
    }
}

