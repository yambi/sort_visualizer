package algo{
    public class OddevenSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            arrays.push(array.concat());
            while(true){
                var i:int;
                var flag:int = 0;
                for(i=1;i<array.length;i+=2){
                    count++;
                    if(array[i-1]>array[i]){
                        swap(array,i-1,i);
                        flag = 1;
                    }
                }
                //arrays.push(array.concat());
                for(i=2;i<array.length;i+=2){
                    count++;
                    if(array[i-1]>array[i]){
                        swap(array,i-1,i);
                        flag = 1;
                    }
                }
                arrays.push(array.concat());
                if(flag==0)break;
            }
            arrays.push(count);
            return arrays;
        }
    }
}