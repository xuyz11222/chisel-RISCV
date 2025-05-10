
import chisel3._
import chisel3.util._

class RegFileId extends Bundle{
    val Rs1    = Input(UInt(5.W))
    val Rs2    = Input(UInt(5.W))
    val Rd     = Input(UInt(5.W))
    val RData1 = Output(UInt(32.W))
    val RData2 = Output(UInt(32.W))
    val RValid = Output(Bool()) 
     
}

class RegFileWb extends Bundle{
    val Rd     = Input(UInt(5.W))
    val WData  = Input(UInt(32.W))
}

class RegFile extends Module{
   val io = IO(new Bundle(){
      val Id   = new RegFileId()
      val Wb   = new RegFileWb()
    }
    )


  val RegStack = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
  val RegDirty = RegInit(VecInit(Seq.fill(32)(false.B)))
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
  val Rs1    = io.Id.Rs1   
  val Rs2    = io.Id.Rs2   
  val IdRd   = io.Id.Rd 
  
  val WbRd   = io.Wb.Rd
  val WData  = io.Wb.WData


  
  
  val RValid1  = Mux(Rs1 === 0.U,true.B,!RegDirty(Rs1)) 
  val RValid2  = Mux(Rs2 === 0.U,true.B,!RegDirty(Rs2)) 
  
  io.Id.RValid := RValid1 && RValid2
  io.Id.RData1 := Mux(!RegDirty(Rs1),RegStack(Rs1),0.U)
  io.Id.RData2 := Mux(!RegDirty(Rs2),RegStack(Rs2),0.U)

  RegStack(WbRd) :=Mux(WbRd === 0.U , 0.U,WData) 
  
  

    RegDirty(IdRd) := Mux(IdRd === 0.U ,false.B,true.B )
    RegDirty(WbRd) := false.B
  
  

}