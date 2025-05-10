import chisel3._
import chisel3.util._

class ALU extends Module{
    val io = IO(new Bundle{
        val op    = Input(UInt(10.W))
        val data1 = Input(UInt(32.W))
        val data2 = Input(UInt(32.W))
        val result= Output(UInt(32.W))
    }

    )
  val op     = io.op 
  val data1  = io.data1
  val data2  = io.data2
  val result = Wire(UInt(32.W))
  
  io.result  := result

  val  op_add = op(0) === 1.U(1.W)
  val  op_sub = op(1) === 1.U(1.W)
  val  op_slt = op(2) === 1.U(1.W)
  val  op_sltu= op(3) === 1.U(1.W)
  val  op_and = op(4) === 1.U(1.W)
  val  op_or  = op(5) === 1.U(1.W)
  val  op_xor = op(6) === 1.U(1.W)
  val  op_sll = op(7) === 1.U(1.W)
  val  op_srl = op(8) === 1.U(1.W)
  val  op_sra = op(9) === 1.U(1.W)
 
  val adder_a      =data1
  val adder_b      =Mux(op_sub || op_slt || op_sltu , ~ data2 , data2)
  val adder_cin    =Mux(op_sub || op_slt || op_sltu , 1.U(32.W) , 0.U(32.W))
  val adder_cout_result =Wire(UInt(33.W))
  adder_cout_result := Cat(0.U(1.W),adder_a) + Cat(0.U(1.W),adder_b) +Cat(0.U(1.W),adder_cin)

  val adder_cout   = adder_cout_result(32)
  val adder_result = adder_cout_result(31,0)
  val add_sub_result = adder_result
  val slt_result   = Cat(0.U(31.W),
                        (data1(31) && ~data2(31)) 
                        || ((data1(31) === data2(31)) && ~adder_cout))
  val sltu_result  = Cat(0.U(31.W), ~adder_cout)
  val and_result = data1 & data2
  val or_result  = data1 | data2
  val xor_result = data1 ^ data2
  val sll_result = data1 << data2(4,0);
  val data1_64   = Cat(Fill(32,op_sra&&data1(31)), data1)
  val sr64_result = data1_64>> data2(4,0)
  val sr_result   = sr64_result(31,0)
  
