import chisel3._
import chisel3.util._

class AXI extends Bundle{
     val AR  = new AR()
     val R   = new R()
     val AW  = new AW()
     val W   = new W()
     val B   = new B()
}

class AxiMux extends Module{
    val io = IO(new Bundle(){
      val AxiMaster1 = Flipped(new AXI())
      val AxiSlave1  = new AXI()
      val AxiSlave2  = new AXI()

    val DebugWriteState = Output(UInt(2.W))
    val DebugReadState  = Output(UInt(2.W))


      }
    ) 
    val IDLE   = 0.U(2.W)
    val SLAVE1 = 1.U(2.W)
    val SLAVE2 = 2.U(2.W)

    val SLAVE1DATAMEM = 1.U(4.W)
    val SLAVE2APB     = 2.U(4.W)

    val WriteState = RegInit(0.U(2.W))
    val ReadState  = RegInit(0.U(2.W))

  val ArId    = io.AxiMaster1.AR.ArId    
  val ArAddr  = io.AxiMaster1.AR.ArAddr  
  val ArLen   = io.AxiMaster1.AR.ArLen   
  val Arsize  = io.AxiMaster1.AR.Arsize   
  val ArBurst = io.AxiMaster1.AR.ArBurst 
  val ArLock  = io.AxiMaster1.AR.ArLock  
  val ArCache = io.AxiMaster1.AR.ArCache 
  val ArProt  = io.AxiMaster1.AR.ArProt  
  val ArValid = io.AxiMaster1.AR.ArValid 

  val AwId     =io.AxiMaster1.AW.AwId     
  val AwAddr   =io.AxiMaster1.AW.AwAddr   
  val AwLen    =io.AxiMaster1.AW.AwLen    
  val Awsize   =io.AxiMaster1.AW.AwSize    
  val AwBurst  =io.AxiMaster1.AW.AwBurst  
  val AwLock   =io.AxiMaster1.AW.AwLock   
  val AwCache  =io.AxiMaster1.AW.AwCache  
  val AwProt   =io.AxiMaster1.AW.AwProt   
  val AwValid  =io.AxiMaster1.AW.AwValid
  
  val WId      =io.AxiMaster1.W.WId   
  val WData    =io.AxiMaster1.W.WData 
  val Wresp    =io.AxiMaster1.W.Wresp 
  val WLast    =io.AxiMaster1.W.WLast 
  val WValid   =io.AxiMaster1.W.WValid

  val Rready   =io.AxiMaster1.R.Rready
  val Bready   =io.AxiMaster1.B.Bready

val RId1     = io.AxiSlave1.R.RId
val Rresp1   = io.AxiSlave1.R.Rresp
val RLast1   = io.AxiSlave1.R.RLast
val AxiRData1= io.AxiSlave1.R.RData
val RValid1  = io.AxiSlave1.R.RValid
val Bid1     = io.AxiSlave1.B.Bid
val Bresp1   = io.AxiSlave1.B.Bresp
val Bvalid1  = io.AxiSlave1.B.Bvalid

val ArReady1 = io.AxiSlave1.AR.ArReady
val AwReady1 = io.AxiSlave1.AW.AwReady
val Wready1  = io.AxiSlave1.W.Wready

val RId2     = io.AxiSlave2.R.RId
val Rresp2   = io.AxiSlave2.R.Rresp
val RLast2   = io.AxiSlave2.R.RLast
val AxiRData2= io.AxiSlave2.R.RData
val RValid2  = io.AxiSlave2.R.RValid
val Bid2     = io.AxiSlave2.B.Bid
val Bresp2   = io.AxiSlave2.B.Bresp
val Bvalid2  = io.AxiSlave2.B.Bvalid

val ArReady2 = io.AxiSlave2.AR.ArReady
val AwReady2 = io.AxiSlave2.AW.AwReady
val Wready2  = io.AxiSlave2.W.Wready

    switch(WriteState){
        is(IDLE){
            when(AwValid && AwAddr(31,28) === SLAVE1DATAMEM){
              WriteState := SLAVE1
            }.elsewhen(AwValid && AwAddr(31,28) === SLAVE2APB){
              WriteState := SLAVE2
            }.otherwise{
              WriteState := IDLE
            }
  
        }
        is(SLAVE1){
          when(WLast){
             WriteState := IDLE
          }
        }
        is(SLAVE2){
          when(WLast){
             WriteState := IDLE
          }
            
        }
    }




