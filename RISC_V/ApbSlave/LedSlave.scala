import chisel3._
import chisel3.util._

class ApbSlave extends Bundle{
    val PAddr     = Input(UInt(32.W))
    val PWrite    = Input(Bool())
    val PSel      = Input(Bool())
    val PEnable   = Input(Bool())
    val PWData    = Input(UInt(32.W))
    val PRData    = Output(UInt(32.W))
    val PReady    = Output(Bool())
    val PSlver    = Output(Bool())
    
}

class Led extends Bundle{
   
    val Led    = Output(UInt(8.W))

}

class LedSlave extends Module{
    val io = IO(new Bundle(){
           val Apb = new ApbSlave()
           val Led = new Led()
        }
    )

    val LedAddr   = "h20000000".U

    val PAddr     = io.Apb.PAddr   
    val PWrite    = io.Apb.PWrite  
    val PSel      = io.Apb.PSel    
    val PEnable   = io.Apb.PEnable 
    val PWData    = io.Apb.PWData  
    val PRData    = Wire(UInt(32.W))
    val PReady    = Wire(Bool())
    val PSlver    = Wire(Bool())

    val Led       = RegInit(0.U(8.W))

    when(PSel&&PEnable){
        when(PAddr === LedAddr){
          PSlver := false.B
           when(PWrite){
            PReady := true.B
            PRData := 0.U(32.W)
            Led    := PWData(7,0)  
            }.otherwise{
            PReady := true.B
            PRData := Cat(0.U(24.W),Led)
            }

        }.otherwise{
          PSlver := true.B
          PReady := false.B
          PRData := 0.U(32.W)

        }
           
    }.otherwise{
       PRData := 0.U(32.W)
       PReady := false.B
       PSlver := false.B

    }

    io.Apb.PRData    := PRData 
    io.Apb.PReady    := PReady 
    io.Apb.PSlver    := PSlver 
    io.Led.Led       := Led
    
     

}