  //switch(op){
  //  is(1.U){result := add_sub_result}
  //  is(2.U){result := add_sub_result}
  //  is(4.U){result :=slt_result}
  //  is(8.U){result :=sltu_result}
  //  is(16.U){result :=and_result}
  //  is(32.U){result :=or_result}
  //  is(64.U){result :=xor_result}
  //  is(128.U){result :=sll_result}
  //  is(256.U){result :=sr_result}
  //  is(512.U){result :=sr_result}
//
  //  
  //  }
    when(op_add){
      result := add_sub_result
    }.elsewhen(op_sub){
      result := add_sub_result
    }.elsewhen(op_slt){
      result :=slt_result
    }.elsewhen(op_sltu){
      result :=sltu_result
    }.elsewhen(op_and){
      result :=and_result
    }.elsewhen(op_or){
      result :=or_result
    }.elsewhen(op_xor){
      result :=xor_result
    }.elsewhen(op_sll){
      result :=sll_result
    }.elsewhen(op_srl){
      result :=sr_result
    }.elsewhen(op_sra){
      result :=sr_result
    }.otherwise{
      result := 0.U(32.W)
    }
  }

  class Mmu extends Module{
    val io =IO(new Bundle{
      val MmuEn      = Input(Bool())  
      val MmuWen     = Input(UInt(1.W))
      val MmuOp      = Input(UInt(5.W))
      val MmuRData2  = Input(UInt(32.W))
     
      val data_sram_en    = Output(Bool())
      val data_sram_wen   = Output(Bool()) 
      val data_sram_wdata = Output(UInt(32.W))    
      val data_size       = Output(UInt(2.W))
      

      val DataMemValid = Output(Bool())
      val LoadOp       = Output(UInt(5.W))

      
        
    }

    )

    val MmuEn      = io.MmuEn
    val MmuWen     = io.MmuWen
    val MmuOp      = io.MmuOp
    val MmuRData2  = io.MmuRData2

    val data_sram_wen= Wire(Bool())

    

    val ByteS  = MmuOp(0) === 1.U(1.W)
    val HalfS  = MmuOp(1) === 1.U(1.W)
    val WordS  = MmuOp(2) === 1.U(1.W)
    val ByteU  = MmuOp(3) === 1.U(1.W)
    val HalfU  = MmuOp(4) === 1.U(1.W)

  

    data_sram_wen := MmuWen === 1.U

    when(ByteS || ByteU){
      io.data_size :=  "b00".U
    }.elsewhen(HalfS || HalfU){
      io.data_size :=  "b01".U
    }.elsewhen(WordS){
      io.data_size :=  "b11".U
    }.otherwise{
      io.data_size :=  "b00".U
    }
    
    
    io.data_sram_en     := MmuEn
    io.data_sram_wen    := data_sram_wen
    io.data_sram_wdata  := MmuRData2
    io.DataMemValid     := MmuEn && MmuWen === 0.U(1.W)
    io.LoadOp           := MmuOp  
   
  
    
  }

  class Pcu extends Module{
    val io = IO(new Bundle{
          val PcuOp     = Input(UInt(8.W))
          val PcuData1  = Input(UInt(32.W))
          val PcuData2  = Input(UInt(32.W))
          val PcJump    = Output(Bool())
          val PcuResult = Output(UInt(32.W))
    }
    )

  val PcuOp     = io.PcuOp
  val PcuData1  = io.PcuData1
  val PcuData2  = io.PcuData2
  val PcJump    = Wire(Bool())
  val PcuResult = Wire(UInt(32.W))
  
  io.PcJump    := PcJump 
  io.PcuResult := PcuResult

  val beq    =  PcuOp(0) === 1.U(1.W)
  val bne    =  PcuOp(1) === 1.U(1.W)
  val blt    =  PcuOp(2) === 1.U(1.W)
  val bge    =  PcuOp(3) === 1.U(1.W)
  val bltu   =  PcuOp(4) === 1.U(1.W)
  val bgeu   =  PcuOp(5) === 1.U(1.W)
  val jal    =  PcuOp(6) === 1.U(1.W)
  val jalr   =  PcuOp(7) === 1.U(1.W)
  
  val equil  =  PcuData1 === PcuData2

  val adder_a      = PcuData1
  val adder_b      = Mux(!jal && !jalr  , ~ PcuData2 , PcuData2)
  val adder_cin    = Mux(!jal && !jalr , 1.U(32.W) , 0.U(32.W))
  val adder_cout_result =Wire(UInt(33.W))
  adder_cout_result := Cat(0.U(1.W),adder_a) + Cat(0.U(1.W),adder_b) +Cat(0.U(1.W),adder_cin)

  val adder_cout   = adder_cout_result(32)
  val adder_result = adder_cout_result(31,0)
  val add_sub_result = adder_result
  val slt_result   =  (PcuData1(31) && ~PcuData2(31)) || ((PcuData1(31) === PcuData2(31)) && adder_cout === 0.U)
  val sltu_result  =  adder_cout === 0.U

  when(beq){
      PcJump := equil 
    }.elsewhen(bne){
      PcJump := !equil 
    }.elsewhen(blt){
      PcJump := slt_result 
    }.elsewhen(bge){
      PcJump := !slt_result
    }.elsewhen(bltu){
      PcJump := sltu_result
    }.elsewhen(bgeu){
      PcJump := !sltu_result
    }.elsewhen(jal){
      PcJump := true.B
    }.elsewhen(jalr){
      PcJump := true.B
    }.otherwise{
      PcJump := false.B
    }

    when( jal || jalr ){
      PcuResult := adder_result
    }.otherwise{
      PcuResult := 0.U(32.W)
    }

  }

  class Csru extends Module{
    val io = IO(new Bundle(){
        val CsrOp     = Input(UInt(6.W))
        val CsrData   = Input(UInt(32.W))
        val CsrImm    = Input(UInt(32.W))
        val CsrWData  = Output(UInt(32.W))
        val CsrWbData = Output(UInt(32.W))
    }
      
    )
    

    val CsrOp     = io.CsrOp
    val CsrData   = io.CsrData
    val CsrImm    = io.CsrImm
    
     
    val csrrw  = CsrOp(0) === 1.U
    val csrrs  = CsrOp(1) === 1.U
    val csrrc  = CsrOp(2) === 1.U

    val CsrRDataW  = CsrImm
    val CsrWbDataW = CsrData
  
    val CsrRDataS  = CsrData | CsrImm 
    val CsrWbDataS = CsrData
  
    val CsrRDataC  = CsrData & (~CsrImm )
    val CsrWbDataC = CsrData

    when(csrrw){
      io.CsrWData  := CsrRDataW
      io.CsrWbData := CsrWbDataW
    }.elsewhen(csrrs){
      io.CsrWData  := CsrRDataS
      io.CsrWbData := CsrWbDataS
    }.elsewhen(csrrc){
      io.CsrWData  := CsrRDataC
      io.CsrWbData := CsrWbDataC
    }.otherwise{
      io.CsrWData  := 0.U(32.W)
      io.CsrWbData := 0.U(32.W)
      
    }


  }