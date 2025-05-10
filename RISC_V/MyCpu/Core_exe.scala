
import chisel3._
import chisel3.util._

class ExeMem extends Bundle{
    val MemReady     = Input(Bool())
    val Result       = Output(UInt(32.W))
    val Rd           = Output(UInt(5.W))
    val WrValid      = Output(Bool())
    val DataMemValid = Output(Bool())
    val LoadOp       = Output(UInt(5.W))
    val ExeValid     = Output(Bool())
    
}

class ExeData extends Bundle{
    val data_sram_en    = Output(Bool())
    val data_sram_wen   = Output(Bool()) 
    val data_sram_addr  = Output(UInt(32.W))
    val data_sram_wdata = Output(UInt(32.W))  
    val data_size       = Output(UInt(2.W))
   
    

}

class ExeIf    extends Bundle{
    val PcJump = Output(Bool())
}
  
class ExePreIf extends Bundle{
    val PcJump = Output(Bool())
    val NextPc = Output(UInt(32.W)) 
}

class CoreExe extends Module{
    val io = IO(new Bundle(){ 
        val Mem = new ExeMem()
        val Id  =Flipped(new IdExe())
        val Data= new ExeData()
        val If  = new ExeIf()
        val PreIf = new ExePreIf()
        val CsrReg= Flipped(new CsrExe())

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


        
    }
    )
    val ALU = Module(new ALU())
    val Mmu = Module(new Mmu())
    val Pcu = Module(new Pcu())
    val Csru= Module(new Csru())


    val MemReady = io.Mem.MemReady
    val AluOp    = io.Id.AluOp
    val Data1    = io.Id.Data1
    val Data2    = io.Id.Data2
    val MmuEn    = io.Id.MmuEn
    val MmuWen   = io.Id.MmuWen
    val MmuOp    = io.Id.MmuOp
    val MmuRData2= io.Id.MmuRData2
    val PcuEn    = io.Id.PcuEn
    val PcuOp    = io.Id.PcuOp
    val PcuData1 = io.Id.PcuData1
    val PcuData2 = io.Id.PcuData2
    val Rd       = io.Id.Rd
    
    val CsrOp    = io.Id.CsrOp
    val CsrData  = io.Id.CsrData
    val CsrImm   = io.Id.CsrImm
    val IdValid  = io.Id.IdValid

    

    val Result       = RegInit(0.U(32.W))
    val Rd_r         = RegInit(0.U(5.W))
    val DataEn       = RegInit(false.B)
    val DataWen      = RegInit(false.B)
    val DataWdata    = RegInit(0.U(32.W))
    val DataSize     = RegInit(0.U(2.W)) 
    val DataMemValid = RegInit(false.B)
    val LoadOp       = RegInit(0.U(5.W))
    val PcJump       = RegInit(false.B)
    val NextPc       = RegInit(0.U(32.W))
    val CsrWAddr     = RegInit(0.U(12.W))
    val CsrWData     = RegInit(0.U(32.W))
    val ExeValid     = RegInit(false.B)

    
    val ExeEn        = (MemReady || !ExeValid) && IdValid
    val ExeReady     = ExeEn 
    
    ALU.io.op   := AluOp
    ALU.io.data1:= Data1
    ALU.io.data2:= Data2


    Mmu.io.MmuEn     := MmuEn
    Mmu.io.MmuWen    := MmuWen
    Mmu.io.MmuOp     := MmuOp
    Mmu.io.MmuRData2 := MmuRData2
    
    Pcu.io.PcuOp     := PcuOp
    Pcu.io.PcuData1  := PcuData1
    Pcu.io.PcuData2  := PcuData2 

    Csru.io.CsrOp    := CsrOp
    Csru.io.CsrData  := CsrData
    Csru.io.CsrImm   := CsrImm

    io.Data.data_sram_en   := DataEn && !MemReady
    io.Data.data_sram_wen  := DataWen
    io.Data.data_sram_addr := Result
    io.Data.data_sram_wdata:= DataWdata
    io.Data.data_size      := DataSize


    io.Mem.Result :=Result
    io.Mem.Rd     :=Rd_r
    io.Mem.DataMemValid := DataMemValid
    io.Mem.WrValid      := DataEn && DataWen
    io.Mem.LoadOp       := LoadOp
    io.Mem.ExeValid     := ExeValid

  

    io.Id.ExeReady:= ExeReady
    io.Id.PcJump  :=PcJump
    io.If.PcJump  :=PcJump
    io.PreIf.PcJump  :=PcJump
    io.PreIf.NextPc  :=NextPc

    io.CsrReg.CsrAddr := CsrWAddr
    io.CsrReg.CsrData := CsrWData
   
    when(PcJump ){
       Result := 0.U(32.W)
       Rd_r   := 0.U(5.W)
       DataEn     := false.B
       DataWen    := false.B
       DataWdata  := 0.U(32.W)
       DataSize   := "b00".U
       DataMemValid := false.B
       LoadOp       := 0.U(5.W)
       PcJump       := false.B
       NextPc       := 0.U(32.W)
       CsrWAddr     := 0.U(12.W)
       CsrWData     := 0.U(32.W)
       ExeValid     := false.B


    }.elsewhen(ExeEn){
        Result := Mux(io.Id.CsrEn,Csru.io.CsrWbData,Mux(PcuEn,Pcu.io.PcuResult,ALU.io.result))
        Rd_r   :=  Rd
        DataEn     := Mmu.io.data_sram_en
        DataWen    := Mmu.io.data_sram_wen
        DataWdata  := Mmu.io.data_sram_wdata
        DataSize   := Mmu.io.data_size
        DataMemValid := Mmu.io.DataMemValid
        LoadOp       := Mmu.io.LoadOp
        PcJump       := Pcu.io.PcJump
        NextPc       := ALU.io.result
        CsrWAddr     := io.Id.CsrWAddr
        CsrWData     := Csru.io.CsrWData
        ExeValid     := true.B

    
    }.elsewhen(MemReady && !ExeEn){
       ExeValid   := false.B
       DataEn     := false.B
    }.otherwise{
       Result := Result 
       Rd_r   := Rd_r
       DataEn     := DataEn
       DataWen    := DataWen
       DataWdata  := DataWdata
       DataSize   := DataSize
       DataMemValid := DataMemValid
       LoadOp       := LoadOp
       PcJump       := PcJump
       NextPc    := NextPc
       CsrWAddr     := CsrWAddr
       CsrWData     := CsrWData
       ExeValid     := ExeValid
    }

io.DebugResult       := Result      
io.DebugRd_r         := Rd_r        
io.DebugDataEn       := DataEn      
io.DebugDataWen      := DataWen     
io.DebugDataWdata    := DataWdata   
io.DebugDataSize     := DataSize    
io.DebugDataMemValid := DataMemValid
io.DebugLoadOp       := LoadOp      
io.DebugPcJump       := PcJump      
io.DebugNextPc       := NextPc      
io.DebugCsrWAddr     := CsrWAddr    
io.DebugCsrWData     := CsrWData    
io.DebugExeValid     := ExeValid    





    }

     

    






  

 


  
