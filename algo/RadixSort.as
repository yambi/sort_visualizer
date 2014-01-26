package algo{                                                                                                                                                             
    public class RadixSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var base:int = 4;
            array = array.concat();
            arrays.push(array.concat());
            var i:int, j:int;
            for(i=1;i<array.length;i*=base){
                var temp:Array = new Array(base);
                for(j=0;j<base;++j)temp[j]=[];
                for(j=0;j<array.length;j++){
                    var num:int = (array[j]/i)%base;
                    temp[num].push(array[j]);
                }
                array = [];
                for(j=0;j<base;j++)array = array.concat(temp[j]);
                arrays.push(array);
            }
            arrays.push(array);
            arrays.push(0);
            return arrays;

        }
    }
}
