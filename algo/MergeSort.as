package algo{                                                                                                                                                             
    public class MergeSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var i:int, start1:int, start2:int, end:int, cg:int, ng:int;
            array = array.concat();
            var count:int = 0;
            var arrays:Array = [];
            var group:Array = makeArray(array.length);
            arrays.push(array.concat());
            while(!isSorted(array)){
                start1 = 0;
                while(start1<array.length){
                    cg = group[start1];
                    end=start1+1;
                    while(end<array.length&&group[end]==cg)end++;
                    start2 = end;
                    if(start2==array.length)break;
                    ng = group[start2];
                    while(end<array.length&&group[end]==ng){
                        group[end]=cg;
                        end++;
                    }
                    count+=merge(array,start1,start2,end);
                    start1=end;
                }
                arrays.push(array.concat());
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
        public function merge(array:Array,s1:int, s2:int, t:int):int{
            var temp:Array = array.slice(s1,s2);
            var count:int = 0;
            var i:int, j:int, k:int;
            for(i=s1, j=0, k=s2;i<t&&j<s2-s1;++i){
                count++;
                if(k>=t||temp[j]<array[k])array[i]=temp[j++];
                else array[i]=array[k++]
            }
            return count;
        }
    }
}