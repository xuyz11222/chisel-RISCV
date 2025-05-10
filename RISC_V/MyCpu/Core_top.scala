
import chisel3._
import chisel3.util._

class CpuAxiMaster extends Bundle{
        
        val  ExeData    = new ExeData()
        val  DataMem    = new MemData()

}

class CpuInstr extends Bundle{
        val  PreIfInstr = new PreIfInstr()
        val  InstrIf    = new IfInstr()
}

class CpuDebug extends Bundle{
    val DebugInstr      = Output(UInt(32.W))
    val DebugPc         = Output(UInt(32.W))
    val DebugIfValid    = Output(Bool())
    val DebugIfEn       = Output(Bool())

    val Debug_alu_op    = Output(UInt(10.W))
    val Debug_data1     = Output(UInt(32.W))
    val Debug_data2     = Output(UInt(32.W))
    val Debug_mmu_en    = Output(Bool())
    val Debug_mmu_wen   = Output(UInt(1.W))
    val Debug_mmu_op    = Output(UInt(5.W))
    val Debug_mmu_RData2= Output(UInt(32.W))
    val Debug_pcu_en    = Output(Bool())
    val Debug_pcu_op    = Output(UInt(8.W))
    val Debug_pcu_data1 = Output(UInt(32.W))
    val Debug_pcu_data2 = Output(UInt(32.W))
    val Debug_rd_r      = Output(UInt(5.W))
    val Debug_csr_en    = Output(Bool())
    val Debug_csr_op    = Output(UInt(3.W))
    val Debug_csr_waddr = Output(UInt(12.W))
    val Debug_csr_data  = Output(UInt(32.W))
    val Debug_csr_imm   = Output(UInt(32.W))
    val Debug_IdValid   = Output(Bool())

    val DebugResult       = Output(UInt(32.W))
    val DebugRd_r         = Output(UInt(5.W))
    val DebugDataEn       = Output(Bool())
    val DebugDataWen      = Output(Bool())
    val DebugDataWdata    = Output(UInt(32.W))
    val DebugDataSize     = Output(UInt(2.W)) 
    val DebugDataMemValid = Output(Bool())
    val DebugLoadOp       = Output(UInt(5.W))
    val DebugPcJump       = Output(Bool())
    val DebugNextPc       = Output(UInt(32.W))
    val DebugCsrWAddr     = Output(UInt(12.W))
    val DebugCsrWData     = Output(UInt(32.W))
    val DebugExeValid     = Output(Bool())
    
    val DebugWData = Output(UInt(32.W))
    val DebugMemRd_r  = Output(UInt(5.W))
}


class CoreTop extends Module{
    val io = IO(new Bundle(){
        val Axi   = new CpuAxiMaster()
        val Instr = new CpuInstr()
        val Debug = new CpuDebug()
        //val  data_sram_en    = Input(1.W)
        //val  data_sram_wen   = Input(1.W) 
        //val  data_sram_addr  = Input(32.W)
        //val  data_sram_wdata = Input(32.W)   
        //val  data_sram_rdata = Output(32.W)
        
    }
    )

    val CorePreIf = Module(new CorePreIf())
    val CoreIf    = Module(new CoreIf())
    val CoreId    = Module(new CoreId())
    val CoreExe   = Module(new CoreExe())
    val CoreMem   = Module(new CoreMem())
    val CoreWb    = Module(new CoreWb())
    val RegFile   = Module(new RegFile())
    val CsrReg    = Module(new CsrReg())
    
    io.Instr.PreIfInstr.inst_sram_en      := CorePreIf.io.Instr.inst_sram_en
    io.Instr.PreIfInstr.inst_sram_wen     := CorePreIf.io.Instr.inst_sram_wen
    io.Instr.PreIfInstr.inst_sram_addr    := CorePreIf.io.Instr.inst_sram_addr
    io.Instr.PreIfInstr.inst_sram_wdata   := CorePreIf.io.Instr.inst_sram_wdata
    CoreIf.io.Instr.inst_sram_rdata := io.Instr.InstrIf.inst_sram_rdata  

    io.Axi.ExeData.data_sram_en   := CoreExe.io.Data.data_sram_en
    io.Axi.ExeData.data_sram_wen  := CoreExe.io.Data.data_sram_wen
    io.Axi.ExeData.data_sram_addr := CoreExe.io.Data.data_sram_addr
    io.Axi.ExeData.data_sram_wdata:= CoreExe.io.Data.data_sram_wdata
    io.Axi.ExeData.data_size      := CoreExe.io.Data.data_size

