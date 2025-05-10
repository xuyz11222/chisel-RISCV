import chisel3._
import chisel3.util._


class AR extends Bundle{
   val ArId    = Output(UInt(4.W))
   val ArAddr  = Output(UInt(32.W))
   val ArLen   = Output(UInt(8.W))
   val Arsize  = Output(UInt(2.W))
   val ArBurst = Output(UInt(2.W))
   val ArLock  = Output(UInt(2.W))
   val ArCache = Output(UInt(4.W))
   val ArProt  = Output(UInt(3.W))
   val ArValid = Output(Bool())
   val ArReady = Input(Bool())

}

class R extends Bundle{
    val RId     = Input(UInt(4.W))
    val RData   = Input(UInt(32.W))
    val Rresp   = Input(UInt(2.W))
    val RLast   = Input(Bool())
    val RValid  = Input(Bool())
    val Rready  = Output(Bool())
}

class AW extends Bundle{
   val AwId    = Output(UInt(4.W))
   val AwAddr = Output(UInt(32.W))
   val AwLen   = Output(UInt(8.W))
   val Awize   = Output(UInt(3.W))
   val AwBurst = Output(UInt(2.W))
   val AwLock  = Output(UInt(2.W))
   val AwCache = Output(UInt(4.W))
   val AwProt  = Output(UInt(3.W))
   val AwValid = Output(Bool())
   val AwReady = Input(Bool())
}

class W extends Bundle{
    val WId     = Output(UInt(4.W))
    val WData   = Output(UInt(32.W))
    val Wresp   = Output(UInt(2.W))
    val WLast   = Output(Bool())
    val WValid  = Output(Bool())
    val Wready  = Input(Bool())
}

class B extends Bundle{
    val Bid     = Input(UInt(4.W)) 
    val Bresp   = Input(UInt(2.W))
    val Bvalid  = Input(Bool())
    val Bready  = Output(Bool())
}

class AxiMasterAxi extends Module{
    val io =IO(new Bundle{
     val Cpu = Flipped(new CpuAxiMaster())
     val AR  = new AR()
     val R   = new R()
     val AW  = new AW()
     val W   = new W()
     val B   = new B()

     val DeBugAddrOk =Output(Bool())
     val DeBugDataOk =Output(Bool())
     val DeBugRData  =Output(UInt(32.W))

    }
    )


val RId     = io.R.RId
val Rresp   = io.R.Rresp
val RLast   = io.R.RLast
val AxiRData= io.R.RData
val RValid  = io.R.RValid
val Bid     = io.B.Bid
val Bresp   = io.B.Bresp
val Bvalid  = io.B.Bvalid

val ArReady = io.AR.ArReady
val AwReady = io.AW.AwReady
val Wready  = io.W.Wready

val DataMemEn    = io.Cpu.ExeData.data_sram_en
val DataMemWen   = io.Cpu.ExeData.data_sram_wen
val DataMemAddr  = io.Cpu.ExeData.data_sram_addr
val DataMemWdata = io.Cpu.ExeData.data_sram_wdata
val DataSize     = io.Cpu.ExeData.data_size


  val IDLE     = 0.U(3.W)
  val WRITEREQ = 1.U(3.W)
  val WRITE    = 2.U(3.W)
  val READREQ  = 3.U(3.W)
  val READ     = 4.U(3.W)

  
  val RegState  = RegInit(IDLE)
  val ArAddr    = RegInit(0.U(32.W))
  val Arsize    = RegInit(0.U(2.W))
  val ArValid   = RegInit(false.B)

  val AwAddr    = RegInit(0.U(32.W))
  val Awsize     = RegInit(0.U(2.W))
  val AwValid   = RegInit(false.B)

  val WData     = RegInit(0.U(32.W))
  val WLast     = RegInit(false.B)
  val WValid    = RegInit(false.B)

  val AddrOk    = RegInit(false.B)
  val DataOk    = RegInit(false.B)
  val RData     = RegInit(0.U(32.W))


  switch(RegState){
  is(IDLE){
    DataOk   := false.B
    AddrOk   := false.B
    WData    := 0.U(32.W)
    WLast    := false.B
    WValid   := false.B
    when(DataMemEn && DataMemWen){
        RegState := WRITEREQ
        AwAddr   := DataMemAddr
        Awsize    := DataSize
        AwValid  := true.B
        ArAddr   := 0.U(32.W)
        Arsize   := 0.U(2.W)
        ArValid  := false.B

    }.elsewhen(DataMemEn && !DataMemWen){
        RegState := READ
        ArAddr   := DataMemAddr
        Arsize   := DataSize
        ArValid  := true.B
        AwAddr   := 0.U(32.W)
        Awsize   := 0.U(2.W)
        AwValid  := false.B
        
    }.otherwise{
        RegState := IDLE
        AwAddr   := 0.U(32.W)
        Awsize   := 0.U(2.W)
        AwValid  := false.B
        ArAddr   := 0.U(32.W)
        Arsize   := 0.U(2.W)
        ArValid  := false.B
        
    } 



  }
  
  is(WRITEREQ){
    when(Bvalid){
      RegState := WRITE
      AwAddr   := 0.U(32.W)
      Awsize   := 0.U(2.W)
      AwValid  := false.B
      

    }.otherwise{
      RegState := WRITEREQ

    }

     
  }
  is(WRITE){
     
     AddrOk   := true.B
     WData    := DataMemWdata
     WLast    := true.B
     WValid   := true.B
     RegState := IDLE
  }

  is(READ){
      
      when(RLast){
        RegState := IDLE
      }
      when(RValid){
        DataOk := true.B
        RData  := AxiRData
      }.otherwise{
        DataOk := false.B
        RData  := 0.U(32.W)
      }

      
  }
  }


io.AR.ArId     := 1.U(4.W)
io.AR.ArAddr   := ArAddr
io.AR.ArLen    := 0.U(8.W)
io.AR.Arsize   := Arsize
io.AR.ArBurst  := 1.U(2.W)
io.AR.ArLock   := 0.U(2.W)
io.AR.ArCache  := 0.U(4.W)
io.AR.ArProt   := 0.U(3.W)
io.AR.ArValid  := ArValid

io.AW.AwId     := 1.U(4.W)
io.AW.AwAddr   := AwAddr
io.AW.AwLen    := 0.U(8.W)
io.AW.Awize    := Awsize
io.AW.AwBurst  := 1.U(2.W)
io.AW.AwLock   := 0.U(2.W)
io.AW.AwCache  := 0.U(4.W)
io.AW.AwProt   := 0.U(3.W)
io.AW.AwValid  := AwValid

io.W.WId       := 1.U(4.W)
io.W.WData     := WData
io.W.Wresp     := 0.U(2.W)
io.W.WLast     := WLast
io.W.WValid    := WValid

io.R.Rready    := true.B
io.B.Bready    := true.B

io.Cpu.DataMem.data_addr_ok     := AddrOk
io.Cpu.DataMem.data_ok          := DataOk 
io.Cpu.DataMem.data_sram_rdata  := RData 
io.DeBugAddrOk :=AddrOk
io.DeBugDataOk :=DataOk
io.DeBugRData  :=RData 

  



}
























