import chisel3._
import chisel3.util._

class SocTop extends Module{
   val io = IO(new Bundle{
       val Instr   = new CpuInstr()
       val MemData = new AxiDataMem()
       val Debug = new CpuDebug()
     val DeBugAddrOk =Output(Bool())
     val DeBugDataOk =Output(Bool())
     val DeBugRData  =Output(UInt(32.W))
   }
   )

   val Cpu          = Module(new CoreTop())
   val SramAxi      = Module(new AxiMasterAxi())
   val DataMemSlave = Module(new DataMemSlave())

   Cpu.io.Axi <>SramAxi.io.Cpu
   
   SramAxi.io.AR <> DataMemSlave.io.AR 
   SramAxi.io.AW <> DataMemSlave.io.AW 
   SramAxi.io.R  <> DataMemSlave.io.R 
   SramAxi.io.W  <> DataMemSlave.io.W
   SramAxi.io.B  <> DataMemSlave.io.B 
  
    io.Instr.PreIfInstr.inst_sram_en      := Cpu.io.Instr.PreIfInstr.inst_sram_en
    io.Instr.PreIfInstr.inst_sram_wen     := Cpu.io.Instr.PreIfInstr.inst_sram_wen
    io.Instr.PreIfInstr.inst_sram_addr    := Cpu.io.Instr.PreIfInstr.inst_sram_addr
    io.Instr.PreIfInstr.inst_sram_wdata   := Cpu.io.Instr.PreIfInstr.inst_sram_wdata
    Cpu.io.Instr.InstrIf.inst_sram_rdata  := io.Instr.InstrIf.inst_sram_rdata  

    io.MemData.data_sram_en   := DataMemSlave.io.MemData.data_sram_en
    io.MemData.data_sram_wen  := DataMemSlave.io.MemData.data_sram_wen
    io.MemData.data_sram_addr := DataMemSlave.io.MemData.data_sram_addr
    io.MemData.data_sram_wdata:= DataMemSlave.io.MemData.data_sram_wdata
    DataMemSlave.io.MemData.data_sram_rdata := io.MemData.data_sram_rdata

    
io.Debug.DebugInstr      := Cpu.io.Debug.DebugInstr   
io.Debug.DebugPc         := Cpu.io.Debug.DebugPc      
io.Debug.DebugIfValid    := Cpu.io.Debug.DebugIfValid 
io.Debug.DebugIfEn       := Cpu.io.Debug.DebugIfEn  

io.Debug.Debug_alu_op    :=Cpu.io.Debug.Debug_alu_op    
io.Debug.Debug_data1     :=Cpu.io.Debug.Debug_data1     
io.Debug.Debug_data2     :=Cpu.io.Debug.Debug_data2     
io.Debug.Debug_mmu_en    :=Cpu.io.Debug.Debug_mmu_en    
io.Debug.Debug_mmu_wen   :=Cpu.io.Debug.Debug_mmu_wen   
io.Debug.Debug_mmu_op    :=Cpu.io.Debug.Debug_mmu_op    
io.Debug.Debug_mmu_RData2:=Cpu.io.Debug.Debug_mmu_RData2
io.Debug.Debug_pcu_en    :=Cpu.io.Debug.Debug_pcu_en    
io.Debug.Debug_pcu_op    :=Cpu.io.Debug.Debug_pcu_op    
io.Debug.Debug_pcu_data1 :=Cpu.io.Debug.Debug_pcu_data1 
io.Debug.Debug_pcu_data2 :=Cpu.io.Debug.Debug_pcu_data2 
io.Debug.Debug_rd_r      :=Cpu.io.Debug.Debug_rd_r      
io.Debug.Debug_csr_en    :=Cpu.io.Debug.Debug_csr_en    
io.Debug.Debug_csr_op    :=Cpu.io.Debug.Debug_csr_op    
io.Debug.Debug_csr_waddr :=Cpu.io.Debug.Debug_csr_waddr 
io.Debug.Debug_csr_data  :=Cpu.io.Debug.Debug_csr_data  
io.Debug.Debug_csr_imm   :=Cpu.io.Debug.Debug_csr_imm   
io.Debug.Debug_IdValid   :=Cpu.io.Debug.Debug_IdValid   
   

io.Debug.DebugResult       := Cpu.io.Debug.DebugResult      
io.Debug.DebugRd_r         := Cpu.io.Debug.DebugRd_r        
io.Debug.DebugDataEn       := Cpu.io.Debug.DebugDataEn      
io.Debug.DebugDataWen      := Cpu.io.Debug.DebugDataWen     
io.Debug.DebugDataWdata    := Cpu.io.Debug.DebugDataWdata   
io.Debug.DebugDataSize     := Cpu.io.Debug.DebugDataSize    
io.Debug.DebugDataMemValid := Cpu.io.Debug.DebugDataMemValid
io.Debug.DebugLoadOp       := Cpu.io.Debug.DebugLoadOp      
io.Debug.DebugPcJump       := Cpu.io.Debug.DebugPcJump      
io.Debug.DebugNextPc       := Cpu.io.Debug.DebugNextPc      
io.Debug.DebugCsrWAddr     := Cpu.io.Debug.DebugCsrWAddr    
io.Debug.DebugCsrWData     := Cpu.io.Debug.DebugCsrWData    
io.Debug.DebugExeValid     := Cpu.io.Debug.DebugExeValid    

io.Debug.DebugWData        := Cpu.io.Debug.DebugWData
io.Debug.DebugMemRd_r      := Cpu.io.Debug.DebugMemRd_r

io.DeBugAddrOk := SramAxi.io.DeBugAddrOk 
io.DeBugDataOk := SramAxi.io.DeBugDataOk 
io.DeBugRData  := SramAxi.io.DeBugRData  
   

}

object SocTop extends App {
  println("Generating the Soc hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new SocTop(), Array("--target-dir", "generated"))

}