package algo{                                                                                                                                                             
    public class ShellSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            arrays.push(array.concat());
            array = array.concat();
            var h:int = 1;
            while(3*h+1<array.length)h=3*h+1;
            var i:int;
            var j:int, temp:int;
            while(h>0){
                for(i=h;i<array.length;i++){
                    temp=array[i];
                    for(j=i-h;j>=0&&array[j]>temp;j-=h)array[j+h]=array[j];
                    array[j+h]=temp;
                    count+=(i-j)/h;
                }
                h/=3;
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;

        }
    }
}
