package algo{
    public class JavaSort extends SortAlgo{
        override public function sort(array:Array):Array{
            var arrays:Array = [];
            var count:int = 0;
            array = array.concat();
            var queueOff:Array = [0];
            var queueLen:Array = [array.length];
            var queueDepth:Array = [1];
            var dep:int =  0;
            while(queueOff.length>0){
                var cdep:int = queueDepth.shift();
                var off:int = queueOff.shift();
                var len:int = queueLen.shift();

                if(dep<cdep){
                    dep=cdep;
                    arrays.push(array.concat());
                }

                var i:int, j:int;
                //insertion sort
                if(len<7){
                    for(i=off;i<len+off;i++){
                        for(j=i;j>off&&array[j-1]>array[j];j--){
                            swap(array,j,j-1);
                            count++;
                        }
                    }
                    arrays.push(array.concat());
                    continue;
                }

                var m:int = off+(len>>>1);//middle element
                if(len>7){
                    var l:int = off;
                    var n:int = off+len-1;
                    if(len>40){
                        var s:int = len/8;
                        l=med3(array,l,l+s,l+2*s);count+=3;
                        m=med3(array,m-s,m,m+s);count+=3;
                        n=med3(array,n,n-s,n-2*s);count+=3;
                    }
                    m=med3(array,l,m,n);count+=3;
                }
                var v:int = array[m];//middle value
                var a:int=off, b:int=a, c:int=off+len-1, d:int=c;
                //off, (=v), a, (<v), b,  (in progress), c, (>v), a, (=v), off+len-1
                while(true){
                    while(b<=c&&array[b]<=v){
                        count++;
                        if(array[b]==v)swap(array,a++,b);
                        count++;
                        b++;
                    }
                    while(c>=b&&array[c]>=v){
                        count++;
                        if(array[c]==v)swap(array,c,d--);
                        count++;
                        c--;
                    }
                    if(b>c){
                        break;
                    }
                    swap(array,b++,c--);
                }
                n=off+len;
                s=Math.min(a-off,b-a);vecswap(array,off,b-s,s);
                s=Math.min(d-c,n-d-1);vecswap(array,b,n-s,s);
                if((s=b-a)>1){
                    queueOff.push(off);
                    queueLen.push(s);
                    queueDepth.push(cdep+1);
                }
                if((s=d-c)>1){
                    queueOff.push(n-s);
                    queueLen.push(s);
                    queueDepth.push(cdep+1);
                }
            }
            arrays.push(array.concat());
            arrays.push(count);
            return arrays;
        }
    }
}














// package algo{
//     public class JavaSort extends SortAlgo{
//         override public function sort(array:Array):Array{
//             var arrays:Array = [];
//             var count:int = 0;
//             array = array.concat();
//             arrays.push(array.concat());
//             count=sort1(arrays,array,0,array.length);
//             arrays.push(array.concat());
//             arrays.push(count);
//             return arrays;
//         }
//         private function sort1(arrays:Array,array:Array,off:int,len:int):int{
//             arrays.push(array.concat());
//             var count:int = 0;
//             var i:int, j:int;
//             //insertion sort
//             if(len<7){
//                 for(i=off;i<len+off;i++){
//                     for(j=i;j>off&&array[j-1]>array[j];j--){
//                         swap(array,j,j-1);
//                         count++;
//                     }
//                 }
//                 arrays.push(array.concat());
//                 return count;
//             }

//             var m:int = off+(len>>>1);//middle element
//             if(len>7){
//                 var l:int = off;
//                 var n:int = off+len-1;
//                 if(len>40){
//                     var s:int = len/8;
//                     l=med3(array,l,l+s,l+2*s);count+=3;
//                     m=med3(array,m-s,m,m+s);count+=3;
//                     n=med3(array,n,n-s,n-2*s);count+=3;
//                 }
//                 m=med3(array,l,m,n);count+=3;
//             }
//             var v:int = array[m];//middle value
//             var a:int=off, b:int=a, c:int=off+len-1, d:int=c;
//             //off, (=v), a, (<v), b,  (in progress), c, (>v), a, (=v), off+len-1
//             while(true){
//                 while(b<=c&&array[b]<=v){
//                     count++;
//                     if(array[b]==v)swap(array,a++,b);
//                     count++;
//                     b++;
//                 }
//                 while(c>=b&&array[c]>=v){
//                     count++;
//                     if(array[c]==v)swap(array,c,d--);
//                     count++;
//                     c--;
//                 }
//                 if(b>c){
//                     break;
//                 }
//                 swap(array,b++,c--);
//             }
//             n=off+len;
//             s=Math.min(a-off,b-a);vecswap(array,off,b-s,s);
//             s=Math.min(d-c,n-d-1);vecswap(array,b,n-s,s);
//             if((s=b-a)>1)count+=sort1(arrays,array,off,s);
//             if((s=d-c)>1)count+=sort1(arrays,array,n-s,s);
//             return count;
//         }
//     }
// }
