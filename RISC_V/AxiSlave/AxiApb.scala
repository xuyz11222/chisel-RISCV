
import chisel3._
import chisel3.util._


class DataLedSlave extends Module{
  val io =IO(new Bundle{
     val Apb     = Flipped(new ApbSlave())
     val AR      = Flipped(new AR())
     val R       = Flipped(new R())
     val AW      = Flipped(new AW())
     val W       = Flipped(new W())
     val B       = Flipped(new B())
  }
  )
  val IDLE      = 0.U(3.W)
  val WRITEB    = 1.U(3.W) 
  val WRITE     = 2.U(3.W)
  val WRITELAST = 3.U(3.W)
  val READ      = 4.U(3.W)
  val ReadLAST  = 5.U(3.W)

  val StartAddr = 3.U(4.W)
  
  val ArId    = io.AR.ArId    
  val ArAddr  = io.AR.ArAddr  
  val ArLen   = io.AR.ArLen   
  val Arsize  = io.AR.Arsize   
  val ArBurst = io.AR.ArBurst 
  val ArLock  = io.AR.ArLock  
  val ArCache = io.AR.ArCache 
  val ArProt  = io.AR.ArProt  
  val ArValid = io.AR.ArValid 

  val AwId     =io.AW.AwId     
  val AwAddr   =io.AW.AwAddr   
  val AwLen    =io.AW.AwLen    
  val Awsize   =io.AW.Awize    
  val AwBurst  =io.AW.AwBurst  
  val AwLock   =io.AW.AwLock   
  val AwCache  =io.AW.AwCache  
  val AwProt   =io.AW.AwProt   
  val AwValid  =io.AW.AwValid
  
  val WId      =io.W.WId   
  val WData    =io.W.WData 
  val Wresp    =io.W.Wresp 
  val WLast    =io.W.WLast 
  val WValid   =io.W.WValid

  val Rready   =io.R.Rready
  val Bready   =io.B.Bready

  val PRData   = io.Apb.PRData
  val PReady   = io.Apb.PReady
  val PSlver   = io.Apb.PSlver



  val RegState  = RegInit(IDLE)

  val RValid    = RegInit(false.B) 
  val RLast     = RegInit(false.B)
  val Bvalid    = RegInit(false.B)
  val AxiWData  = RegInit(0.U(32.W))
  val AxiRData  = RegInit(0.U(32.W))

  val PAddr     = RegInit(0.U(32.W))
  val PWrite    = RegInit(false.B)
  val PSel      = RegInit(false.B)
  val PEnable   = RegInit(false.B)
  val PWData    = RegInit(0.U(32.W))


  switch(RegState){
  is(IDLE){
    RLast    := false.B
    RValid   := false.B
    PWrite   := false.B
    PSel     := false.B
    PEnable  := false.B
    PWData   := 0.U(32.W)
    when(AwValid){
        RegState := WRITEB 
        PAddr    := AwAddr

    }.elsewhen(ArValid){
        RegState := READ
        PAddr    := ArAddr
    }.otherwise{
        RegState := IDLE
        PAddr    := 0.U(32.W)
    }
    


  }
  is(WRITEB){
      when(Bready){
       RegState := WRITE
       Bvalid   := true.B
       PWrite   := true.B
       PSel     := true.B
       PEnable  := false.B
       PWData   := 0.U(32.W) 
      }

    }
  is(WRITE){
    Bvalid   := false.B
    PWrite   := true.B
    PSel     := true.B
    PEnable  := false.B
    when(WLast){
      RegState := WRITELAST

    }
    when(WValid){
     
      DataEn   := true.B
      DataWen  := DataWen
      DataAddr := DataAddr
      MemWData := WData

    }.otherwise{
      DataEn   := false.B
      DataWen  := DataWen
      DataAddr := DataAddr 
    }

     
  }
  is(READ){
    RValid   := true.B
    AxiRData := MemRData
    RegState := IDLE
    RLast    := true.B
  }
  }
  

  
io.R.RId      := 1.U(4.W)
io.R.Rresp    := 0.U(2.W)
io.R.RLast    := RLast
io.R.RData    := AxiRData
io.R.RValid   := RValid
io.B.Bid      := 1.U(4.W)
io.B.Bresp    := 0.U(2.W)
io.B.Bvalid   := Bvalid
io.AR.ArReady := RegState === IDLE
io.AW.AwReady := RegState === IDLE
io.W.Wready   := RegState === WRITE


  




}