//http://ralphunden.net/content/tutorials/a-guide-to-introsort/?q=a-guide-to-introsort
package algo{
    public class QuickSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var i:int, start:int, end:int;
            array = array.concat();
            var count:int = 0;
            var arrays:Array = [];
            var sorted:Array = [];
            for(i=0;i<array.length;i++)sorted.push(false);
            arrays.push(array.concat());
            while(!isSorted(array)){
                start = 0;
                while(true){
                    while(start<array.length&&sorted[array[start]])start++;
                    if(start==array.length)break;
                    end=start+1;
                    while(end<array.length&&!sorted[array[end]])end++;
                    var temp:Array = array.slice(start,end);
                    temp = qsort(temp,temp[0],sorted,start);
                    for(i=start;i<end;i++)array[i]=temp[i-start];
                    count+=end-start-1;
                    start=end;
                }
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
        public function qsort(array:Array,num:int,sorted:Array,s:int):Array{
            var small:Array = [];
            var same:Array = [];
            var big:Array = [];
            var i:int;
            for(i=0;i<array.length;i++){
                if(array[i]<num)small.push(array[i]);
                else if(array[i]==num)same.push(array[i]);
                else big.push(array[i]);
            }
            for(i=0;i<same.length;i++)sorted[s+small.length+i]=true;
            return small.concat(same).concat(big);
        }

    }
}
