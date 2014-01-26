package algo{
    public class SortAlgo{
        public function sort(array:Array):Array{
            return null;
        }
        public function shuffle(array:Array):Array{
            for (var i:int = 0; i< array.length; i++)swap(array,i,rand(array.length));
            return array;
        }
        public function isSorted(array:Array):Boolean{
            for(var i:int=1; i<array.length; i++)if(array[i]<array[i-1])return false;
            return true;
        }
        //swap array[i] with array[j]
        public function swap(array:Array, i:int, j:int):void{
            var temp:int = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
        //swaps  array[a .. (a+n+1)] with array[b .. (b+n-1)]
        public function vecswap(array:Array,a:int,b:int,n:int):void{
            for(var i:int=0;i<n;i++,a++,b++)swap(array,a,b)
        }
        public function rand(num:int):int {
            return Math.floor(Math.random()*num);
        }
        public function makeArray(size:int):Array{
            var array:Array = [];
            for (var i:int = 0; i< size; i++)array.push(i);
            return array;
        }
        public function med3(a:Array,i:int,j:int,k:int):int{
            return (a[i]<a[j]?
                    (a[j]<a[k]?j:a[i]>a[k]?i:k):
                    (a[j]>a[k]?j:a[i]<a[k]?i:k));
        }
        public function medianOf3(array:Array,left:int,right:int):int{
            var center:int = (left+right)/2;
            if(array[left]>array[center])swap(array,left,center);
            if(array[left]>array[right])swap(array,left,right);
            if(array[center]>array[right])swap(array,center,right);
            swap(array,center,right-1);
            return array[right-1];
        }
        public function partition(array:Array,left:int,right:int):int{
            var pivot:int = medianOf3(array,left,right);
            var leftPtr:int = left;
            var rightPtr:int = right-1;
            while(true){
                while(array[++leftPtr]<pivot);
                while(array[--rightPtr]>pivot);
                if(leftPtr>=rightPtr)break;
                else swap(array,leftPtr,rightPtr);
            }
            swap(array,leftPtr,right-1);//restore pivot
            return leftPtr;
        }
        //sort if size<=3;
        public function manualSort(array:Array,left:int,right:int):void{
            var size:int = right-left+1;
            if(size<=1)return;
            else if(size==2){
                if(array[left]>array[right])swap(array,left,right);
                return;
            }else{//size==3
                if(array[left]>array[right-1])swap(array,left,right-1);
                if(array[left]>array[right])swap(array,left,right);
                if(array[right-1]>array[right])swap(array,right-1,right);
                return;
            }
        }

        public function rotate(array:Array, left:int, right:int):void {
            var p:int = array[right];
            for(var i:int=right;i>left;i--)array[i]=array[i-1];
            array[left] = p;
        }
        public function reverseRange(array:Array, lo:int, hi:int):void {
            hi--;
            while (lo < hi) {
                var t:int = array[lo];
                array[lo++] = array[hi];
                array[hi--] = t;
            }
        }
        private function countRunAndMakeAscending(array:Array, lo:int, hi:int):int {
            var runHi:int = lo + 1;
            if (runHi == hi)return 1;
            // Find end of run, and reverse range if descending
            if (array[runHi++]<array[lo]) { // Descending
                while(runHi < hi && array[runHi]<array[runHi-1]) runHi++;
                reverseRange(array, lo, runHi);
            } else {                              // Ascending
                while (runHi < hi && array[runHi]>=array[runHi-1]) runHi++;
            }
            return runHi - lo;
        }

        //arrayの[0,...,end]をヒープにする，比較回数を返す
        //makeHeap(array,0,end);で呼び出す
        public function makeHeap(array:Array,num:int,end:int):int{
            var argmax:int = num;
            var max:int = array[num];
            var next1:int = num*2+1;
            var next2:int = num*2+2;
            var count:int = 0;
            if(next1<end)count+=makeHeap(array,next1,end);
            if(next2<end)count+=makeHeap(array,next2,end);
            count+=fixHeap(array,num,end);
            if(num!=argmax)(array,num,argmax);
            return count;
        }

        //arrayの[0,..,end]上のmax heapでnumを壊した時の修正，比較回数を返す
        public function fixHeap(array:Array,num:int,end:int):int{
            var next:int = num;
            var max:int = array[num];
            var next1:int = num*2+1;
            var next2:int = num*2+2;
            if(next1<end&&max<array[next1]){
                max=array[next1];
                next=next1;
            }
            if(next2<end&&max<array[next2]){
                max=array[next2];
                next=next2;
            }
            if(num==next)return 2;
            else{
                swap(array,num,next);
                return fixHeap(array,next,end)+2;
            }
        }
    }
}

