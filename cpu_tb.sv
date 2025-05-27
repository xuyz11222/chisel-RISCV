`timescale 1ns / 1ns

module cpu_test();


  reg        clock                         ;
  reg        reset;
  wire        io_PreIfInstr_inst_sram_en;
  wire [3:0]  io_PreIfInstr_inst_sram_wen;
  wire [31:0] io_PreIfInstr_inst_sram_addr;
  wire [31:0] io_PreIfInstr_inst_sram_wdata;
  reg  [31:0] io_InstrIf_inst_sram_rdata;
  wire        io_ExeData_data_sram_en;
  wire [3:0]  io_ExeData_data_sram_wen;
  wire [31:0] io_ExeData_data_sram_addr;
  wire [31:0] io_ExeData_data_sram_wdata;
  reg  [31:0] io_DataMem_data_sram_rdata;

  reg [31:0] Meminstr[0:1023];
  reg [31:0] Memdata [0:1023];
  wire [31:0] instr  ;
  wire [31:0] data   ;
  wire [ 9:0] iaddr   ;
  wire [ 9:0] daddr   ;


  wire [31:0] io_Debug_DebugInstr;
  wire [31:0] io_Debug_DebugPc;
  wire        io_Debug_DebugIfValid;
  wire        io_Debug_DebugIfEn;
  wire [9:0]  io_Debug_Debug_alu_op;
  wire [31:0] io_Debug_Debug_data1;
  wire [31:0] io_Debug_Debug_data2;
  wire        io_Debug_Debug_mmu_en;
  wire        io_Debug_Debug_mmu_wen;
  wire [4:0]  io_Debug_Debug_mmu_op;
  wire [31:0] io_Debug_Debug_mmu_RData2;
  wire        io_Debug_Debug_pcu_en;
  wire [7:0]  io_Debug_Debug_pcu_op;
  wire [31:0] io_Debug_Debug_pcu_data1;
  wire [31:0] io_Debug_Debug_pcu_data2;
  wire [4:0]  io_Debug_Debug_rd_r;
  wire        io_Debug_Debug_csr_en;
  wire [2:0]  io_Debug_Debug_csr_op;
  wire [11:0] io_Debug_Debug_csr_waddr;
  wire [31:0] io_Debug_Debug_csr_data;
  wire [31:0] io_Debug_Debug_csr_imm;
  wire        io_Debug_Debug_IdValid;
  wire [31:0] io_Debug_DebugResult;
  wire [4:0]  io_Debug_DebugRd_r;
  wire        io_Debug_DebugDataEn;
  wire        io_Debug_DebugDataWen;
  wire [31:0] io_Debug_DebugDataWdata;
  wire [1:0]  io_Debug_DebugDataSize;
  wire        io_Debug_DebugDataMemValid;
  wire [4:0]  io_Debug_DebugLoadOp;
  wire        io_Debug_DebugPcJump;
  wire [31:0] io_Debug_DebugNextPc;
  wire [11:0] io_Debug_DebugCsrWAddr;
  wire [31:0] io_Debug_DebugCsrWData;
  wire        io_Debug_DebugExeValid;
  wire [31:0] io_Debug_DebugWData;
  wire [4:0]  io_Debug_DebugMemRd_r;
  wire        io_DeBugAddrOk;
  wire        io_DeBugDataOk;
  wire [31:0] io_DeBugRData ;
  wire [7:0]  io_Led_Led    ;

  wire [2:0]  io_DebugRegState     ;
  wire [31:0] io_DebugArAddr       ;      
  wire [1:0]  io_DebugArsize       ;      
  wire        io_DebugArValid      ;       
  wire [31:0] io_DebugAwAddr       ;      
  wire [1:0]  io_DebugAwsize       ;      
  wire        io_DebugAwValid      ;       
  wire [31:0] io_DebugWData        ;     
  wire        io_DebugWLast        ;     
  wire        io_DebugWValid       ;      
  wire [1:0]  io_DebugWriteState   ;          
  wire [1:0]  io_DebugReadState    ; 

wire [2:0]  io_DebugAxiState ;
wire [2:0]  io_DebugApbState ;
wire [31:0] io_DebugPAddr    ;
wire        io_DebugPWrite   ;
wire        io_DebugPSel     ;
wire        io_DebugPEnable  ;
wire [31:0] io_DebugPWData   ;
 
    integer i ;
    integer j ;


  initial begin
    clock = 0 ;
    reset = 1 ;
    for(i=0;i<1024;i++)   Memdata[i] = 32'd0 ;
    for(j=20;j<1024;j++)  Meminstr[j] = 32'd0 ;
    Meminstr[0] = 32'h4f26_1137 ;
    Meminstr[1] = 32'h4f26_2217 ;
    Meminstr[2] = 32'h2000_0337 ;
    Meminstr[3] = 32'h0043_1023 ;
    Meminstr[4] = 32'h1040_A423 ;
    Meminstr[5] = 32'h0011_0313 ;
    Meminstr[6] = 32'h4023_0433 ;
    Meminstr[7] = 32'h0023_2533 ;
    Meminstr[8] = 32'h0023_0463 ;
    Meminstr[9] = 32'h0023_4733 ;
    Meminstr[10] = 32'h0023_5833 ;
    Meminstr[11] = 32'h0023_6933 ;
    Meminstr[12] = 32'h0023_7A33 ;
    Meminstr[13] = 32'h4023_5B33 ;
    Meminstr[14] = 32'h1000_0C03 ;
    Meminstr[15] = 32'h1040_1D03 ;
    Meminstr[16] = 32'h1080_2E03 ;
    Meminstr[17] = 32'h3413_1F73 ;
    Meminstr[18] = 32'h3413_1F73 ;
    Meminstr[19] = 32'h0000_0F67 ;
    
    #21 reset = 0 ;
    
  end

  always begin
    #10 clock = ~clock ;
  end

  assign iaddr = io_PreIfInstr_inst_sram_addr[11:2] ;
  assign instr = Meminstr[iaddr];
  assign daddr = io_ExeData_data_sram_addr[11:2] ;
  assign data  = Memdata [daddr];

  

  always@(*) begin
    if(io_PreIfInstr_inst_sram_en)begin
       io_InstrIf_inst_sram_rdata[31:24] = ~io_PreIfInstr_inst_sram_wen[3] ? instr[31:24] : 8'd0 ;
       io_InstrIf_inst_sram_rdata[23:16] = ~io_PreIfInstr_inst_sram_wen[2] ? instr[23:16] : 8'd0 ;
       io_InstrIf_inst_sram_rdata[15:8]  = ~io_PreIfInstr_inst_sram_wen[1] ? instr[15:8]  : 8'd0 ;
       io_InstrIf_inst_sram_rdata[7:0]   = ~io_PreIfInstr_inst_sram_wen[0] ? instr[7:0]   : 8'd0 ;
    end
  end

 always@(posedge clock) begin
    if(io_PreIfInstr_inst_sram_en)begin
       Meminstr[iaddr][31:24] = io_PreIfInstr_inst_sram_wen[3] ? io_PreIfInstr_inst_sram_wdata[31:24] : Meminstr[iaddr][31:24] ;
       Meminstr[iaddr][23:16] = io_PreIfInstr_inst_sram_wen[2] ? io_PreIfInstr_inst_sram_wdata[23:16] : Meminstr[iaddr][23:16] ;
       Meminstr[iaddr][15:8]  = io_PreIfInstr_inst_sram_wen[1] ? io_PreIfInstr_inst_sram_wdata[15:8]  : Meminstr[iaddr][15:8] ;
       Meminstr[iaddr][7:0]   = io_PreIfInstr_inst_sram_wen[0] ? io_PreIfInstr_inst_sram_wdata[7:0]   : Meminstr[iaddr][7:0] ;
    end
  end
   
always@(*) begin
    if(io_ExeData_data_sram_en)begin
       io_DataMem_data_sram_rdata[31:24] = ~io_ExeData_data_sram_wen[3] ? data[31:24] : 8'd0 ;
       io_DataMem_data_sram_rdata[23:16] = ~io_ExeData_data_sram_wen[2] ? data[23:16] : 8'd0 ;
       io_DataMem_data_sram_rdata[15:8]  = ~io_ExeData_data_sram_wen[1] ? data[15:8]  : 8'd0 ;
       io_DataMem_data_sram_rdata[7:0]   = ~io_ExeData_data_sram_wen[0] ? data[7:0]   : 8'd0 ;
    end
  end

 always@(posedge clock) begin
    if(io_ExeData_data_sram_en)begin
       Memdata[daddr][31:24] = io_ExeData_data_sram_wen[3] ? io_ExeData_data_sram_wdata[31:24] : Memdata[daddr][31:24] ;
       Memdata[daddr][23:16] = io_ExeData_data_sram_wen[2] ? io_ExeData_data_sram_wdata[23:16] : Memdata[daddr][23:16] ;
       Memdata[daddr][15:8]  = io_ExeData_data_sram_wen[1] ? io_ExeData_data_sram_wdata[15:8]  : Memdata[daddr][15:8] ;
       Memdata[daddr][7:0]   = io_ExeData_data_sram_wen[0] ? io_ExeData_data_sram_wdata[7:0]   : Memdata[daddr][7:0] ;
    end
  end
   
SocTop u_CoreTop(
  .clock                        (clock), 
  .reset                       (reset),
  .io_Instr_PreIfInstr_inst_sram_en(io_PreIfInstr_inst_sram_en),
  .io_Instr_PreIfInstr_inst_sram_wen(io_PreIfInstr_inst_sram_wen),
  .io_Instr_PreIfInstr_inst_sram_addr(io_PreIfInstr_inst_sram_addr),
  .io_Instr_PreIfInstr_inst_sram_wdata(io_PreIfInstr_inst_sram_wdata),
  .io_Instr_InstrIf_inst_sram_rdata(io_InstrIf_inst_sram_rdata),
  .io_MemData_data_sram_en(io_ExeData_data_sram_en),
  .io_MemData_data_sram_wen(io_ExeData_data_sram_wen),
  .io_MemData_data_sram_addr(io_ExeData_data_sram_addr),
  .io_MemData_data_sram_wdata(io_ExeData_data_sram_wdata),
  .io_MemData_data_sram_rdata(io_DataMem_data_sram_rdata),
  .io_Led_Led                (io_Led_Led),
.io_Debug_DebugInstr         (io_Debug_DebugInstr        ),                    
.io_Debug_DebugPc            (io_Debug_DebugPc           ),       
.io_Debug_DebugIfValid       (io_Debug_DebugIfValid      ),     
.io_Debug_DebugIfEn          (io_Debug_DebugIfEn         ),    
.io_Debug_Debug_alu_op       (io_Debug_Debug_alu_op      ),
.io_Debug_Debug_data1        (io_Debug_Debug_data1       ),
.io_Debug_Debug_data2        (io_Debug_Debug_data2       ),
.io_Debug_Debug_mmu_en       (io_Debug_Debug_mmu_en      ),
.io_Debug_Debug_mmu_wen      (io_Debug_Debug_mmu_wen     ), 
.io_Debug_Debug_mmu_op       (io_Debug_Debug_mmu_op      ), 
.io_Debug_Debug_mmu_RData2   (io_Debug_Debug_mmu_RData2  ),     
.io_Debug_Debug_pcu_en       (io_Debug_Debug_pcu_en),
.io_Debug_Debug_pcu_op       (io_Debug_Debug_pcu_op),
.io_Debug_Debug_pcu_data1    (io_Debug_Debug_pcu_data1),
.io_Debug_Debug_pcu_data2    (io_Debug_Debug_pcu_data2),
.io_Debug_Debug_rd_r         (io_Debug_Debug_rd_r),
.io_Debug_Debug_csr_en       (io_Debug_Debug_csr_en),
.io_Debug_Debug_csr_op       (io_Debug_Debug_csr_op),
.io_Debug_Debug_csr_waddr    (io_Debug_Debug_csr_waddr),                                            
.io_Debug_Debug_csr_data     (io_Debug_Debug_csr_data) ,                                             
.io_Debug_Debug_csr_imm      (io_Debug_Debug_csr_imm)  ,                                        
.io_Debug_Debug_IdValid      (io_Debug_Debug_IdValid)  ,                                  
.io_Debug_DebugResult        (io_Debug_DebugResult)    ,                              
.io_Debug_DebugRd_r          (io_Debug_DebugRd_r)      ,                         
.io_Debug_DebugDataEn        (io_Debug_DebugDataEn)    ,                             
.io_Debug_DebugDataWen       (io_Debug_DebugDataWen)   ,                               
.io_Debug_DebugDataWdata     (io_Debug_DebugDataWdata) ,                                   
.io_Debug_DebugDataSize      (io_Debug_DebugDataSize)  ,                                 
.io_Debug_DebugDataMemValid  (io_Debug_DebugDataMemValid) ,                                               
.io_Debug_DebugLoadOp        (io_Debug_DebugLoadOp)     ,                              
.io_Debug_DebugPcJump        (io_Debug_DebugPcJump)     ,                              
.io_Debug_DebugNextPc        (io_Debug_DebugNextPc)     ,                              
.io_Debug_DebugCsrWAddr      (io_Debug_DebugCsrWAddr)   ,                                  
.io_Debug_DebugCsrWData      (io_Debug_DebugCsrWData)   ,                                              
.io_Debug_DebugExeValid      (io_Debug_DebugExeValid)   ,                                          
.io_Debug_DebugWData         (io_Debug_DebugWData)      ,            
.io_Debug_DebugMemRd_r       (io_Debug_DebugMemRd_r)    ,
       

.io_DeBugAddrOk(io_DeBugAddrOk),
.io_DeBugDataOk(io_DeBugDataOk),
.io_DeBugRData (io_DeBugRData ),
.io_DebugRegState    (io_DebugRegState   ), 
.io_DebugArAddr      (io_DebugArAddr     ), 
.io_DebugArsize      (io_DebugArsize     ), 
.io_DebugArValid     (io_DebugArValid    ), 
.io_DebugAwAddr      (io_DebugAwAddr     ), 
.io_DebugAwsize      (io_DebugAwsize     ), 
.io_DebugAwValid     (io_DebugAwValid    ), 
.io_DebugWData       (io_DebugWData      ), 
.io_DebugWLast       (io_DebugWLast      ), 
.io_DebugWValid      (io_DebugWValid     ), 
.io_DebugWriteState  (io_DebugWriteState ), 
.io_DebugReadState   (io_DebugReadState  ),

.io_DebugAxiState    (io_DebugAxiState   ),  
.io_DebugApbState    (io_DebugApbState ),
.io_DebugPAddr       (io_DebugPAddr    ),
.io_DebugPWrite      (io_DebugPWrite   ),
.io_DebugPSel        (io_DebugPSel     ),
.io_DebugPEnable     (io_DebugPEnable  ),
.io_DebugPWData      (io_DebugPWData   )


);



endmodule