import mx.core.*;
import mx.controls.*;
import mx.events.*;
import mx.graphics.codec.*;
import mx.core.*;
import mx.formatters.*;
import flash.display.*;
import flash.events.*;
import flash.text.*;
import frocessing.color.ColorHSV;
import flash.external.ExternalInterface;
import algo.*;


private var SORTALGO:Dictionary;
private var ALPHA:Number;
private var SIZE:int;
private var THICKNESS:int;
private var iarray:Array;//initial array
private var h:Number;
private var input:String;
private var EPS:Number = 1.0E-5;

private function init():void{
    SORTALGO = new Dictionary();
    SORTALGO["Bubble Sort"]=new BubbleSort();
    SORTALGO["Insertion Sort"]=new InsertionSort();
    SORTALGO["Odd Even Sort"]=new OddevenSort();
    SORTALGO["Shaker Sort"]=new ShakerSort();
    SORTALGO["Comb Sort"]=new CombSort();
    SORTALGO["Shell Sort"]=new ShellSort();
    SORTALGO["Insertion Sort"]=new InsertionSort();
    SORTALGO["Binary Sort"]=new BinarySort();
    SORTALGO["Selection Sort"]=new SelectionSort();
    SORTALGO["Quick Sort"]=new QuickSort();
    SORTALGO["Modified Quick Sort"]=new ModQuickSort();
    SORTALGO["Java Sort"]=new JavaSort();
    SORTALGO["Merge Sort"]=new MergeSort();
    SORTALGO["Strand Sort"]=new StrandSort();
    SORTALGO["Heap Sort"]=new HeapSort();
    SORTALGO["Radix Sort"]=new RadixSort();
    SORTALGO["Bucket Sort"]=new BucketSort();
    SORTALGO["Stooge Sort"]=new StoogeSort();
    SORTALGO["Bogo Sort"]=new BogoSort();
    SORTALGO["Bozo Sort"]=new BozoSort();
    SORTALGO["Goro Sort"]=new GoroSort();
    input="random";
    makeInput();
    s.graphics.beginFill(0x00000);
    s.graphics.drawRect(0,0,s.width,s.height);
    s.graphics.endFill();
}
private function save():void{
    var bmp:BitmapData = new BitmapData(s.width, s.height);
    bmp.draw(s, new Matrix());
    var fileData:ByteArray = new JPEGEncoder().encode(bmp);
    //var fileName:String = new Date().getTime() + ".jpg";
    var fileName:String = c_algorithm.selectedItem +"_"+ h_size.value +"_"+ input + ".jpg";
    var fr:FileReference = new FileReference();
    var onComplete:Function = function(event:Event):void{
        Alert.show(fileName+" saved", "success");
        onDestruct();
    }
    var onIOError:Function = function(event:IOErrorEvent):void{
        Alert.show(event.toString(), "failed");
        onDestruct();
    }
    var onDestruct:Function = function():void{
        fr.removeEventListener(Event.COMPLETE, onComplete);
        fr.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
        fr = null;
    }
    fr.addEventListener(Event.COMPLETE, onComplete);
    fr.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
    fr.save(fileData, fileName);
}


private function makeInput():void{
    switch(input){
    case 'random':
        random();
        break;
    case 'reverse':
        reverse();
        break;
    }
}
private function random():void{
    input="random";
    schange();
    iarray = shuffledArray();
    s.graphics.clear();
    s.graphics.beginFill(0x00000);
    s.graphics.drawRect(0,0,s.width,s.height);
    s.graphics.endFill();
    for(var i:int=0;i<SIZE;++i){
        var num:int = iarray[i];
        s.graphics.beginFill(new ColorHSV(num * 270 / SIZE, 0.7).value);
        s.graphics.drawCircle(0, i*h,THICKNESS/2);
        s.graphics.endFill();
    }
}
private function shuffledArray():Array{
    return shuffle(makeArray(SIZE));
}
private function reverse():void{
    input="reverse";
    schange();
    iarray = reverseArray();
    var i:int;
    s.graphics.clear();
    s.graphics.beginFill(0x00000);
    s.graphics.drawRect(0,0,s.width,s.height);
    s.graphics.endFill();
    for(i=0;i<SIZE;++i){
        var num:int = iarray[i];
        s.graphics.beginFill(new ColorHSV(num * 270 / SIZE, 0.7).value);
        s.graphics.drawCircle(0, i*h,THICKNESS/2);
        s.graphics.endFill();
    }
}
private function reverseArray():Array{
    return makeArray(SIZE).reverse();
}
private function schange():void{
    SIZE = h_size.value;
    THICKNESS = h_thickness.value;
    ALPHA = h_alpha.value;
    h = 500.0/(SIZE-1);
    t_size.text = String(SIZE);
}
private function tchange():void{
    var num:int = int(t_size.text);
    if(num>512){
        t_size.text="512";
        num=512;
    }
    h_size.value = num;
    makeInput();
}
private function fullscreen():void{
    if (stage.displayState == StageDisplayState.NORMAL){
        stage.displayState = StageDisplayState.FULL_SCREEN;
    }
    else{
        stage.displayState = StageDisplayState.NORMAL;
    }
}
private function sort():void{
    if(c_autoshuffle.selected)random();
    var str:String = String(c_algorithm.selectedItem);
    draw(SORTALGO[str].sort(iarray));
}
private function draw(arrays:Array):void{
    s.graphics.clear();
    s.graphics.beginFill(0x00000);
    s.graphics.drawRect(0,0,s.width,s.height);
    s.graphics.endFill();

    var num:int;
    var i:int,j:int,k:int;
    t_compared.text="elements:"+SIZE+"\n"+"compared:"+arrays.pop();
    var w:Number = 500/(arrays.length-1);
    for(i=1;i<arrays.length;i++){
        var inv:Array = new Array(SIZE);
        for(j=0;j<SIZE;j++)inv[arrays[i][j]]=j;
        for(j=0;j<SIZE;j++){
            num = arrays[i-1][j];
            s.graphics.lineStyle(THICKNESS, new ColorHSV(num * 270 / SIZE, 0.7).value, ALPHA);
            s.graphics.moveTo((i-1)*w, j*h);
            s.graphics.lineTo(i*w, inv[arrays[i-1][j]]*h);
        }
    }
}
private function makeArray(size:int):Array{
    var array:Array = [];
    for (var i:int = 0; i< size; i++)array.push(i);
    return array;
}
private function shuffle(array:Array):Array{
    for (var i:int = 0; i< array.length; i++)swap(array,i,rand(array.length));
    return array;
}
private function isSorted(array:Array):Boolean{
    for(var i:int=1; i<array.length; i++)if(array[i]<array[i-1])return false;
    return true;
}
private function swap(array:Array, i:int, j:int):void{
    var temp:int = array[i];
    array[i] = array[j];
    array[j] = temp;
}
private function rand(num:int):int {
    return Math.floor(Math.random()*num);
}