    CoreMem.io.Data.data_addr_ok    := io.Axi.DataMem.data_addr_ok
    CoreMem.io.Data.data_ok         := io.Axi.DataMem.data_ok
    CoreMem.io.Data.data_sram_rdata := io.Axi.DataMem.data_sram_rdata

    CorePreIf.io.If <> CoreIf.io.PreIf
    
    CoreIf.io.Id <> CoreId.io.If
    CoreId.io.Exe <> CoreExe.io.Id
    CoreId.io.RegFile <> RegFile.io.Id
    CoreExe.io.Mem <> CoreMem.io.Exe
    CoreMem.io.Wb  <> CoreWb.io.Mem
    CoreWb.io.RegFile <> RegFile.io.Wb

    CoreExe.io.If <> CoreIf.io.Exe
    CoreExe.io.PreIf <> CorePreIf.io.Exe

    CsrReg.io.Id  <> CoreId.io.CsrReg
    CsrReg.io.Exe <> CoreExe.io.CsrReg


io.Debug.DebugInstr      := CoreIf.io.DebugInstr   
io.Debug.DebugPc         := CoreIf.io.DebugPc      
io.Debug.DebugIfValid    := CoreIf.io.DebugIfValid 
io.Debug.DebugIfEn       := CoreIf.io.DebugIfEn  

io.Debug.Debug_alu_op    :=CoreId.io.Debug_alu_op    
io.Debug.Debug_data1     :=CoreId.io.Debug_data1     
io.Debug.Debug_data2     :=CoreId.io.Debug_data2     
io.Debug.Debug_mmu_en    :=CoreId.io.Debug_mmu_en    
io.Debug.Debug_mmu_wen   :=CoreId.io.Debug_mmu_wen   
io.Debug.Debug_mmu_op    :=CoreId.io.Debug_mmu_op    
io.Debug.Debug_mmu_RData2:=CoreId.io.Debug_mmu_RData2
io.Debug.Debug_pcu_en    :=CoreId.io.Debug_pcu_en    
io.Debug.Debug_pcu_op    :=CoreId.io.Debug_pcu_op    
io.Debug.Debug_pcu_data1 :=CoreId.io.Debug_pcu_data1 
io.Debug.Debug_pcu_data2 :=CoreId.io.Debug_pcu_data2 
io.Debug.Debug_rd_r      :=CoreId.io.Debug_rd_r      
io.Debug.Debug_csr_en    :=CoreId.io.Debug_csr_en    
io.Debug.Debug_csr_op    :=CoreId.io.Debug_csr_op    
io.Debug.Debug_csr_waddr :=CoreId.io.Debug_csr_waddr 
io.Debug.Debug_csr_data  :=CoreId.io.Debug_csr_data  
io.Debug.Debug_csr_imm   :=CoreId.io.Debug_csr_imm   
io.Debug.Debug_IdValid   :=CoreId.io.Debug_IdValid   
   

io.Debug.DebugResult       := CoreExe.io.DebugResult      
io.Debug.DebugRd_r         := CoreExe.io.DebugRd_r        
io.Debug.DebugDataEn       := CoreExe.io.DebugDataEn      
io.Debug.DebugDataWen      := CoreExe.io.DebugDataWen     
io.Debug.DebugDataWdata    := CoreExe.io.DebugDataWdata   
io.Debug.DebugDataSize     := CoreExe.io.DebugDataSize    
io.Debug.DebugDataMemValid := CoreExe.io.DebugDataMemValid
io.Debug.DebugLoadOp       := CoreExe.io.DebugLoadOp      
io.Debug.DebugPcJump       := CoreExe.io.DebugPcJump      
io.Debug.DebugNextPc       := CoreExe.io.DebugNextPc      
io.Debug.DebugCsrWAddr     := CoreExe.io.DebugCsrWAddr    
io.Debug.DebugCsrWData     := CoreExe.io.DebugCsrWData    
io.Debug.DebugExeValid     := CoreExe.io.DebugExeValid    

io.Debug.DebugWData        := CoreMem.io.DebugWData
io.Debug.DebugMemRd_r         := CoreMem.io.DebugRd_r 

}

