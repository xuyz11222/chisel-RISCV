import chisel3._
import chisel3.util._

class MemWb extends Bundle{
    val WData   = Output(UInt(32.W))
    val Rd      = Output(UInt(5.W))
    val WbReady = Input(Bool())
   
    
}

class MemData extends Bundle{
    val data_sram_rdata = Input(UInt(32.W))
    val data_ok         = Input(Bool())
    val data_addr_ok    = Input(Bool())
}

class CoreMem extends Module{
    val io = IO(new Bundle(){
    val Exe= Flipped(new ExeMem())
    val Wb = new MemWb()
    val Data = new MemData()
    
    val DebugWData = Output(UInt(32.W))
    val DebugRd_r  = Output(UInt(5.W))
    



    }
    )

val WbReady = io.Wb.WbReady
val Result  = io.Exe.Result
val Rd      = io.Exe.Rd 
val DataMemValid = io.Exe.DataMemValid
val LoadOp       = io.Exe.LoadOp
val ExeValid     = io.Exe.ExeValid
val WrValid      = io.Exe.WrValid
val RdBackData   = io.Data.data_sram_rdata
val DataOk       = io.Data.data_ok
val AddrOk       = io.Data.data_addr_ok


val WData = RegInit(0.U(32.W))
val Rd_r  = RegInit(0.U(5.W))



val WbData   = Wire(UInt(32.W))

val MemEn    = ExeValid && WbReady && ((DataOk || !DataMemValid) && (AddrOk || !WrValid))
val MemReady = MemEn 

 val ByteS  = LoadOp(0) === 1.U(1.W)
 val HalfS  = LoadOp(1) === 1.U(1.W)
 val WordS  = LoadOp(2) === 1.U(1.W)
 val ByteU  = LoadOp(3) === 1.U(1.W)
 val HalfU  = LoadOp(4) === 1.U(1.W)
  
  when(DataMemValid){
    when(ByteS){
      WbData := Cat(Fill(24,RdBackData(7)),RdBackData(7,0))
    }.elsewhen(HalfS){
      WbData := Cat(Fill(16,RdBackData(15)),RdBackData(15,0))
    }.elsewhen(WordS){
      WbData := RdBackData(31,0)
    }.elsewhen(ByteU){
      WbData := Cat(Fill(24,0.U(1.W)),RdBackData(7,0))
    }.elsewhen(HalfU){
      WbData := Cat(Fill(16,0.U(1.W)),RdBackData(15,0))
    }.otherwise{
      WbData := 0.U(32.W)
    }
  }.otherwise{
      WbData := Result
    }


when(MemEn){
    WData := WbData
    Rd_r  := Rd
    

   

}.otherwise{
    WData := WData
    Rd_r  := Rd_r
    
  
}


io.Exe.MemReady := MemReady
io.Wb.WData     := WData
io.Wb.Rd        := Rd_r
io.DebugWData        := WData
io.DebugRd_r         := Rd_r 

 


}
