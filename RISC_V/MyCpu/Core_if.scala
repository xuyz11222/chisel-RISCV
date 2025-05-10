import chisel3._
import chisel3.util._


class IfId extends Bundle{
    val IdReady = Input(Bool())
    val IfInstr = Output(UInt(32.W))
    val Pc      = Output(UInt(32.W))
    val IfValid = Output(Bool())
}

class IfInstr extends Bundle{
    val  inst_sram_rdata = Input(UInt(32.W))
}

class CoreIf extends Module{
   val io = IO(new Bundle(){
        
        val  Instr      = new IfInstr()
        val  Id         = new IfId()
        val  PreIf      = Flipped(new PreIfIf())
        val  Exe        = Flipped(new ExeIf())
        
        val DebugInstr      = Output(UInt(32.W))
        val DebugPc         = Output(UInt(32.W))
        val DebugIfValid    = Output(Bool())
        val DebugIfEn       = Output(Bool())
          

   }
   )
   val IdReady = io.Id.IdReady 
   

   val Instr   =RegInit(0.U(32.W))
   val Pc      =RegInit(0.U(32.W))
   val IfValid =RegInit(false.B)
   val IfEn = IdReady || !IfValid

   when(io.Exe.PcJump){
    Instr:= 0.U(32.W)
    Pc   := 0.U(32.W)
    IfValid := false.B
   }.elsewhen(IfEn){
    Instr:= io.Instr.inst_sram_rdata
    Pc   := io.PreIf.Pc
    IfValid := true.B
   }.otherwise{
    Instr   := Instr
    Pc      := Pc
    IfValid := IfValid
   }
   
   io.PreIf.IfReady := IfEn
   io.Id.IfInstr    := Instr
   io.Id.Pc         := Pc
   io.Id.IfValid    := IfValid
io.DebugInstr      := Instr   
io.DebugPc         := Pc      
io.DebugIfValid    := IfValid 
io.DebugIfEn       := IfEn    




   }
   
   


