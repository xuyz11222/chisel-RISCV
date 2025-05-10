
import chisel3._
import chisel3.util._


class PreIfIf extends Bundle{
    val IfReady = Input(Bool())
    val Pc      = Output(UInt(32.W))
}

class PreIfInstr extends Bundle{
        val  inst_sram_en    = Output(Bool())
        val  inst_sram_wen   = Output(UInt(4.W))
        val  inst_sram_addr  = Output(UInt(32.W))   
        val  inst_sram_wdata = Output(UInt(32.W))

}

class CorePreIf extends Module{
   val io = IO(new Bundle(){
        
        val  Instr      = new PreIfInstr()
        val  If         = new PreIfIf()
        val  Exe        = Flipped(new ExePreIf())

   }
   )

   val Jump    = io.Exe.PcJump
   val NextPc  = io.Exe.NextPc
   val Pc      = RegInit(0.U(32.W))
   val IfReady = io.If.IfReady


   when(Jump){
    Pc:=NextPc
   }.elsewhen(IfReady){
    Pc:=Pc + 4.U
   }.otherwise{
    Pc:= Pc
   }
   
   io.Instr.inst_sram_en    := IfReady
   io.Instr.inst_sram_wen   := 0.U(4.W)
   io.Instr.inst_sram_addr  := Pc
   io.Instr.inst_sram_wdata := 0.U
   io.If.Pc                 := Pc




   


}