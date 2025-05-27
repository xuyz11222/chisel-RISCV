
import chisel3._
import chisel3.util._


class AxiApb extends Module{
  val io =IO(new Bundle(){
     val Apb     = Flipped(new ApbSlave())
     val AR      = Flipped(new AR())
     val R       = Flipped(new R())
     val AW      = Flipped(new AW())
     val W       = Flipped(new W())
     val B       = Flipped(new B())

     val DebugAxiState  = Output(UInt(3.W))
     val DebugApbState  = Output(UInt(3.W))
     val DebugPAddr     = Output(UInt(32.W))
     val DebugPWrite    = Output(Bool())
     val DebugPSel      = Output(Bool())
     val DebugPEnable   = Output(Bool())
     val DebugPWData    = Output(UInt(32.W))

  }
  )
  val IDLE   = 0.U(3.W)
  val SetUp  = 1.U(3.W)
  val Access = 2.U(3.W)

  val WRITEB   = 1.U(3.W) 
  val WRITE    = 2.U(3.W)
  val WRITEWAIT= 3.U(3.W)
  val WRITELAST= 4.U(3.W)
  val READ     = 5.U(3.W)

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
  val Awsize   =io.AW.AwSize 
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




  val AxiState  = RegInit(IDLE)
  val ApbState  = RegInit(IDLE)

  val RValid    = RegInit(false.B) 
  val RLast     = RegInit(false.B)
  val Bvalid    = RegInit(false.B)
  val AxiRData  = RegInit(0.U(32.W))

  val PAddr     = RegInit(0.U(32.W))
  val PWrite    = Wire(Bool())
  val PSel      = Wire(Bool())
  val PEnable   = Wire(Bool())
  val PWData    = RegInit(0.U(32.W))


  switch(ApbState){
  is(IDLE){
    PWrite   := false.B
    PSel     := false.B
    PEnable  := false.B
    PWData   := 0.U(32.W)
    when(AwValid || ArValid){
        ApbState := SetUp 
    }.otherwise{
        ApbState := IDLE
    }
    


  }
  is(SetUp){
      
      when(WValid || AxiState === READ){
       ApbState := Access
      }.otherwise{
       ApbState := SetUp
    }

    }
  is(Access){
    when(PReady){
         when( AxiState === WRITELAST || RLast ){
           ApbState := IDLE
         }.otherwise{
           ApbState := SetUp
         }
    }.otherwise{
      ApbState := Access
    }

     
  }
 
  }

  
  switch(AxiState){
     is(IDLE){
      Bvalid   := false.B
      RLast    := false.B
      RValid   := false.B
      AxiRData := 0.U(32.W)
       when(AwValid){
           AxiState := WRITEB 
           PAddr    := AwAddr
       }.elsewhen(ArValid){
           AxiState := READ 
           PAddr    := ArAddr
       }.otherwise{
           AxiState := IDLE
           PAddr    := 0.U(32.W)
       }
       
   
   
     }
     is(WRITEB){
         when(Bready){
          AxiState := WRITE
          Bvalid   := true.B
         }.otherwise{
          AxiState := WRITEB
          Bvalid   := false.B
       }
   
       }
     is(WRITE){
       Bvalid   := false.B
       when(WLast){
          AxiState := WRITELAST
        }.elsewhen(WValid){
          AxiState := WRITEWAIT
        }.otherwise{
          AxiState := WRITE
       }
       when(WValid){
          PWData := WData
         }.otherwise{
          PWData := 0.U(32.W)
        }
   
        
     }
     is(WRITEWAIT){
         Bvalid   := false.B
         when(PReady){
          AxiState := WRITE
          PWData   := 0.U(32.W)
          }.otherwise{
          AxiState := WRITEWAIT
          PWData   := PWData
          }
     }
     is(WRITELAST){
         Bvalid   := false.B
         when(PReady){
          AxiState := IDLE
          PWData := 0.U(32.W)
          }.otherwise{
          AxiState := WRITELAST
          PWData   := PWData
          }
    }
     is(READ){
          when(PReady){
          RLast    := true.B
          RValid   := true.B
          AxiRData := PRData
          }.otherwise{
          RLast    := false.B
          RValid   := false.B
          AxiRData := 0.U(32.W)
          }
          when(RLast){
          AxiState := IDLE
          }.otherwise{
          AxiState := READ
          }
     }
 
  }
  
  when (ApbState === SetUp){
    
    PSel    := true.B
    PEnable := false.B

  }.elsewhen(ApbState === Access){
   
    PSel    := true.B
    PEnable := true.B

  }.otherwise{
    
    PSel    := false.B
    PEnable := false.B

  }

  when (AxiState === WRITE || AxiState === WRITELAST){
    
    PWrite   := true.B
    

  }.otherwise{
    
    PWrite    := false.B
    

  }


  

  
io.R.RId      := 1.U(4.W)
io.R.Rresp    := 0.U(2.W)
io.R.RLast    := RLast
io.R.RData    := AxiRData
io.R.RValid   := RValid
io.B.Bid      := 1.U(4.W)
io.B.Bresp    := 0.U(2.W)
io.B.Bvalid   := Bvalid
io.AR.ArReady := AxiState === IDLE
io.AW.AwReady := AxiState === IDLE
io.W.Wready   := AxiState === WRITE 

io.Apb.PAddr     :=  PAddr    
io.Apb.PWrite    :=  PWrite   
io.Apb.PSel      :=  PSel     
io.Apb.PEnable   :=  PEnable  
io.Apb.PWData    :=  PWData 

io.DebugAxiState := AxiState
io.DebugApbState := ApbState
io.DebugPAddr    := PAddr   
io.DebugPWrite   := PWrite  
io.DebugPSel     := PSel    
io.DebugPEnable  := PEnable 
io.DebugPWData   := PWData  
  




}