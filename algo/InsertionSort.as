package algo{
    public class InsertionSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());
            var i:int,j:int,temp:int;
            for(i=1;i<array.length;i++){
                temp=array[i];
                for(j=i-1;j>=0&&array[j]>temp;j--)array[j+1]=array[j];
                array[j+1]=temp;
                count+=i-j;
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
    }
}
