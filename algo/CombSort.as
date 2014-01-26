package algo{                                                                                                                                                             
    public class CombSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            arrays.push(array.concat());
            array = array.concat();
            var h:int = array.length*10/13;
            var flag:int;
            var i:int;
            while(true){
                flag=1;
                for(i=0;i+h<array.length;++i){
                    count++;
                    if(array[i]>array[i+h]){
                        swap(array,i,i+h);
                        flag=0;
                    }
                }
                arrays.push(array.concat());
                h = h*10/13;
                if(h<=1){
                    if(flag==1)break;
                    h=1;
                }
                if(h==9||h==10)h=11;
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;

        }
    }
}