   switch(ReadState){
        is(IDLE){
            when(ArValid && ArAddr(31,28) === SLAVE1DATAMEM){
              ReadState := SLAVE1
            }.elsewhen(ArValid && ArAddr(31,28) === SLAVE2APB){
              ReadState := SLAVE2
            }.otherwise{
              ReadState := IDLE
            }
  
        }
        is(SLAVE1){
          when(RLast1){
             ReadState := IDLE
          }
        }
        is(SLAVE2){
          when(RLast2){
             ReadState := IDLE
          }
            
        }
       }
     
io.AxiMaster1.R.RId      := 0.U(4.W)
io.AxiMaster1.R.Rresp    := 0.U(2.W)
io.AxiMaster1.R.RLast    := false.B
io.AxiMaster1.R.RData    := 0.U(32.W)
io.AxiMaster1.R.RValid   := false.B
io.AxiMaster1.B.Bid      := 0.U(4.W)
io.AxiMaster1.B.Bresp    := 0.U(2.W)
io.AxiMaster1.B.Bvalid   := false.B
io.AxiMaster1.AR.ArReady := false.B
io.AxiMaster1.AW.AwReady := false.B
io.AxiMaster1.W.Wready   := false.B

io.AxiSlave1.AR.ArId     := 0.U(4.W)
io.AxiSlave1.AR.ArAddr   := 0.U(32.W)
io.AxiSlave1.AR.ArLen    := 0.U(8.W)
io.AxiSlave1.AR.Arsize   := 0.U(2.W)
io.AxiSlave1.AR.ArBurst  := 0.U(2.W)
io.AxiSlave1.AR.ArLock   := 0.U(2.W)
io.AxiSlave1.AR.ArCache  := 0.U(4.W)
io.AxiSlave1.AR.ArProt   := 0.U(3.W)
io.AxiSlave1.AR.ArValid  := false.B
io.AxiSlave1.AW.AwId     := 0.U(4.W)
io.AxiSlave1.AW.AwAddr   := 0.U(32.W)
io.AxiSlave1.AW.AwLen    := 0.U(8.W)
io.AxiSlave1.AW.AwSize   := 0.U(2.W)
io.AxiSlave1.AW.AwBurst  := 0.U(2.W)
io.AxiSlave1.AW.AwLock   := 0.U(2.W)
io.AxiSlave1.AW.AwCache  := 0.U(4.W)
io.AxiSlave1.AW.AwProt   := 0.U(3.W)
io.AxiSlave1.AW.AwValid  := false.B
io.AxiSlave1.W.WId       := 0.U(4.W)
io.AxiSlave1.W.WData     := 0.U(32.W)
io.AxiSlave1.W.Wresp     := 0.U(2.W)
io.AxiSlave1.W.WLast     := false.B
io.AxiSlave1.W.WValid    := false.B
io.AxiSlave1.R.Rready    := false.B
io.AxiSlave1.B.Bready    := false.B

io.AxiSlave2.AR.ArId     := 0.U(4.W)
io.AxiSlave2.AR.ArAddr   := 0.U(32.W)
io.AxiSlave2.AR.ArLen    := 0.U(8.W)
io.AxiSlave2.AR.Arsize   := 0.U(4.W)
io.AxiSlave2.AR.ArBurst  := 0.U(2.W)
io.AxiSlave2.AR.ArLock   := 0.U(2.W)
io.AxiSlave2.AR.ArCache  := 0.U(4.W)
io.AxiSlave2.AR.ArProt   := 0.U(3.W)
io.AxiSlave2.AR.ArValid  := false.B
io.AxiSlave2.AW.AwId     := 0.U(4.W)
io.AxiSlave2.AW.AwAddr   := 0.U(32.W)
io.AxiSlave2.AW.AwLen    := 0.U(8.W)
io.AxiSlave2.AW.AwSize   := 0.U(2.W)
io.AxiSlave2.AW.AwBurst  := 0.U(2.W)
io.AxiSlave2.AW.AwLock   := 0.U(2.W)
io.AxiSlave2.AW.AwCache  := 0.U(4.W)
io.AxiSlave2.AW.AwProt   := 0.U(3.W)
io.AxiSlave2.AW.AwValid  := false.B
io.AxiSlave2.W.WId       := 0.U(4.W)
io.AxiSlave2.W.WData     := 0.U(32.W)
io.AxiSlave2.W.Wresp     := 0.U(2.W)
io.AxiSlave2.W.WLast     := false.B
io.AxiSlave2.W.WValid    := false.B
io.AxiSlave2.R.Rready    := false.B
io.AxiSlave2.B.Bready    := false.B




     when(WriteState === SLAVE1){
        io.AxiMaster1.AW <> io.AxiSlave1.AW
        io.AxiMaster1.W  <> io.AxiSlave1.W
        io.AxiMaster1.B  <> io.AxiSlave1.B
        
     }.elsewhen(WriteState === SLAVE2){
        io.AxiMaster1.AW <> io.AxiSlave2.AW
        io.AxiMaster1.W  <> io.AxiSlave2.W
        io.AxiMaster1.B  <> io.AxiSlave2.B
     }

     when(ReadState === SLAVE1){
        io.AxiMaster1.AR <> io.AxiSlave1.AR
        io.AxiMaster1.R  <> io.AxiSlave1.R
     }.elsewhen(ReadState === SLAVE2){
        io.AxiMaster1.AR <> io.AxiSlave2.AR
        io.AxiMaster1.R  <> io.AxiSlave2.R
     }

     io.DebugWriteState := WriteState
     io.DebugReadState  := ReadState 

}






