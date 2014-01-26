package algo{
    public class StrandSort extends SortAlgo{
        override public function sort(array:Array):Array{
            array = array.concat();
            var arrays:Array = [];
            var count:int = 0;
            arrays.push(array.concat());
            var inc:Array, temp:Array;
            var remain:Array = array.concat();
            var sorted:Array = [];
            var i:int, c:int;
            while(sorted.length<array.length){
                inc =  [];
                temp = [];
                c=0;
                count+=remain.length;
                for(i=0;i<remain.length;++i){
                    if(c<=remain[i]){
                        c = remain[i];
                        inc.push(remain[i]);
                    }else{
                        temp.push(remain[i]);
                    }
                }
                remain = temp;
                temp = [];
                while(true){
                    count++;
                    if(inc.length==0){
                        temp = temp.concat(sorted);
                        break;
                    }else if(sorted.length==0){
                        temp = temp.concat(inc);
                        break;
                    }else if(inc[0]<sorted[0])temp.push(inc.shift());
                    else temp.push(sorted.shift());
                }
                sorted = temp;
                arrays.push(sorted.concat(remain));
            }
            arrays.push(sorted.concat());
            arrays.push(count);
            return arrays;
        }
    }
}