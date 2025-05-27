import chisel3._
import chisel3.util._

class SocTop extends Module{
   val io = IO(new Bundle{
       val Instr   = new CpuInstr()
       val MemData = new AxiDataMem()
       val Led     = new Led()
       val Debug = new CpuDebug()

     val DeBugAddrOk =Output(Bool())
     val DeBugDataOk =Output(Bool())
     val DeBugRData  =Output(UInt(32.W))
     val DebugRegState  = Output(UInt(3.W))
     val DebugArAddr    = Output(UInt(32.W))
     val DebugArsize    = Output(UInt(2.W))
     val DebugArValid   = Output(Bool())
     val DebugAwAddr    = Output(UInt(32.W))
     val DebugAwsize    = Output(UInt(2.W))
     val DebugAwValid   = Output(Bool())
     val DebugWData     = Output(UInt(32.W))
     val DebugWLast     = Output(Bool())
     val DebugWValid    = Output(Bool())
     val DebugWriteState= Output(UInt(2.W))
     val DebugReadState = Output(UInt(2.W))
     val DebugAxiState  = Output(UInt(3.W))
     val DebugApbState  = Output(UInt(3.W))
     val DebugPAddr     = Output(UInt(32.W))
     val DebugPWrite    = Output(Bool())
     val DebugPSel      = Output(Bool())
     val DebugPEnable   = Output(Bool())
     val DebugPWData    = Output(UInt(32.W))

   }
   )

   val Cpu          = Module(new CoreTop())
   val SramAxi      = Module(new AxiMasterAxi())
   val AxiMux       = Module(new AxiMux())
   val AxiApb       = Module(new AxiApb())
   val LedSlave     = Module(new LedSlave())
   val DataMemSlave = Module(new DataMemSlave())

   Cpu.io.Axi <>SramAxi.io.Cpu
   
   SramAxi.io.AR <> AxiMux.io.AxiMaster1.AR 
   SramAxi.io.AW <> AxiMux.io.AxiMaster1.AW 
   SramAxi.io.R  <> AxiMux.io.AxiMaster1.R 
   SramAxi.io.W  <> AxiMux.io.AxiMaster1.W
   SramAxi.io.B  <> AxiMux.io.AxiMaster1.B 


   AxiMux.io.AxiSlave1.AR  <> DataMemSlave.io.AR
   AxiMux.io.AxiSlave1.AW  <> DataMemSlave.io.AW  
   AxiMux.io.AxiSlave1.R   <> DataMemSlave.io.R  
   AxiMux.io.AxiSlave1.W   <> DataMemSlave.io.W 
   AxiMux.io.AxiSlave1.B   <> DataMemSlave.io.B  
   
   AxiMux.io.AxiSlave2.AR  <> AxiApb.io.AR
   AxiMux.io.AxiSlave2.AW  <> AxiApb.io.AW  
   AxiMux.io.AxiSlave2.R   <> AxiApb.io.R  
   AxiMux.io.AxiSlave2.W   <> AxiApb.io.W 
   AxiMux.io.AxiSlave2.B   <> AxiApb.io.B 

   AxiApb.io.Apb           <> LedSlave.io.Apb
   
  
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
    
    io.Led.Led   := LedSlave.io.Led.Led 
     
     
io.DebugAxiState := AxiApb.io.DebugAxiState 
io.DebugApbState := AxiApb.io.DebugApbState 
io.DebugPAddr    := AxiApb.io.DebugPAddr    
io.DebugPWrite   := AxiApb.io.DebugPWrite   
io.DebugPSel     := AxiApb.io.DebugPSel     
io.DebugPEnable  := AxiApb.io.DebugPEnable  
io.DebugPWData   := AxiApb.io.DebugPWData   





    
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

io.DebugRegState  := SramAxi.io.DebugRegState 
io.DebugArAddr    := SramAxi.io.DebugArAddr   
io.DebugArsize    := SramAxi.io.DebugArsize   
io.DebugArValid   := SramAxi.io.DebugArValid  
io.DebugAwAddr    := SramAxi.io.DebugAwAddr   
io.DebugAwsize    := SramAxi.io.DebugAwsize   
io.DebugAwValid   := SramAxi.io.DebugAwValid  
io.DebugWData     := SramAxi.io.DebugWData    
io.DebugWLast     := SramAxi.io.DebugWLast    
io.DebugWValid    := SramAxi.io.DebugWValid 

io.DebugWriteState := AxiMux.io.DebugWriteState
io.DebugReadState  := AxiMux.io.DebugReadState 
   

}

object SocTop extends App {
  println("Generating the Soc hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new SocTop(), Array("--target-dir", "generated"))

}