import chisel3._
import chisel3.util._

class IdExe extends Bundle{
    
    val AluOp     = Output(UInt(10.W) )
    val Data1     = Output(UInt(32.W))
    val Data2     = Output(UInt(32.W))
    val MmuEn     = Output(Bool())
    val MmuWen    = Output(UInt(1.W) )
    val MmuOp     = Output(UInt(5.W))
    val MmuRData2 = Output(UInt(32.W))
    val PcuEn     = Output(Bool())
    val PcuOp     = Output(UInt(8.W))
    val PcuData1  = Output(UInt(32.W))
    val PcuData2  = Output(UInt(32.W))
    val Rd        = Output(UInt(5.W))
    val ExeReady  = Input(Bool())
    val PcJump    = Input(Bool())
    
    val CsrEn     = Output(Bool())
    val CsrOp     = Output(UInt(3.W))
    val CsrWAddr  = Output(UInt(12.W))
    val CsrData   = Output(UInt(32.W))
    val CsrImm    = Output(UInt(32.W))

    val IdValid   = Output(Bool())
    
}

class CoreId extends Module {
    val io =IO(new Bundle(){
         val  If        = Flipped(new IfId())
         val  Exe       = new IdExe()
         val  RegFile   = Flipped(new RegFileId())
         val  CsrReg    = Flipped(new CsrId())

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
    })




val alu_op    = RegInit(0.U(10.W))
val data1     = RegInit(0.U(32.W))
val data2     = RegInit(0.U(32.W))
val mmu_en    = RegInit(false.B)
val mmu_wen   = RegInit(0.U(1.W))
val mmu_op    = RegInit(0.U(5.W))
val mmu_RData2= RegInit(0.U(32.W))
val pcu_en    = RegInit(false.B)
val pcu_op    = RegInit(0.U(8.W))
val pcu_data1 = RegInit(0.U(32.W))
val pcu_data2 = RegInit(0.U(32.W))
val rd_r      = RegInit(0.U(5.W))
val csr_en    = RegInit(false.B)
val csr_op    = RegInit(0.U(3.W))
val csr_waddr = RegInit(0.U(12.W))
val csr_data  = RegInit(0.U(32.W))
val csr_imm   = RegInit(0.U(32.W))
val IdValid   = RegInit(false.B)


val IdInstr   = io.If.IfInstr
val Pc        = io.If.Pc
val IfValid   = io.If.IfValid

val ExeReady = io.Exe.ExeReady


val RData1    = io.RegFile.RData1
val RData2    = io.RegFile.RData2
val RValid    = io.RegFile.RValid


val IdEn     = (ExeReady || !IdValid ) && RValid && IfValid
val IdReady  = IdEn 

val CsrData   = Mux(io.CsrReg.CsrAddr === csr_waddr, csr_imm , io.CsrReg.CsrData)  

val opcode = IdInstr(6,0)
val rd     = IdInstr(11,7)
val fuct3  = IdInstr(14,12)
val rs1    = IdInstr(19,15)
val rs2    = IdInstr(24,20)
val fuct7  = IdInstr(31,25)

val R_op = opcode === "b0110011".U
val I_op = opcode === "b0010011".U
val S_op = opcode === "b0100011".U //Store
val L_op = opcode === "b0000011".U //Load
val B_op = opcode === "b1100011".U

val jal    = opcode === "b1101111".U 
val lui    = opcode === "b0110111".U 
val auipc  = opcode === "b0010111".U
val jalr   = opcode === "b1100111".U

val R_type = R_op 
val I_type = I_op||L_op||jalr 
val S_type = S_op
val B_type = B_op
val U_type = lui || auipc 
val J_type = jal

val csr_opcode = opcode === "b1110011".U

val imm    = Mux(I_type,Cat(Fill(20,IdInstr(31)),IdInstr(31,20)),
             Mux(S_type,Cat(Fill(20,IdInstr(31)),Cat(IdInstr(31,25),IdInstr(11,7))),
             Mux(B_type,Cat(Fill(19,IdInstr(31)),Cat(Cat( Cat(IdInstr(31),IdInstr(7)) , Cat(IdInstr(30,25),IdInstr(11,8)) ),0.U(1.W))),
             Mux(U_type,Cat(IdInstr(31,12),0.U(12.W)),
             Mux(J_type,Cat( Cat(Fill(11,IdInstr(31)),Cat(IdInstr(31),IdInstr(19,12))) , Cat(Cat(IdInstr(20),IdInstr(30,21)) ,0.U(1.W))),
             0.U(32.W))))))


//ALU

val add    =    Mux((R_op && fuct3 === 0.U    && fuct7 === 0.U)  || (I_op && fuct3 === 0.U )||L_op||S_op||B_op|| jal || jalr || lui || auipc,1.U,0.U)
val sub    =    Mux((R_op && fuct3 === 0.U    && fuct7 === "h20".U)  ,1.U,0.U)
val slt    =    Mux((R_op && fuct3 === "h2".U && fuct7 === 0.U) || (I_op && fuct3 === "h2".U ),1.U,0.U)
val sltu   =    Mux((R_op && fuct3 === "h3".U && fuct7 === 0.U) || (I_op && fuct3 === "h3".U )  ,1.U,0.U) 
val and    =    Mux((R_op && fuct3 === "h7".U && fuct7 === 0.U) || (I_op && fuct3 === "h7".U )  ,1.U,0.U)
val or     =    Mux((R_op && fuct3 === "h6".U && fuct7 === 0.U)  || (I_op && fuct3 === "h6".U ) ,1.U,0.U) 
val xor    =    Mux((R_op && fuct3 === "h4".U && fuct7 === 0.U) || (I_op && fuct3 === "h4".U )  ,1.U,0.U)
val sll    =    Mux((R_op && fuct3 === "h1".U && fuct7 === 0.U) || (I_op && fuct3 === "h1".U && fuct7 ===0.U),1.U,0.U)
val srl    =    Mux((R_op && fuct3 === "h5".U && fuct7 === 0.U) || (I_op && fuct3 === "h5".U && fuct7 ===0.U),1.U,0.U)
val sra    =    Mux((R_op && fuct3 === "h5".U && fuct7 === "h20".U) || (I_op && fuct3 === "h5".U && fuct7 === "h20".U),1.U,0.U)

//MMU
val ByteS  =  (L_op || S_op) && fuct3 === "h0".U
val HalfS  =  (L_op || S_op) && fuct3 === "h1".U
val WordS  =  (L_op || S_op) && fuct3 === "h2".U
val ByteU  =  (L_op || S_op) && fuct3 === "h4".U
val HalfU  =  (L_op || S_op) && fuct3 === "h5".U

// PCU

val beq    =  B_op && fuct3 === "h0".U
val bne    =  B_op && fuct3 === "h1".U
val blt    =  B_op && fuct3 === "h4".U
val bge    =  B_op && fuct3 === "h5".U
val bltu   =  B_op && fuct3 === "h6".U
val bgeu   =  B_op && fuct3 === "h7".U

//Csr

val csrrw  = csr_opcode && fuct3 === "h1".U 
val csrrs  = csr_opcode && fuct3 === "h2".U
val csrrc  = csr_opcode && fuct3 === "h3".U
val csrrwi = csr_opcode && fuct3 === "h5".U
val csrrsi = csr_opcode && fuct3 === "h6".U
val csrrci = csr_opcode && fuct3 === "h7".U

val csri   = csr_opcode && fuct3(2) === 1.U(1.W)
val csrr   = csr_opcode && fuct3(2) === 0.U(1.W)
val csr    = IdInstr(31,20)
val zimm   = Cat(0.U(27.W),IdInstr(19,15))


io.If.IdReady:= IdReady

io.RegFile.Rs1:=Mux(R_type||I_type||S_type||B_type||csrr,rs1,0.U)
io.RegFile.Rs2:=Mux(R_type||S_type||B_type,rs2,0.U)
io.RegFile.Rd :=Mux(R_type||I_type||U_type||J_type||csr_opcode,rd,0.U)

io.Exe.AluOp     := alu_op
io.Exe.Data1     := data1
io.Exe.Data2     := data2
io.Exe.MmuEn     := mmu_en
io.Exe.MmuWen    := mmu_wen
io.Exe.MmuOp     := mmu_op
io.Exe.MmuRData2 := mmu_RData2

io.Exe.Rd        := rd_r
io.Exe.PcuEn     := pcu_en   
io.Exe.PcuOp     := pcu_op   
io.Exe.PcuData1  := pcu_data1
io.Exe.PcuData2  := pcu_data2

io.Exe.CsrEn     := csr_en
io.Exe.CsrOp     := csr_op
io.Exe.CsrWAddr  := csr_waddr
io.Exe.CsrData   := csr_data
io.Exe.CsrImm    := csr_imm

io.Exe.IdValid   := IdValid

io.CsrReg.CsrAddr:= Mux(csr_opcode,csr,0.U(12.W))



when(io.Exe.PcJump){
    alu_op   :=  0.U(10.W)
    data1    :=  0.U(32.W)
    data2    :=  0.U(32.W)
    mmu_en   :=  false.B
    mmu_wen  :=  0.U(1.W)
    mmu_RData2:= 0.U(32.W)
    pcu_en   :=  false.B
    pcu_op   :=  0.U(8.W)
    pcu_data1:=  0.U(32.W) 
    pcu_data2:=  0.U(32.W)
    rd_r     :=  0.U(5.W)
    csr_en   :=  false.B
    csr_op   :=  0.U(3.W)
    csr_waddr:=  0.U(12.W)
    csr_data :=  0.U(32.W)
    csr_imm  :=  0.U(32.W)
    IdValid  :=  false.B

}.elsewhen(IdEn){
    alu_op    :=  Cat(Cat(Cat(Cat(Cat(Cat(Cat(Cat(Cat(sra,srl),sll),xor),or),and),sltu),slt),sub),add)
    data1     :=  Mux(auipc|| B_op || jal ,Pc,Mux(lui,0.U(32.W),RData1))
    data2     :=  Mux(R_type,RData2,imm)
    mmu_en    :=  L_op || S_op
    mmu_wen   :=  S_op
    mmu_op    :=  Cat(Cat(Cat(Cat(HalfU,ByteU),WordS),HalfS),ByteS)
    mmu_RData2:=  Mux(S_op,RData2,0.U(32.W))
    pcu_en   :=   B_op || jal || jalr
    pcu_op   :=   Cat(Cat(Cat(Cat(Cat(Cat(Cat(jalr,jal),bgeu),bltu),bge),blt),bne),beq)
    pcu_data1:=   Mux(B_op,RData1,Pc)
    pcu_data2:=   Mux(B_op,RData2,4.U(32.W))
    rd_r     :=  io.RegFile.Rd 
    csr_en   :=  csr_opcode
    csr_op   :=  Cat(Cat(csrrc||csrrci, csrrs||csrrsi),csrrw || csrrwi)
    csr_waddr:=  io.CsrReg.CsrAddr
    csr_data :=  CsrData
    csr_imm  :=  Mux(csri,zimm,RData1)
    IdValid  :=  true.B

}.elsewhen(ExeReady && !IdEn){
    IdValid  :=  false.B
}.otherwise{
    alu_op   :=  alu_op
    data1    :=  data1
    data2    :=  data2
    mmu_en   :=  mmu_en
    mmu_wen  :=  mmu_wen
    mmu_RData2:= mmu_RData2
    pcu_en   :=  pcu_en
    pcu_op   :=  pcu_op
    pcu_data1:=  pcu_data1 
    pcu_data2:=  pcu_data2
    rd_r     :=  rd_r
    csr_en   :=  csr_en   
    csr_op   :=  csr_op
    csr_waddr:=  csr_waddr
    csr_data :=  csr_data
    csr_imm  :=  csr_imm
    IdValid  :=  IdValid 
}

io.Debug_alu_op    :=alu_op    
io.Debug_data1     :=data1     
io.Debug_data2     :=data2     
io.Debug_mmu_en    :=mmu_en    
io.Debug_mmu_wen   :=mmu_wen   
io.Debug_mmu_op    :=mmu_op    
io.Debug_mmu_RData2:=mmu_RData2
io.Debug_pcu_en    :=pcu_en    
io.Debug_pcu_op    :=pcu_op    
io.Debug_pcu_data1 :=pcu_data1 
io.Debug_pcu_data2 :=pcu_data2 
io.Debug_rd_r      :=rd_r      
io.Debug_csr_en    :=csr_en    
io.Debug_csr_op    :=csr_op    
io.Debug_csr_waddr :=csr_waddr 
io.Debug_csr_data  :=csr_data  
io.Debug_csr_imm   :=csr_imm   
io.Debug_IdValid   :=IdValid   

}

