import chisel3._
import chisel3.util._

class AxiDataMem extends Bundle{
    val data_sram_en    = Output(Bool())
    val data_sram_wen   = Output(UInt(4.W)) 
    val data_sram_addr  = Output(UInt(32.W))
    val data_sram_wdata = Output(UInt(32.W)) 
    val data_sram_rdata = Input(UInt(32.W)) 
}


class DataMemSlave extends Module{
  val io =IO(new Bundle{
     val MemData = new AxiDataMem()
     val AR      = Flipped(new AR())
     val R       = Flipped(new R())
     val AW      = Flipped(new AW())
     val W       = Flipped(new W())
     val B       = Flipped(new B())
  }
  )
  val IDLE  = 0.U(2.W)
  val WRITEB= 1.U(2.W) 
  val WRITE = 2.U(2.W)
  val READ  = 3.U(2.W)


  


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

  val MemRData = io.MemData.data_sram_rdata

  val RegState  = RegInit(IDLE)
  val DataEn    = RegInit(false.B)
  val DataWen   = RegInit(0.U(4.W))
  val DataAddr  = RegInit(0.U(32.W))
  val MemWData  = RegInit(0.U(32.W))

  val RValid    = RegInit(false.B)
  val RLast     = RegInit(false.B)
  val Bvalid    = RegInit(false.B)
  val AxiRData  = RegInit(0.U(32.W))


  switch(RegState){
  is(IDLE){
    RLast    := false.B
    RValid   := false.B
    when(AwValid){
        RegState := WRITEB
        DataWen  := Mux(Awsize === "b00".U,"b0001".U,
                    Mux(Awsize === "b01".U,"b0011".U,
                    Mux(Awsize === "b11".U,"b1111".U,
                    "b0000".U)))
        DataEn   := false.B
        DataAddr := AwAddr

    }.elsewhen(ArValid){
        RegState := READ
        DataWen  := "b0000".U
        DataAddr := ArAddr
        DataEn   := true.B
    }.otherwise{
        DataEn   := false.B
        RegState := IDLE
        DataWen  := "b0000".U
        DataAddr := 0.U(32.W)
    }
    


  }
  is(WRITEB){
      when(Bready){
       RegState := WRITE
       Bvalid   := true.B
      }

    }
  is(WRITE){
    Bvalid   := false.B
    when(WLast){
      RegState := IDLE

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

io.MemData.data_sram_en     := DataEn
io.MemData.data_sram_wen    := DataWen
io.MemData.data_sram_addr   := DataAddr
io.MemData.data_sram_wdata  := MemWData
  







}