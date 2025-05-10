import chisel3._
import chisel3.util._

class CsrId extends Bundle{
    val CsrAddr = Input(UInt(12.W))
    val CsrData = Output(UInt(32.W))
}

class CsrExe extends Bundle{
    val CsrAddr = Input(UInt(12.W))
    val CsrData = Input(UInt(32.W))
}

class CsrReg extends Module{
    val io = IO(new Bundle(){
        val Id   = new CsrId()
        val Exe  = new CsrExe()
    }
    )


val RAddr  = io.Id.CsrAddr
val WAddr  = io.Exe.CsrAddr
val WData  = io.Exe.CsrData
val RData  = Wire(UInt(32.W))

RData := 0.U(32.W)
io.Id.CsrData := RData

val fflags = RegInit(0.U(32.W))
val frm    = RegInit(0.U(32.W))
val fcsr   = RegInit(0.U(32.W))

val mstatus  = RegInit(0.U(32.W))
val misa     = RegInit(0.U(32.W))
val mie      = RegInit(0.U(32.W))
val mtvec    = RegInit(0.U(32.W))
val mscratch = RegInit(0.U(32.W))
val mepc     = RegInit(0.U(32.W))
val mcause   = RegInit(0.U(32.W))
val mtval    = RegInit(0.U(32.W))
val mip      = RegInit(0.U(32.W))
val mcycle   = RegInit(0.U(32.W))
val mcycleh  = RegInit(0.U(32.W))
val minstret = RegInit(0.U(32.W))
val minstreth= RegInit(0.U(32.W))

val mvendorid= RegInit(0.U(32.W))
val marchid  = RegInit(0.U(32.W))
val mimpid   = RegInit(0.U(32.W))
val mhartid  = RegInit(0.U(32.W))

switch(WAddr){
    is("h001".U){
      fflags := WData
    }
    is("h002".U){
      frm    := WData
    }
    is("h003".U){
      fcsr   := WData
    }
    is("h300".U){
      mstatus:= WData
    }
    is("h301".U){
      misa   := WData
    }
    is("h304".U){
      mie    := WData
    }
    is("h305".U){
      mtvec  := WData
    }
    is("h340".U){
      mscratch :=  WData
    }
    is("h341".U){
      mepc    :=   WData
    }
    is("h342".U){
      mcause  :=   WData
    }
    is("h343".U){
      mtval   :=  WData
    }
    is("h344".U){
      mip     := WData
    }
    is("hb00".U){
      mcycle  := WData
    }
    is("hb80".U){
       mcycleh  := WData 
    }
    is("hb02".U){
      minstret  := WData
    }
    is("hb82".U){
       minstreth  := WData 
    }
    is("hf11".U){
      mvendorid := WData
    }
    is("hf12".U){
      marchid  := WData
    }
    is("hf13".U){
      mimpid  := WData
    }
    is("hf14".U){
      mhartid  := WData
    }
}

when (RAddr === WAddr){
    RData := WData
}.otherwise{
    switch(RAddr){
    is("h001".U){
      RData := fflags 
    }
    is("h002".U){
      RData := frm   
    }
    is("h003".U){
      RData := fcsr   
    }
    is("h300".U){
      RData := mstatus
    }
    is("h301".U){
      RData := misa   
    }
    is("h304".U){
      RData := mie    
    }
    is("h305".U){
      RData := mtvec  
    }
    is("h340".U){
      RData := mscratch 
    }
    is("h341".U){
      RData := mepc   
    }
    is("h342".U){
      RData := mcause  
    }
    is("h343".U){
      RData := mtval    
    }
    is("h344".U){
      RData := mip     
    }
    is("hb00".U){
      RData := mcycle  
    }
    is("hb80".U){
       RData :=mcycleh   
    }
    is("hb02".U){
      RData :=minstret  
    }
    is("hb82".U){
      RData :=minstreth  
    }
    is("hf11".U){
      RData := mvendorid 
    }
    is("hf12".U){
      RData := marchid  
    }
    is("hf13".U){
      RData :=mimpid  
    }
    is("hf14".U){
      RData :=mhartid  
    }

}
}
 
}
  
