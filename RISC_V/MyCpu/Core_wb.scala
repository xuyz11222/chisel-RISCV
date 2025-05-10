
import chisel3._
import chisel3.util._

class CoreWb extends Module{
    val io =IO(new Bundle(){
       val Mem     = Flipped(new MemWb())
       val RegFile = Flipped(new RegFileWb())
    })
    


io.RegFile.Rd    := io.Mem.Rd
io.RegFile.WData := io.Mem.WData 

io.Mem.WbReady   := true.B

}