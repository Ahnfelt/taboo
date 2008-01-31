package ;

import flash.text.TextField;
import flash.events.Event;
import flash.Lib;

 class FPS extends flash.text.TextField {

   private var mCalcTotal:Float;
   private var mCalc0:Float;
   private var mCalcs:Int;

   private var mT0:Float;
   private var mTLast:Float;
   private var mFrames:Int;

   public function new(inX:Int,inY:Int) {
      super();
      x = inX;
      y = inY;
      width = 400;
      addEventListener(Event.ENTER_FRAME, onFrame);
      mT0 = Lib.getTimer();
      mTLast = mT0;
      mFrames = 0;
      mCalcs = 0;
      mCalcTotal = 0;
      textColor = 0xffffff;
   }

   public function BeginCalc() : Void
   {
     mCalc0 = Lib.getTimer();
   }

   public function EndCalc() : Void
   {
     mCalcTotal += Lib.getTimer() - mCalc0;
     mCalcs++;
   }


   public function onFrame(evt:Event):Void {
       mFrames++;
       var timer:Float = Lib.getTimer();
       var fps:Float = mFrames*1000/(timer-mT0);
       var dt:Float = 0;
       if (mCalcs>0)
          dt = mCalcTotal/mCalcs;

       var dts:String = ("" + dt).substr(0,5);
       var fpss:String = ("" + fps).substr(0,5);

       htmlText = "<font size='20'>" + dts + " ms (" + fpss + " fps)</font>";
   }

 }



