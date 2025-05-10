module CorePreIf(
  input         clock,
  input         reset,
  output        io_Instr_inst_sram_en,
  output [31:0] io_Instr_inst_sram_addr,
  input         io_If_IfReady,
  output [31:0] io_If_Pc,
  input         io_Exe_PcJump,
  input  [31:0] io_Exe_NextPc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] Pc; // @[Pre_if.scala 31:25]
  wire [31:0] _Pc_T_1 = Pc + 32'h4; // @[Pre_if.scala 38:12]
  assign io_Instr_inst_sram_en = io_If_IfReady; // @[Pre_if.scala 43:29]
  assign io_Instr_inst_sram_addr = Pc; // @[Pre_if.scala 45:29]
  assign io_If_Pc = Pc; // @[Pre_if.scala 47:29]
  always @(posedge clock) begin
    if (reset) begin // @[Pre_if.scala 31:25]
      Pc <= 32'h0; // @[Pre_if.scala 31:25]
    end else if (io_Exe_PcJump) begin // @[Pre_if.scala 35:14]
      Pc <= io_Exe_NextPc; // @[Pre_if.scala 36:7]
    end else if (io_If_IfReady) begin // @[Pre_if.scala 37:23]
      Pc <= _Pc_T_1; // @[Pre_if.scala 38:7]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Pc = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CoreIf(
  input         clock,
  input         reset,
  input  [31:0] io_Instr_inst_sram_rdata,
  input         io_Id_IdReady,
  output [31:0] io_Id_IfInstr,
  output [31:0] io_Id_Pc,
  output        io_Id_IfValid,
  output        io_PreIf_IfReady,
  input  [31:0] io_PreIf_Pc,
  input         io_Exe_PcJump,
  output [31:0] io_DebugInstr,
  output [31:0] io_DebugPc,
  output        io_DebugIfValid,
  output        io_DebugIfEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] Instr; // @[Core_if.scala 35:24]
  reg [31:0] Pc; // @[Core_if.scala 36:24]
  reg  IfValid; // @[Core_if.scala 37:24]
  wire  IfEn = io_Id_IdReady | ~IfValid; // @[Core_if.scala 38:23]
  wire  _GEN_2 = IfEn | IfValid; // @[Core_if.scala 44:20 47:13 51:13]
  assign io_Id_IfInstr = Instr; // @[Core_if.scala 55:21]
  assign io_Id_Pc = Pc; // @[Core_if.scala 56:21]
  assign io_Id_IfValid = IfValid; // @[Core_if.scala 57:21]
  assign io_PreIf_IfReady = io_Id_IdReady | ~IfValid; // @[Core_if.scala 38:23]
  assign io_DebugInstr = Instr; // @[Core_if.scala 58:20]
  assign io_DebugPc = Pc; // @[Core_if.scala 59:20]
  assign io_DebugIfValid = IfValid; // @[Core_if.scala 60:20]
  assign io_DebugIfEn = io_Id_IdReady | ~IfValid; // @[Core_if.scala 38:23]
  always @(posedge clock) begin
    if (reset) begin // @[Core_if.scala 35:24]
      Instr <= 32'h0; // @[Core_if.scala 35:24]
    end else if (io_Exe_PcJump) begin // @[Core_if.scala 40:23]
      Instr <= 32'h0; // @[Core_if.scala 41:10]
    end else if (IfEn) begin // @[Core_if.scala 44:20]
      Instr <= io_Instr_inst_sram_rdata; // @[Core_if.scala 45:10]
    end
    if (reset) begin // @[Core_if.scala 36:24]
      Pc <= 32'h0; // @[Core_if.scala 36:24]
    end else if (io_Exe_PcJump) begin // @[Core_if.scala 40:23]
      Pc <= 32'h0; // @[Core_if.scala 42:10]
    end else if (IfEn) begin // @[Core_if.scala 44:20]
      Pc <= io_PreIf_Pc; // @[Core_if.scala 46:10]
    end
    if (reset) begin // @[Core_if.scala 37:24]
      IfValid <= 1'h0; // @[Core_if.scala 37:24]
    end else if (io_Exe_PcJump) begin // @[Core_if.scala 40:23]
      IfValid <= 1'h0; // @[Core_if.scala 43:13]
    end else begin
      IfValid <= _GEN_2;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Instr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  IfValid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CoreId(
  input         clock,
  input         reset,
  output        io_If_IdReady,
  input  [31:0] io_If_IfInstr,
  input  [31:0] io_If_Pc,
  input         io_If_IfValid,
  output [9:0]  io_Exe_AluOp,
  output [31:0] io_Exe_Data1,
  output [31:0] io_Exe_Data2,
  output        io_Exe_MmuEn,
  output        io_Exe_MmuWen,
  output [4:0]  io_Exe_MmuOp,
  output [31:0] io_Exe_MmuRData2,
  output        io_Exe_PcuEn,
  output [7:0]  io_Exe_PcuOp,
  output [31:0] io_Exe_PcuData1,
  output [31:0] io_Exe_PcuData2,
  output [4:0]  io_Exe_Rd,
  input         io_Exe_ExeReady,
  input         io_Exe_PcJump,
  output        io_Exe_CsrEn,
  output [2:0]  io_Exe_CsrOp,
  output [11:0] io_Exe_CsrWAddr,
  output [31:0] io_Exe_CsrData,
  output [31:0] io_Exe_CsrImm,
  output        io_Exe_IdValid,
  output [4:0]  io_RegFile_Rs1,
  output [4:0]  io_RegFile_Rs2,
  output [4:0]  io_RegFile_Rd,
  input  [31:0] io_RegFile_RData1,
  input  [31:0] io_RegFile_RData2,
  input         io_RegFile_RValid,
  output [11:0] io_CsrReg_CsrAddr,
  input  [31:0] io_CsrReg_CsrData,
  output [9:0]  io_Debug_alu_op,
  output [31:0] io_Debug_data1,
  output [31:0] io_Debug_data2,
  output        io_Debug_mmu_en,
  output        io_Debug_mmu_wen,
  output [4:0]  io_Debug_mmu_op,
  output [31:0] io_Debug_mmu_RData2,
  output        io_Debug_pcu_en,
  output [7:0]  io_Debug_pcu_op,
  output [31:0] io_Debug_pcu_data1,
  output [31:0] io_Debug_pcu_data2,
  output [4:0]  io_Debug_rd_r,
  output        io_Debug_csr_en,
  output [2:0]  io_Debug_csr_op,
  output [11:0] io_Debug_csr_waddr,
  output [31:0] io_Debug_csr_data,
  output [31:0] io_Debug_csr_imm,
  output        io_Debug_IdValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] alu_op; // @[Core_id.scala 61:24]
  reg [31:0] data1; // @[Core_id.scala 62:24]
  reg [31:0] data2; // @[Core_id.scala 63:24]
  reg  mmu_en; // @[Core_id.scala 64:24]
  reg  mmu_wen; // @[Core_id.scala 65:24]
  reg [4:0] mmu_op; // @[Core_id.scala 66:24]
  reg [31:0] mmu_RData2; // @[Core_id.scala 67:24]
  reg  pcu_en; // @[Core_id.scala 68:24]
  reg [7:0] pcu_op; // @[Core_id.scala 69:24]
  reg [31:0] pcu_data1; // @[Core_id.scala 70:24]
  reg [31:0] pcu_data2; // @[Core_id.scala 71:24]
  reg [4:0] rd_r; // @[Core_id.scala 72:24]
  reg  csr_en; // @[Core_id.scala 73:24]
  reg [2:0] csr_op; // @[Core_id.scala 74:24]
  reg [11:0] csr_waddr; // @[Core_id.scala 75:24]
  reg [31:0] csr_data; // @[Core_id.scala 76:24]
  reg [31:0] csr_imm; // @[Core_id.scala 77:24]
  reg  IdValid; // @[Core_id.scala 78:24]
  wire  IdEn = (io_Exe_ExeReady | ~IdValid) & io_RegFile_RValid & io_If_IfValid; // @[Core_id.scala 93:50]
  wire [6:0] opcode = io_If_IfInstr[6:0]; // @[Core_id.scala 98:21]
  wire [4:0] rd = io_If_IfInstr[11:7]; // @[Core_id.scala 99:21]
  wire [2:0] fuct3 = io_If_IfInstr[14:12]; // @[Core_id.scala 100:21]
  wire [4:0] rs1 = io_If_IfInstr[19:15]; // @[Core_id.scala 101:21]
  wire [4:0] rs2 = io_If_IfInstr[24:20]; // @[Core_id.scala 102:21]
  wire [6:0] fuct7 = io_If_IfInstr[31:25]; // @[Core_id.scala 103:21]
  wire  R_op = opcode == 7'h33; // @[Core_id.scala 105:19]
  wire  I_op = opcode == 7'h13; // @[Core_id.scala 106:19]
  wire  S_op = opcode == 7'h23; // @[Core_id.scala 107:19]
  wire  L_op = opcode == 7'h3; // @[Core_id.scala 108:19]
  wire  B_op = opcode == 7'h63; // @[Core_id.scala 109:19]
  wire  J_type = opcode == 7'h6f; // @[Core_id.scala 111:21]
  wire  lui = opcode == 7'h37; // @[Core_id.scala 112:21]
  wire  auipc = opcode == 7'h17; // @[Core_id.scala 113:21]
  wire  jalr = opcode == 7'h67; // @[Core_id.scala 114:21]
  wire  I_type = I_op | L_op | jalr; // @[Core_id.scala 117:24]
  wire  U_type = lui | auipc; // @[Core_id.scala 120:18]
  wire  csr_opcode = opcode == 7'h73; // @[Core_id.scala 123:25]
  wire [19:0] _imm_T_2 = io_If_IfInstr[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_4 = {_imm_T_2,io_If_IfInstr[31:20]}; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_11 = {_imm_T_2,fuct7,rd}; // @[Cat.scala 31:58]
  wire [18:0] _imm_T_14 = io_If_IfInstr[31] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_23 = {_imm_T_14,io_If_IfInstr[31],io_If_IfInstr[7],io_If_IfInstr[30:25],io_If_IfInstr[11:8],1'h0}; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_25 = {io_If_IfInstr[31:12],12'h0}; // @[Cat.scala 31:58]
  wire [10:0] _imm_T_28 = io_If_IfInstr[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_37 = {_imm_T_28,io_If_IfInstr[31],io_If_IfInstr[19:12],io_If_IfInstr[20],io_If_IfInstr[30:21],1'h0}
    ; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_38 = J_type ? _imm_T_37 : 32'h0; // @[Core_id.scala 129:17]
  wire [31:0] _imm_T_39 = U_type ? _imm_T_25 : _imm_T_38; // @[Core_id.scala 128:17]
  wire [31:0] _imm_T_40 = B_op ? _imm_T_23 : _imm_T_39; // @[Core_id.scala 127:17]
  wire [31:0] _imm_T_41 = S_op ? _imm_T_11 : _imm_T_40; // @[Core_id.scala 126:17]
  wire [31:0] imm = I_type ? _imm_T_4 : _imm_T_41; // @[Core_id.scala 125:17]
  wire  _add_T = fuct3 == 3'h0; // @[Core_id.scala 135:36]
  wire  _add_T_1 = R_op & fuct3 == 3'h0; // @[Core_id.scala 135:27]
  wire  _add_T_2 = fuct7 == 7'h0; // @[Core_id.scala 135:56]
  wire  add = R_op & fuct3 == 3'h0 & fuct7 == 7'h0 | I_op & fuct3 == 3'h0 | L_op | S_op | B_op | J_type | jalr | lui |
    auipc; // @[Core_id.scala 135:133]
  wire  _sub_T_2 = fuct7 == 7'h20; // @[Core_id.scala 136:56]
  wire  sub = _add_T_1 & fuct7 == 7'h20; // @[Core_id.scala 136:47]
  wire  _slt_T = fuct3 == 3'h2; // @[Core_id.scala 137:36]
  wire  slt = R_op & fuct3 == 3'h2 & _add_T_2 | I_op & fuct3 == 3'h2; // @[Core_id.scala 137:65]
  wire  _sltu_T = fuct3 == 3'h3; // @[Core_id.scala 138:36]
  wire  sltu = R_op & fuct3 == 3'h3 & _add_T_2 | I_op & fuct3 == 3'h3; // @[Core_id.scala 138:65]
  wire  _and_T = fuct3 == 3'h7; // @[Core_id.scala 139:36]
  wire  and_ = R_op & fuct3 == 3'h7 & _add_T_2 | I_op & fuct3 == 3'h7; // @[Core_id.scala 139:65]
  wire  _or_T = fuct3 == 3'h6; // @[Core_id.scala 140:36]
  wire  or_ = R_op & fuct3 == 3'h6 & _add_T_2 | I_op & fuct3 == 3'h6; // @[Core_id.scala 140:66]
  wire  _xor_T = fuct3 == 3'h4; // @[Core_id.scala 141:36]
  wire  xor_ = R_op & fuct3 == 3'h4 & _add_T_2 | I_op & fuct3 == 3'h4; // @[Core_id.scala 141:65]
  wire  _sll_T = fuct3 == 3'h1; // @[Core_id.scala 142:36]
  wire  sll = R_op & fuct3 == 3'h1 & _add_T_2 | I_op & fuct3 == 3'h1 & _add_T_2; // @[Core_id.scala 142:65]
  wire  _srl_T = fuct3 == 3'h5; // @[Core_id.scala 143:36]
  wire  _srl_T_1 = R_op & fuct3 == 3'h5; // @[Core_id.scala 143:27]
  wire  _srl_T_5 = I_op & fuct3 == 3'h5; // @[Core_id.scala 143:74]
  wire  srl = R_op & fuct3 == 3'h5 & _add_T_2 | I_op & fuct3 == 3'h5 & _add_T_2; // @[Core_id.scala 143:65]
  wire  sra = _srl_T_1 & _sub_T_2 | _srl_T_5 & _sub_T_2; // @[Core_id.scala 144:69]
  wire  _ByteS_T = L_op | S_op; // @[Core_id.scala 147:21]
  wire  ByteS = (L_op | S_op) & _add_T; // @[Core_id.scala 147:30]
  wire  HalfS = _ByteS_T & _sll_T; // @[Core_id.scala 148:30]
  wire  WordS = _ByteS_T & _slt_T; // @[Core_id.scala 149:30]
  wire  ByteU = _ByteS_T & _xor_T; // @[Core_id.scala 150:30]
  wire  HalfU = _ByteS_T & _srl_T; // @[Core_id.scala 151:30]
  wire  beq = B_op & _add_T; // @[Core_id.scala 155:20]
  wire  bne = B_op & _sll_T; // @[Core_id.scala 156:20]
  wire  blt = B_op & _xor_T; // @[Core_id.scala 157:20]
  wire  bge = B_op & _srl_T; // @[Core_id.scala 158:20]
  wire  bltu = B_op & _or_T; // @[Core_id.scala 159:20]
  wire  bgeu = B_op & _and_T; // @[Core_id.scala 160:20]
  wire  csrrw = csr_opcode & _sll_T; // @[Core_id.scala 164:25]
  wire  csrrs = csr_opcode & _slt_T; // @[Core_id.scala 165:25]
  wire  csrrc = csr_opcode & _sltu_T; // @[Core_id.scala 166:25]
  wire  csrrwi = csr_opcode & _srl_T; // @[Core_id.scala 167:25]
  wire  csrrsi = csr_opcode & _or_T; // @[Core_id.scala 168:25]
  wire  csrrci = csr_opcode & _and_T; // @[Core_id.scala 169:25]
  wire  csri = csr_opcode & fuct3[2]; // @[Core_id.scala 171:25]
  wire  csrr = csr_opcode & ~fuct3[2]; // @[Core_id.scala 172:25]
  wire [31:0] zimm = {27'h0,rs1}; // @[Cat.scala 31:58]
  wire  _io_RegFile_Rs1_T = R_op | I_type; // @[Core_id.scala 179:27]
  wire [9:0] _alu_op_T_8 = {sra,srl,sll,xor_,or_,and_,sltu,slt,sub,add}; // @[Cat.scala 31:58]
  wire [31:0] _data1_T_2 = lui ? 32'h0 : io_RegFile_RData1; // @[Core_id.scala 230:50]
  wire [4:0] _mmu_op_T_3 = {HalfU,ByteU,WordS,HalfS,ByteS}; // @[Cat.scala 31:58]
  wire [7:0] _pcu_op_T_6 = {jalr,J_type,bgeu,bltu,bge,blt,bne,beq}; // @[Cat.scala 31:58]
  wire  _csr_op_T = csrrc | csrrci; // @[Core_id.scala 242:31]
  wire  _csr_op_T_1 = csrrs | csrrsi; // @[Core_id.scala 242:46]
  wire  _csr_op_T_3 = csrrw | csrrwi; // @[Core_id.scala 242:62]
  wire [2:0] _csr_op_T_4 = {_csr_op_T,_csr_op_T_1,_csr_op_T_3}; // @[Cat.scala 31:58]
  wire  _GEN_0 = io_Exe_ExeReady & ~IdEn ? 1'h0 : IdValid; // @[Core_id.scala 248:30 249:14 267:14]
  wire  _GEN_34 = IdEn | _GEN_0; // @[Core_id.scala 228:17 246:14]
  assign io_If_IdReady = (io_Exe_ExeReady | ~IdValid) & io_RegFile_RValid & io_If_IfValid; // @[Core_id.scala 93:50]
  assign io_Exe_AluOp = alu_op; // @[Core_id.scala 183:18]
  assign io_Exe_Data1 = data1; // @[Core_id.scala 184:18]
  assign io_Exe_Data2 = data2; // @[Core_id.scala 185:18]
  assign io_Exe_MmuEn = mmu_en; // @[Core_id.scala 186:18]
  assign io_Exe_MmuWen = mmu_wen; // @[Core_id.scala 187:18]
  assign io_Exe_MmuOp = mmu_op; // @[Core_id.scala 188:18]
  assign io_Exe_MmuRData2 = mmu_RData2; // @[Core_id.scala 189:18]
  assign io_Exe_PcuEn = pcu_en; // @[Core_id.scala 192:18]
  assign io_Exe_PcuOp = pcu_op; // @[Core_id.scala 193:18]
  assign io_Exe_PcuData1 = pcu_data1; // @[Core_id.scala 194:18]
  assign io_Exe_PcuData2 = pcu_data2; // @[Core_id.scala 195:18]
  assign io_Exe_Rd = rd_r; // @[Core_id.scala 191:18]
  assign io_Exe_CsrEn = csr_en; // @[Core_id.scala 197:18]
  assign io_Exe_CsrOp = csr_op; // @[Core_id.scala 198:18]
  assign io_Exe_CsrWAddr = csr_waddr; // @[Core_id.scala 199:18]
  assign io_Exe_CsrData = csr_data; // @[Core_id.scala 200:18]
  assign io_Exe_CsrImm = csr_imm; // @[Core_id.scala 201:18]
  assign io_Exe_IdValid = IdValid; // @[Core_id.scala 203:18]
  assign io_RegFile_Rs1 = R_op | I_type | S_op | B_op | csrr ? rs1 : 5'h0; // @[Core_id.scala 179:20]
  assign io_RegFile_Rs2 = R_op | S_op | B_op ? rs2 : 5'h0; // @[Core_id.scala 180:20]
  assign io_RegFile_Rd = _io_RegFile_Rs1_T | U_type | J_type | csr_opcode ? rd : 5'h0; // @[Core_id.scala 181:20]
  assign io_CsrReg_CsrAddr = csr_opcode ? io_If_IfInstr[31:20] : 12'h0; // @[Core_id.scala 205:24]
  assign io_Debug_alu_op = alu_op; // @[Core_id.scala 270:20]
  assign io_Debug_data1 = data1; // @[Core_id.scala 271:20]
  assign io_Debug_data2 = data2; // @[Core_id.scala 272:20]
  assign io_Debug_mmu_en = mmu_en; // @[Core_id.scala 273:20]
  assign io_Debug_mmu_wen = mmu_wen; // @[Core_id.scala 274:20]
  assign io_Debug_mmu_op = mmu_op; // @[Core_id.scala 275:20]
  assign io_Debug_mmu_RData2 = mmu_RData2; // @[Core_id.scala 276:20]
  assign io_Debug_pcu_en = pcu_en; // @[Core_id.scala 277:20]
  assign io_Debug_pcu_op = pcu_op; // @[Core_id.scala 278:20]
  assign io_Debug_pcu_data1 = pcu_data1; // @[Core_id.scala 279:20]
  assign io_Debug_pcu_data2 = pcu_data2; // @[Core_id.scala 280:20]
  assign io_Debug_rd_r = rd_r; // @[Core_id.scala 281:20]
  assign io_Debug_csr_en = csr_en; // @[Core_id.scala 282:20]
  assign io_Debug_csr_op = csr_op; // @[Core_id.scala 283:20]
  assign io_Debug_csr_waddr = csr_waddr; // @[Core_id.scala 284:20]
  assign io_Debug_csr_data = csr_data; // @[Core_id.scala 285:20]
  assign io_Debug_csr_imm = csr_imm; // @[Core_id.scala 286:20]
  assign io_Debug_IdValid = IdValid; // @[Core_id.scala 287:20]
  always @(posedge clock) begin
    if (reset) begin // @[Core_id.scala 61:24]
      alu_op <= 10'h0; // @[Core_id.scala 61:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      alu_op <= 10'h0; // @[Core_id.scala 210:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      alu_op <= _alu_op_T_8; // @[Core_id.scala 229:15]
    end
    if (reset) begin // @[Core_id.scala 62:24]
      data1 <= 32'h0; // @[Core_id.scala 62:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      data1 <= 32'h0; // @[Core_id.scala 211:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (auipc | B_op | J_type) begin // @[Core_id.scala 230:22]
        data1 <= io_If_Pc;
      end else begin
        data1 <= _data1_T_2;
      end
    end
    if (reset) begin // @[Core_id.scala 63:24]
      data2 <= 32'h0; // @[Core_id.scala 63:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      data2 <= 32'h0; // @[Core_id.scala 212:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (R_op) begin // @[Core_id.scala 231:22]
        data2 <= io_RegFile_RData2;
      end else begin
        data2 <= imm;
      end
    end
    if (reset) begin // @[Core_id.scala 64:24]
      mmu_en <= 1'h0; // @[Core_id.scala 64:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      mmu_en <= 1'h0; // @[Core_id.scala 213:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      mmu_en <= _ByteS_T; // @[Core_id.scala 232:15]
    end
    if (reset) begin // @[Core_id.scala 65:24]
      mmu_wen <= 1'h0; // @[Core_id.scala 65:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      mmu_wen <= 1'h0; // @[Core_id.scala 214:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      mmu_wen <= S_op; // @[Core_id.scala 233:15]
    end
    if (reset) begin // @[Core_id.scala 66:24]
      mmu_op <= 5'h0; // @[Core_id.scala 66:24]
    end else if (!(io_Exe_PcJump)) begin // @[Core_id.scala 209:20]
      if (IdEn) begin // @[Core_id.scala 228:17]
        mmu_op <= _mmu_op_T_3; // @[Core_id.scala 234:15]
      end
    end
    if (reset) begin // @[Core_id.scala 67:24]
      mmu_RData2 <= 32'h0; // @[Core_id.scala 67:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      mmu_RData2 <= 32'h0; // @[Core_id.scala 215:15]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (S_op) begin // @[Core_id.scala 235:22]
        mmu_RData2 <= io_RegFile_RData2;
      end else begin
        mmu_RData2 <= 32'h0;
      end
    end
    if (reset) begin // @[Core_id.scala 68:24]
      pcu_en <= 1'h0; // @[Core_id.scala 68:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      pcu_en <= 1'h0; // @[Core_id.scala 216:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      pcu_en <= B_op | J_type | jalr; // @[Core_id.scala 236:14]
    end
    if (reset) begin // @[Core_id.scala 69:24]
      pcu_op <= 8'h0; // @[Core_id.scala 69:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      pcu_op <= 8'h0; // @[Core_id.scala 217:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      pcu_op <= _pcu_op_T_6; // @[Core_id.scala 237:14]
    end
    if (reset) begin // @[Core_id.scala 70:24]
      pcu_data1 <= 32'h0; // @[Core_id.scala 70:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      pcu_data1 <= 32'h0; // @[Core_id.scala 218:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (B_op) begin // @[Core_id.scala 238:22]
        pcu_data1 <= io_RegFile_RData1;
      end else begin
        pcu_data1 <= io_If_Pc;
      end
    end
    if (reset) begin // @[Core_id.scala 71:24]
      pcu_data2 <= 32'h0; // @[Core_id.scala 71:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      pcu_data2 <= 32'h0; // @[Core_id.scala 219:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (B_op) begin // @[Core_id.scala 239:22]
        pcu_data2 <= io_RegFile_RData2;
      end else begin
        pcu_data2 <= 32'h4;
      end
    end
    if (reset) begin // @[Core_id.scala 72:24]
      rd_r <= 5'h0; // @[Core_id.scala 72:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      rd_r <= 5'h0; // @[Core_id.scala 220:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      rd_r <= io_RegFile_Rd; // @[Core_id.scala 240:14]
    end
    if (reset) begin // @[Core_id.scala 73:24]
      csr_en <= 1'h0; // @[Core_id.scala 73:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      csr_en <= 1'h0; // @[Core_id.scala 221:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      csr_en <= csr_opcode; // @[Core_id.scala 241:14]
    end
    if (reset) begin // @[Core_id.scala 74:24]
      csr_op <= 3'h0; // @[Core_id.scala 74:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      csr_op <= 3'h0; // @[Core_id.scala 222:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      csr_op <= _csr_op_T_4; // @[Core_id.scala 242:14]
    end
    if (reset) begin // @[Core_id.scala 75:24]
      csr_waddr <= 12'h0; // @[Core_id.scala 75:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      csr_waddr <= 12'h0; // @[Core_id.scala 223:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      csr_waddr <= io_CsrReg_CsrAddr; // @[Core_id.scala 243:14]
    end
    if (reset) begin // @[Core_id.scala 76:24]
      csr_data <= 32'h0; // @[Core_id.scala 76:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      csr_data <= 32'h0; // @[Core_id.scala 224:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (io_CsrReg_CsrAddr == csr_waddr) begin // @[Core_id.scala 96:20]
        csr_data <= csr_imm;
      end else begin
        csr_data <= io_CsrReg_CsrData;
      end
    end
    if (reset) begin // @[Core_id.scala 77:24]
      csr_imm <= 32'h0; // @[Core_id.scala 77:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      csr_imm <= 32'h0; // @[Core_id.scala 225:14]
    end else if (IdEn) begin // @[Core_id.scala 228:17]
      if (csri) begin // @[Core_id.scala 245:21]
        csr_imm <= zimm;
      end else begin
        csr_imm <= io_RegFile_RData1;
      end
    end
    if (reset) begin // @[Core_id.scala 78:24]
      IdValid <= 1'h0; // @[Core_id.scala 78:24]
    end else if (io_Exe_PcJump) begin // @[Core_id.scala 209:20]
      IdValid <= 1'h0; // @[Core_id.scala 226:14]
    end else begin
      IdValid <= _GEN_34;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  alu_op = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  data1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  data2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mmu_en = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mmu_wen = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mmu_op = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  mmu_RData2 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  pcu_en = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  pcu_op = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  pcu_data1 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  pcu_data2 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  rd_r = _RAND_11[4:0];
  _RAND_12 = {1{`RANDOM}};
  csr_en = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  csr_op = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  csr_waddr = _RAND_14[11:0];
  _RAND_15 = {1{`RANDOM}};
  csr_data = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  csr_imm = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  IdValid = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  input  [9:0]  io_op,
  input  [31:0] io_data1,
  input  [31:0] io_data2,
  output [31:0] io_result
);
  wire  op_add = io_op[0]; // @[Alu.scala 20:19]
  wire  op_sub = io_op[1]; // @[Alu.scala 21:19]
  wire  op_slt = io_op[2]; // @[Alu.scala 22:19]
  wire  op_sltu = io_op[3]; // @[Alu.scala 23:19]
  wire  op_and = io_op[4]; // @[Alu.scala 24:19]
  wire  op_or = io_op[5]; // @[Alu.scala 25:19]
  wire  op_xor = io_op[6]; // @[Alu.scala 26:19]
  wire  op_sll = io_op[7]; // @[Alu.scala 27:19]
  wire  op_srl = io_op[8]; // @[Alu.scala 28:19]
  wire  op_sra = io_op[9]; // @[Alu.scala 29:19]
  wire  _adder_b_T_1 = op_sub | op_slt | op_sltu; // @[Alu.scala 32:42]
  wire [31:0] _adder_b_T_2 = ~io_data2; // @[Alu.scala 32:55]
  wire [31:0] adder_b = op_sub | op_slt | op_sltu ? _adder_b_T_2 : io_data2; // @[Alu.scala 32:24]
  wire [31:0] adder_cin = _adder_b_T_1 ? 32'h1 : 32'h0; // @[Alu.scala 33:24]
  wire [32:0] _adder_cout_result_T = {1'h0,io_data1}; // @[Cat.scala 31:58]
  wire [32:0] _adder_cout_result_T_1 = {1'h0,adder_b}; // @[Cat.scala 31:58]
  wire [32:0] _adder_cout_result_T_3 = _adder_cout_result_T + _adder_cout_result_T_1; // @[Alu.scala 35:46]
  wire [32:0] _adder_cout_result_T_4 = {1'h0,adder_cin}; // @[Cat.scala 31:58]
  wire [32:0] adder_cout_result = _adder_cout_result_T_3 + _adder_cout_result_T_4; // @[Alu.scala 35:70]
  wire  adder_cout = adder_cout_result[32]; // @[Alu.scala 37:39]
  wire [31:0] add_sub_result = adder_cout_result[31:0]; // @[Alu.scala 38:39]
  wire  _slt_result_T_3 = io_data1[31] & ~io_data2[31]; // @[Alu.scala 41:36]
  wire  _slt_result_T_7 = ~adder_cout; // @[Alu.scala 42:58]
  wire  _slt_result_T_9 = _slt_result_T_3 | io_data1[31] == io_data2[31] & ~adder_cout; // @[Alu.scala 42:25]
  wire [31:0] slt_result = {31'h0,_slt_result_T_9}; // @[Cat.scala 31:58]
  wire [31:0] sltu_result = {31'h0,_slt_result_T_7}; // @[Cat.scala 31:58]
  wire [31:0] and_result = io_data1 & io_data2; // @[Alu.scala 44:26]
  wire [31:0] or_result = io_data1 | io_data2; // @[Alu.scala 45:26]
  wire [31:0] xor_result = io_data1 ^ io_data2; // @[Alu.scala 46:26]
  wire [62:0] _GEN_10 = {{31'd0}, io_data1}; // @[Alu.scala 47:26]
  wire [62:0] sll_result = _GEN_10 << io_data2[4:0]; // @[Alu.scala 47:26]
  wire  _data1_64_T_1 = op_sra & io_data1[31]; // @[Alu.scala 48:38]
  wire [31:0] _data1_64_T_3 = _data1_64_T_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 74:12]
  wire [63:0] data1_64 = {_data1_64_T_3,io_data1}; // @[Cat.scala 31:58]
  wire [63:0] sr64_result = data1_64 >> io_data2[4:0]; // @[Alu.scala 49:29]
  wire [31:0] sr_result = sr64_result[31:0]; // @[Alu.scala 50:32]
  wire [31:0] _GEN_0 = op_sra ? sr_result : 32'h0; // @[Alu.scala 84:23 85:14 87:14]
  wire [31:0] _GEN_1 = op_srl ? sr_result : _GEN_0; // @[Alu.scala 82:23 83:14]
  wire [62:0] _GEN_2 = op_sll ? sll_result : {{31'd0}, _GEN_1}; // @[Alu.scala 80:23 81:14]
  wire [62:0] _GEN_3 = op_xor ? {{31'd0}, xor_result} : _GEN_2; // @[Alu.scala 78:23 79:14]
  wire [62:0] _GEN_4 = op_or ? {{31'd0}, or_result} : _GEN_3; // @[Alu.scala 76:22 77:14]
  wire [62:0] _GEN_5 = op_and ? {{31'd0}, and_result} : _GEN_4; // @[Alu.scala 74:23 75:14]
  wire [62:0] _GEN_6 = op_sltu ? {{31'd0}, sltu_result} : _GEN_5; // @[Alu.scala 72:24 73:14]
  wire [62:0] _GEN_7 = op_slt ? {{31'd0}, slt_result} : _GEN_6; // @[Alu.scala 70:23 71:14]
  wire [62:0] _GEN_8 = op_sub ? {{31'd0}, add_sub_result} : _GEN_7; // @[Alu.scala 68:23 69:14]
  wire [62:0] _GEN_9 = op_add ? {{31'd0}, add_sub_result} : _GEN_8; // @[Alu.scala 66:17 67:14]
  assign io_result = _GEN_9[31:0]; // @[Alu.scala 16:20]
endmodule
module Mmu(
  input         io_MmuEn,
  input         io_MmuWen,
  input  [4:0]  io_MmuOp,
  input  [31:0] io_MmuRData2,
  output        io_data_sram_en,
  output        io_data_sram_wen,
  output [31:0] io_data_sram_wdata,
  output [1:0]  io_data_size,
  output        io_DataMemValid,
  output [4:0]  io_LoadOp
);
  wire  ByteS = io_MmuOp[0]; // @[Alu.scala 122:23]
  wire  HalfS = io_MmuOp[1]; // @[Alu.scala 123:23]
  wire  WordS = io_MmuOp[2]; // @[Alu.scala 124:23]
  wire  ByteU = io_MmuOp[3]; // @[Alu.scala 125:23]
  wire  HalfU = io_MmuOp[4]; // @[Alu.scala 126:23]
  wire [1:0] _GEN_0 = WordS ? 2'h3 : 2'h0; // @[Alu.scala 136:22 137:20 139:20]
  wire [1:0] _GEN_1 = HalfS | HalfU ? 2'h1 : _GEN_0; // @[Alu.scala 134:31 135:20]
  assign io_data_sram_en = io_MmuEn; // @[Alu.scala 143:25]
  assign io_data_sram_wen = io_MmuWen; // @[Alu.scala 130:29]
  assign io_data_sram_wdata = io_MmuRData2; // @[Alu.scala 145:25]
  assign io_data_size = ByteS | ByteU ? 2'h0 : _GEN_1; // @[Alu.scala 132:25 133:20]
  assign io_DataMemValid = io_MmuEn & ~io_MmuWen; // @[Alu.scala 146:34]
  assign io_LoadOp = io_MmuOp; // @[Alu.scala 147:25]
endmodule
module Pcu(
  input  [7:0]  io_PcuOp,
  input  [31:0] io_PcuData1,
  input  [31:0] io_PcuData2,
  output        io_PcJump,
  output [31:0] io_PcuResult
);
  wire  beq = io_PcuOp[0]; // @[Alu.scala 172:22]
  wire  bne = io_PcuOp[1]; // @[Alu.scala 173:22]
  wire  blt = io_PcuOp[2]; // @[Alu.scala 174:22]
  wire  bge = io_PcuOp[3]; // @[Alu.scala 175:22]
  wire  bltu = io_PcuOp[4]; // @[Alu.scala 176:22]
  wire  bgeu = io_PcuOp[5]; // @[Alu.scala 177:22]
  wire  jal = io_PcuOp[6]; // @[Alu.scala 178:22]
  wire  jalr = io_PcuOp[7]; // @[Alu.scala 179:22]
  wire  equil = io_PcuData1 == io_PcuData2; // @[Alu.scala 181:26]
  wire  _adder_b_T_2 = ~jal & ~jalr; // @[Alu.scala 184:31]
  wire [31:0] _adder_b_T_3 = ~io_PcuData2; // @[Alu.scala 184:43]
  wire [31:0] adder_b = ~jal & ~jalr ? _adder_b_T_3 : io_PcuData2; // @[Alu.scala 184:25]
  wire [31:0] adder_cin = _adder_b_T_2 ? 32'h1 : 32'h0; // @[Alu.scala 185:25]
  wire [32:0] _adder_cout_result_T = {1'h0,io_PcuData1}; // @[Cat.scala 31:58]
  wire [32:0] _adder_cout_result_T_1 = {1'h0,adder_b}; // @[Cat.scala 31:58]
  wire [32:0] _adder_cout_result_T_3 = _adder_cout_result_T + _adder_cout_result_T_1; // @[Alu.scala 187:46]
  wire [32:0] _adder_cout_result_T_4 = {1'h0,adder_cin}; // @[Cat.scala 31:58]
  wire [32:0] adder_cout_result = _adder_cout_result_T_3 + _adder_cout_result_T_4; // @[Alu.scala 187:70]
  wire  adder_cout = adder_cout_result[32]; // @[Alu.scala 189:39]
  wire [31:0] add_sub_result = adder_cout_result[31:0]; // @[Alu.scala 190:39]
  wire  _slt_result_T_7 = ~adder_cout; // @[Alu.scala 192:105]
  wire  slt_result = io_PcuData1[31] & ~io_PcuData2[31] | io_PcuData1[31] == io_PcuData2[31] & ~adder_cout; // @[Alu.scala 192:55]
  wire  _GEN_1 = jal | jalr; // @[Alu.scala 207:20 208:14]
  wire  _GEN_2 = bgeu ? ~_slt_result_T_7 : _GEN_1; // @[Alu.scala 205:21 206:14]
  wire  _GEN_3 = bltu ? _slt_result_T_7 : _GEN_2; // @[Alu.scala 203:21 204:14]
  wire  _GEN_4 = bge ? ~slt_result : _GEN_3; // @[Alu.scala 201:20 202:14]
  wire  _GEN_5 = blt ? slt_result : _GEN_4; // @[Alu.scala 199:20 200:14]
  wire  _GEN_6 = bne ? ~equil : _GEN_5; // @[Alu.scala 197:20 198:14]
  assign io_PcJump = beq ? equil : _GEN_6; // @[Alu.scala 195:12 196:14]
  assign io_PcuResult = _GEN_1 ? add_sub_result : 32'h0; // @[Alu.scala 215:24 216:17 218:17]
endmodule
module Csru(
  input  [5:0]  io_CsrOp,
  input  [31:0] io_CsrData,
  input  [31:0] io_CsrImm,
  output [31:0] io_CsrWData,
  output [31:0] io_CsrWbData
);
  wire  csrrw = io_CsrOp[0]; // @[Alu.scala 240:23]
  wire  csrrs = io_CsrOp[1]; // @[Alu.scala 241:23]
  wire  csrrc = io_CsrOp[2]; // @[Alu.scala 242:23]
  wire [31:0] CsrRDataS = io_CsrData | io_CsrImm; // @[Alu.scala 247:30]
  wire [31:0] _CsrRDataC_T = ~io_CsrImm; // @[Alu.scala 250:33]
  wire [31:0] CsrRDataC = io_CsrData & _CsrRDataC_T; // @[Alu.scala 250:30]
  wire [31:0] _GEN_0 = csrrc ? CsrRDataC : 32'h0; // @[Alu.scala 259:22 260:20 263:20]
  wire [31:0] _GEN_1 = csrrc ? io_CsrData : 32'h0; // @[Alu.scala 259:22 261:20 264:20]
  wire [31:0] _GEN_2 = csrrs ? CsrRDataS : _GEN_0; // @[Alu.scala 256:22 257:20]
  wire [31:0] _GEN_3 = csrrs ? io_CsrData : _GEN_1; // @[Alu.scala 256:22 258:20]
  assign io_CsrWData = csrrw ? io_CsrImm : _GEN_2; // @[Alu.scala 253:16 254:20]
  assign io_CsrWbData = csrrw ? io_CsrData : _GEN_3; // @[Alu.scala 253:16 255:20]
endmodule
module CoreExe(
  input         clock,
  input         reset,
  input         io_Mem_MemReady,
  output [31:0] io_Mem_Result,
  output [4:0]  io_Mem_Rd,
  output        io_Mem_WrValid,
  output        io_Mem_DataMemValid,
  output [4:0]  io_Mem_LoadOp,
  output        io_Mem_ExeValid,
  input  [9:0]  io_Id_AluOp,
  input  [31:0] io_Id_Data1,
  input  [31:0] io_Id_Data2,
  input         io_Id_MmuEn,
  input         io_Id_MmuWen,
  input  [4:0]  io_Id_MmuOp,
  input  [31:0] io_Id_MmuRData2,
  input         io_Id_PcuEn,
  input  [7:0]  io_Id_PcuOp,
  input  [31:0] io_Id_PcuData1,
  input  [31:0] io_Id_PcuData2,
  input  [4:0]  io_Id_Rd,
  output        io_Id_ExeReady,
  output        io_Id_PcJump,
  input         io_Id_CsrEn,
  input  [2:0]  io_Id_CsrOp,
  input  [11:0] io_Id_CsrWAddr,
  input  [31:0] io_Id_CsrData,
  input  [31:0] io_Id_CsrImm,
  input         io_Id_IdValid,
  output        io_Data_data_sram_en,
  output        io_Data_data_sram_wen,
  output [31:0] io_Data_data_sram_addr,
  output [31:0] io_Data_data_sram_wdata,
  output [1:0]  io_Data_data_size,
  output        io_If_PcJump,
  output        io_PreIf_PcJump,
  output [31:0] io_PreIf_NextPc,
  output [11:0] io_CsrReg_CsrAddr,
  output [31:0] io_CsrReg_CsrData,
  output [31:0] io_DebugResult,
  output [4:0]  io_DebugRd_r,
  output        io_DebugDataEn,
  output        io_DebugDataWen,
  output [31:0] io_DebugDataWdata,
  output [1:0]  io_DebugDataSize,
  output        io_DebugDataMemValid,
  output [4:0]  io_DebugLoadOp,
  output        io_DebugPcJump,
  output [31:0] io_DebugNextPc,
  output [11:0] io_DebugCsrWAddr,
  output [31:0] io_DebugCsrWData,
  output        io_DebugExeValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  wire [9:0] ALU_io_op; // @[Core_exe.scala 63:21]
  wire [31:0] ALU_io_data1; // @[Core_exe.scala 63:21]
  wire [31:0] ALU_io_data2; // @[Core_exe.scala 63:21]
  wire [31:0] ALU_io_result; // @[Core_exe.scala 63:21]
  wire  Mmu_io_MmuEn; // @[Core_exe.scala 64:21]
  wire  Mmu_io_MmuWen; // @[Core_exe.scala 64:21]
  wire [4:0] Mmu_io_MmuOp; // @[Core_exe.scala 64:21]
  wire [31:0] Mmu_io_MmuRData2; // @[Core_exe.scala 64:21]
  wire  Mmu_io_data_sram_en; // @[Core_exe.scala 64:21]
  wire  Mmu_io_data_sram_wen; // @[Core_exe.scala 64:21]
  wire [31:0] Mmu_io_data_sram_wdata; // @[Core_exe.scala 64:21]
  wire [1:0] Mmu_io_data_size; // @[Core_exe.scala 64:21]
  wire  Mmu_io_DataMemValid; // @[Core_exe.scala 64:21]
  wire [4:0] Mmu_io_LoadOp; // @[Core_exe.scala 64:21]
  wire [7:0] Pcu_io_PcuOp; // @[Core_exe.scala 65:21]
  wire [31:0] Pcu_io_PcuData1; // @[Core_exe.scala 65:21]
  wire [31:0] Pcu_io_PcuData2; // @[Core_exe.scala 65:21]
  wire  Pcu_io_PcJump; // @[Core_exe.scala 65:21]
  wire [31:0] Pcu_io_PcuResult; // @[Core_exe.scala 65:21]
  wire [5:0] Csru_io_CsrOp; // @[Core_exe.scala 66:21]
  wire [31:0] Csru_io_CsrData; // @[Core_exe.scala 66:21]
  wire [31:0] Csru_io_CsrImm; // @[Core_exe.scala 66:21]
  wire [31:0] Csru_io_CsrWData; // @[Core_exe.scala 66:21]
  wire [31:0] Csru_io_CsrWbData; // @[Core_exe.scala 66:21]
  reg [31:0] Result; // @[Core_exe.scala 90:31]
  reg [4:0] Rd_r; // @[Core_exe.scala 91:31]
  reg  DataEn; // @[Core_exe.scala 92:31]
  reg  DataWen; // @[Core_exe.scala 93:31]
  reg [31:0] DataWdata; // @[Core_exe.scala 94:31]
  reg [1:0] DataSize; // @[Core_exe.scala 95:31]
  reg  DataMemValid; // @[Core_exe.scala 96:31]
  reg [4:0] LoadOp; // @[Core_exe.scala 97:31]
  reg  PcJump; // @[Core_exe.scala 98:31]
  reg [31:0] NextPc; // @[Core_exe.scala 99:31]
  reg [11:0] CsrWAddr; // @[Core_exe.scala 100:31]
  reg [31:0] CsrWData; // @[Core_exe.scala 101:31]
  reg  ExeValid; // @[Core_exe.scala 102:31]
  wire  ExeEn = (io_Mem_MemReady | ~ExeValid) & io_Id_IdValid; // @[Core_exe.scala 105:48]
  wire [31:0] _Result_T = io_Id_PcuEn ? Pcu_io_PcuResult : ALU_io_result; // @[Core_exe.scala 168:56]
  wire  _GEN_0 = io_Mem_MemReady & ~ExeEn ? 1'h0 : ExeValid; // @[Core_exe.scala 183:35 184:19 199:21]
  wire  _GEN_25 = ExeEn | _GEN_0; // @[Core_exe.scala 167:22 180:22]
  ALU ALU ( // @[Core_exe.scala 63:21]
    .io_op(ALU_io_op),
    .io_data1(ALU_io_data1),
    .io_data2(ALU_io_data2),
    .io_result(ALU_io_result)
  );
  Mmu Mmu ( // @[Core_exe.scala 64:21]
    .io_MmuEn(Mmu_io_MmuEn),
    .io_MmuWen(Mmu_io_MmuWen),
    .io_MmuOp(Mmu_io_MmuOp),
    .io_MmuRData2(Mmu_io_MmuRData2),
    .io_data_sram_en(Mmu_io_data_sram_en),
    .io_data_sram_wen(Mmu_io_data_sram_wen),
    .io_data_sram_wdata(Mmu_io_data_sram_wdata),
    .io_data_size(Mmu_io_data_size),
    .io_DataMemValid(Mmu_io_DataMemValid),
    .io_LoadOp(Mmu_io_LoadOp)
  );
  Pcu Pcu ( // @[Core_exe.scala 65:21]
    .io_PcuOp(Pcu_io_PcuOp),
    .io_PcuData1(Pcu_io_PcuData1),
    .io_PcuData2(Pcu_io_PcuData2),
    .io_PcJump(Pcu_io_PcJump),
    .io_PcuResult(Pcu_io_PcuResult)
  );
  Csru Csru ( // @[Core_exe.scala 66:21]
    .io_CsrOp(Csru_io_CsrOp),
    .io_CsrData(Csru_io_CsrData),
    .io_CsrImm(Csru_io_CsrImm),
    .io_CsrWData(Csru_io_CsrWData),
    .io_CsrWbData(Csru_io_CsrWbData)
  );
  assign io_Mem_Result = Result; // @[Core_exe.scala 133:19]
  assign io_Mem_Rd = Rd_r; // @[Core_exe.scala 134:19]
  assign io_Mem_WrValid = DataEn & DataWen; // @[Core_exe.scala 136:35]
  assign io_Mem_DataMemValid = DataMemValid; // @[Core_exe.scala 135:25]
  assign io_Mem_LoadOp = LoadOp; // @[Core_exe.scala 137:25]
  assign io_Mem_ExeValid = ExeValid; // @[Core_exe.scala 138:25]
  assign io_Id_ExeReady = (io_Mem_MemReady | ~ExeValid) & io_Id_IdValid; // @[Core_exe.scala 105:48]
  assign io_Id_PcJump = PcJump; // @[Core_exe.scala 143:19]
  assign io_Data_data_sram_en = DataEn & ~io_Mem_MemReady; // @[Core_exe.scala 126:38]
  assign io_Data_data_sram_wen = DataWen; // @[Core_exe.scala 127:28]
  assign io_Data_data_sram_addr = Result; // @[Core_exe.scala 128:28]
  assign io_Data_data_sram_wdata = DataWdata; // @[Core_exe.scala 129:28]
  assign io_Data_data_size = DataSize; // @[Core_exe.scala 130:28]
  assign io_If_PcJump = PcJump; // @[Core_exe.scala 144:19]
  assign io_PreIf_PcJump = PcJump; // @[Core_exe.scala 145:22]
  assign io_PreIf_NextPc = NextPc; // @[Core_exe.scala 146:22]
  assign io_CsrReg_CsrAddr = CsrWAddr; // @[Core_exe.scala 148:23]
  assign io_CsrReg_CsrData = CsrWData; // @[Core_exe.scala 149:23]
  assign io_DebugResult = Result; // @[Core_exe.scala 202:22]
  assign io_DebugRd_r = Rd_r; // @[Core_exe.scala 203:22]
  assign io_DebugDataEn = DataEn; // @[Core_exe.scala 204:22]
  assign io_DebugDataWen = DataWen; // @[Core_exe.scala 205:22]
  assign io_DebugDataWdata = DataWdata; // @[Core_exe.scala 206:22]
  assign io_DebugDataSize = DataSize; // @[Core_exe.scala 207:22]
  assign io_DebugDataMemValid = DataMemValid; // @[Core_exe.scala 208:22]
  assign io_DebugLoadOp = LoadOp; // @[Core_exe.scala 209:22]
  assign io_DebugPcJump = PcJump; // @[Core_exe.scala 210:22]
  assign io_DebugNextPc = NextPc; // @[Core_exe.scala 211:22]
  assign io_DebugCsrWAddr = CsrWAddr; // @[Core_exe.scala 212:22]
  assign io_DebugCsrWData = CsrWData; // @[Core_exe.scala 213:22]
  assign io_DebugExeValid = ExeValid; // @[Core_exe.scala 214:22]
  assign ALU_io_op = io_Id_AluOp; // @[Core_exe.scala 108:17]
  assign ALU_io_data1 = io_Id_Data1; // @[Core_exe.scala 109:17]
  assign ALU_io_data2 = io_Id_Data2; // @[Core_exe.scala 110:17]
  assign Mmu_io_MmuEn = io_Id_MmuEn; // @[Core_exe.scala 113:22]
  assign Mmu_io_MmuWen = io_Id_MmuWen; // @[Core_exe.scala 114:22]
  assign Mmu_io_MmuOp = io_Id_MmuOp; // @[Core_exe.scala 115:22]
  assign Mmu_io_MmuRData2 = io_Id_MmuRData2; // @[Core_exe.scala 116:22]
  assign Pcu_io_PcuOp = io_Id_PcuOp; // @[Core_exe.scala 118:22]
  assign Pcu_io_PcuData1 = io_Id_PcuData1; // @[Core_exe.scala 119:22]
  assign Pcu_io_PcuData2 = io_Id_PcuData2; // @[Core_exe.scala 120:22]
  assign Csru_io_CsrOp = {{3'd0}, io_Id_CsrOp}; // @[Core_exe.scala 122:22]
  assign Csru_io_CsrData = io_Id_CsrData; // @[Core_exe.scala 123:22]
  assign Csru_io_CsrImm = io_Id_CsrImm; // @[Core_exe.scala 124:22]
  always @(posedge clock) begin
    if (reset) begin // @[Core_exe.scala 90:31]
      Result <= 32'h0; // @[Core_exe.scala 90:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      Result <= 32'h0; // @[Core_exe.scala 152:15]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      if (io_Id_CsrEn) begin // @[Core_exe.scala 168:22]
        Result <= Csru_io_CsrWbData;
      end else begin
        Result <= _Result_T;
      end
    end
    if (reset) begin // @[Core_exe.scala 91:31]
      Rd_r <= 5'h0; // @[Core_exe.scala 91:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      Rd_r <= 5'h0; // @[Core_exe.scala 153:15]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      Rd_r <= io_Id_Rd; // @[Core_exe.scala 169:16]
    end
    if (reset) begin // @[Core_exe.scala 92:31]
      DataEn <= 1'h0; // @[Core_exe.scala 92:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      DataEn <= 1'h0; // @[Core_exe.scala 154:19]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      DataEn <= Mmu_io_data_sram_en; // @[Core_exe.scala 170:20]
    end else if (io_Mem_MemReady & ~ExeEn) begin // @[Core_exe.scala 183:35]
      DataEn <= 1'h0; // @[Core_exe.scala 185:19]
    end
    if (reset) begin // @[Core_exe.scala 93:31]
      DataWen <= 1'h0; // @[Core_exe.scala 93:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      DataWen <= 1'h0; // @[Core_exe.scala 155:19]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      DataWen <= Mmu_io_data_sram_wen; // @[Core_exe.scala 171:20]
    end
    if (reset) begin // @[Core_exe.scala 94:31]
      DataWdata <= 32'h0; // @[Core_exe.scala 94:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      DataWdata <= 32'h0; // @[Core_exe.scala 156:19]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      DataWdata <= Mmu_io_data_sram_wdata; // @[Core_exe.scala 172:20]
    end
    if (reset) begin // @[Core_exe.scala 95:31]
      DataSize <= 2'h0; // @[Core_exe.scala 95:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      DataSize <= 2'h0; // @[Core_exe.scala 157:19]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      DataSize <= Mmu_io_data_size; // @[Core_exe.scala 173:20]
    end
    if (reset) begin // @[Core_exe.scala 96:31]
      DataMemValid <= 1'h0; // @[Core_exe.scala 96:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      DataMemValid <= 1'h0; // @[Core_exe.scala 158:21]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      DataMemValid <= Mmu_io_DataMemValid; // @[Core_exe.scala 174:22]
    end
    if (reset) begin // @[Core_exe.scala 97:31]
      LoadOp <= 5'h0; // @[Core_exe.scala 97:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      LoadOp <= 5'h0; // @[Core_exe.scala 159:21]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      LoadOp <= Mmu_io_LoadOp; // @[Core_exe.scala 175:22]
    end
    if (reset) begin // @[Core_exe.scala 98:31]
      PcJump <= 1'h0; // @[Core_exe.scala 98:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      PcJump <= 1'h0; // @[Core_exe.scala 160:21]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      PcJump <= Pcu_io_PcJump; // @[Core_exe.scala 176:22]
    end
    if (reset) begin // @[Core_exe.scala 99:31]
      NextPc <= 32'h0; // @[Core_exe.scala 99:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      NextPc <= 32'h0; // @[Core_exe.scala 161:21]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      NextPc <= ALU_io_result; // @[Core_exe.scala 177:22]
    end
    if (reset) begin // @[Core_exe.scala 100:31]
      CsrWAddr <= 12'h0; // @[Core_exe.scala 100:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      CsrWAddr <= 12'h0; // @[Core_exe.scala 162:21]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      CsrWAddr <= io_Id_CsrWAddr; // @[Core_exe.scala 178:22]
    end
    if (reset) begin // @[Core_exe.scala 101:31]
      CsrWData <= 32'h0; // @[Core_exe.scala 101:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      CsrWData <= 32'h0; // @[Core_exe.scala 163:21]
    end else if (ExeEn) begin // @[Core_exe.scala 167:22]
      CsrWData <= Csru_io_CsrWData; // @[Core_exe.scala 179:22]
    end
    if (reset) begin // @[Core_exe.scala 102:31]
      ExeValid <= 1'h0; // @[Core_exe.scala 102:31]
    end else if (PcJump) begin // @[Core_exe.scala 151:18]
      ExeValid <= 1'h0; // @[Core_exe.scala 164:21]
    end else begin
      ExeValid <= _GEN_25;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Result = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Rd_r = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  DataEn = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  DataWen = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  DataWdata = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  DataSize = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  DataMemValid = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  LoadOp = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  PcJump = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  NextPc = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  CsrWAddr = _RAND_10[11:0];
  _RAND_11 = {1{`RANDOM}};
  CsrWData = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  ExeValid = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CoreMem(
  input         clock,
  input         reset,
  output        io_Exe_MemReady,
  input  [31:0] io_Exe_Result,
  input  [4:0]  io_Exe_Rd,
  input         io_Exe_WrValid,
  input         io_Exe_DataMemValid,
  input  [4:0]  io_Exe_LoadOp,
  input         io_Exe_ExeValid,
  output [31:0] io_Wb_WData,
  output [4:0]  io_Wb_Rd,
  input  [31:0] io_Data_data_sram_rdata,
  input         io_Data_data_ok,
  input         io_Data_data_addr_ok,
  output [31:0] io_DebugWData,
  output [4:0]  io_DebugRd_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] WData; // @[Core_mem.scala 45:20]
  reg [4:0] Rd_r; // @[Core_mem.scala 46:20]
  wire  MemEn = io_Exe_ExeValid & ((io_Data_data_ok | ~io_Exe_DataMemValid) & (io_Data_data_addr_ok | ~io_Exe_WrValid)); // @[Core_mem.scala 52:36]
  wire  ByteS = io_Exe_LoadOp[0]; // @[Core_mem.scala 55:21]
  wire  HalfS = io_Exe_LoadOp[1]; // @[Core_mem.scala 56:21]
  wire  WordS = io_Exe_LoadOp[2]; // @[Core_mem.scala 57:21]
  wire  ByteU = io_Exe_LoadOp[3]; // @[Core_mem.scala 58:21]
  wire  HalfU = io_Exe_LoadOp[4]; // @[Core_mem.scala 59:21]
  wire [23:0] _WbData_T_2 = io_Data_data_sram_rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _WbData_T_4 = {_WbData_T_2,io_Data_data_sram_rdata[7:0]}; // @[Cat.scala 31:58]
  wire [15:0] _WbData_T_7 = io_Data_data_sram_rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _WbData_T_9 = {_WbData_T_7,io_Data_data_sram_rdata[15:0]}; // @[Cat.scala 31:58]
  wire [31:0] _WbData_T_13 = {24'h0,io_Data_data_sram_rdata[7:0]}; // @[Cat.scala 31:58]
  wire [31:0] _WbData_T_16 = {16'h0,io_Data_data_sram_rdata[15:0]}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_0 = HalfU ? _WbData_T_16 : 32'h0; // @[Core_mem.scala 70:22 71:14 73:14]
  wire [31:0] _GEN_1 = ByteU ? _WbData_T_13 : _GEN_0; // @[Core_mem.scala 68:22 69:14]
  wire [31:0] _GEN_2 = WordS ? io_Data_data_sram_rdata : _GEN_1; // @[Core_mem.scala 66:22 67:14]
  wire [31:0] _GEN_3 = HalfS ? _WbData_T_9 : _GEN_2; // @[Core_mem.scala 64:22 65:14]
  assign io_Exe_MemReady = io_Exe_ExeValid & ((io_Data_data_ok | ~io_Exe_DataMemValid) & (io_Data_data_addr_ok | ~
    io_Exe_WrValid)); // @[Core_mem.scala 52:36]
  assign io_Wb_WData = WData; // @[Core_mem.scala 96:17]
  assign io_Wb_Rd = Rd_r; // @[Core_mem.scala 97:17]
  assign io_DebugWData = WData; // @[Core_mem.scala 98:22]
  assign io_DebugRd_r = Rd_r; // @[Core_mem.scala 99:22]
  always @(posedge clock) begin
    if (reset) begin // @[Core_mem.scala 45:20]
      WData <= 32'h0; // @[Core_mem.scala 45:20]
    end else if (MemEn) begin // @[Core_mem.scala 80:12]
      if (io_Exe_DataMemValid) begin // @[Core_mem.scala 61:21]
        if (ByteS) begin // @[Core_mem.scala 62:16]
          WData <= _WbData_T_4; // @[Core_mem.scala 63:14]
        end else begin
          WData <= _GEN_3;
        end
      end else begin
        WData <= io_Exe_Result; // @[Core_mem.scala 76:14]
      end
    end
    if (reset) begin // @[Core_mem.scala 46:20]
      Rd_r <= 5'h0; // @[Core_mem.scala 46:20]
    end else if (MemEn) begin // @[Core_mem.scala 80:12]
      Rd_r <= io_Exe_Rd; // @[Core_mem.scala 82:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  WData = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Rd_r = _RAND_1[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CoreWb(
  input  [31:0] io_Mem_WData,
  input  [4:0]  io_Mem_Rd,
  output [4:0]  io_RegFile_Rd,
  output [31:0] io_RegFile_WData
);
  assign io_RegFile_Rd = io_Mem_Rd; // @[Core_wb.scala 13:18]
  assign io_RegFile_WData = io_Mem_WData; // @[Core_wb.scala 14:18]
endmodule
module RegFile(
  input         clock,
  input         reset,
  input  [4:0]  io_Id_Rs1,
  input  [4:0]  io_Id_Rs2,
  input  [4:0]  io_Id_Rd,
  output [31:0] io_Id_RData1,
  output [31:0] io_Id_RData2,
  output        io_Id_RValid,
  input  [4:0]  io_Wb_Rd,
  input  [31:0] io_Wb_WData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] RegStack_0; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_1; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_2; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_3; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_4; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_5; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_6; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_7; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_8; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_9; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_10; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_11; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_12; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_13; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_14; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_15; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_16; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_17; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_18; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_19; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_20; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_21; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_22; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_23; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_24; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_25; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_26; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_27; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_28; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_29; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_30; // @[RegFile.scala 28:25]
  reg [31:0] RegStack_31; // @[RegFile.scala 28:25]
  reg  RegDirty_0; // @[RegFile.scala 29:25]
  reg  RegDirty_1; // @[RegFile.scala 29:25]
  reg  RegDirty_2; // @[RegFile.scala 29:25]
  reg  RegDirty_3; // @[RegFile.scala 29:25]
  reg  RegDirty_4; // @[RegFile.scala 29:25]
  reg  RegDirty_5; // @[RegFile.scala 29:25]
  reg  RegDirty_6; // @[RegFile.scala 29:25]
  reg  RegDirty_7; // @[RegFile.scala 29:25]
  reg  RegDirty_8; // @[RegFile.scala 29:25]
  reg  RegDirty_9; // @[RegFile.scala 29:25]
  reg  RegDirty_10; // @[RegFile.scala 29:25]
  reg  RegDirty_11; // @[RegFile.scala 29:25]
  reg  RegDirty_12; // @[RegFile.scala 29:25]
  reg  RegDirty_13; // @[RegFile.scala 29:25]
  reg  RegDirty_14; // @[RegFile.scala 29:25]
  reg  RegDirty_15; // @[RegFile.scala 29:25]
  reg  RegDirty_16; // @[RegFile.scala 29:25]
  reg  RegDirty_17; // @[RegFile.scala 29:25]
  reg  RegDirty_18; // @[RegFile.scala 29:25]
  reg  RegDirty_19; // @[RegFile.scala 29:25]
  reg  RegDirty_20; // @[RegFile.scala 29:25]
  reg  RegDirty_21; // @[RegFile.scala 29:25]
  reg  RegDirty_22; // @[RegFile.scala 29:25]
  reg  RegDirty_23; // @[RegFile.scala 29:25]
  reg  RegDirty_24; // @[RegFile.scala 29:25]
  reg  RegDirty_25; // @[RegFile.scala 29:25]
  reg  RegDirty_26; // @[RegFile.scala 29:25]
  reg  RegDirty_27; // @[RegFile.scala 29:25]
  reg  RegDirty_28; // @[RegFile.scala 29:25]
  reg  RegDirty_29; // @[RegFile.scala 29:25]
  reg  RegDirty_30; // @[RegFile.scala 29:25]
  reg  RegDirty_31; // @[RegFile.scala 29:25]
  wire  _GEN_1 = 5'h1 == io_Id_Rs1 ? RegDirty_1 : RegDirty_0; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_2 = 5'h2 == io_Id_Rs1 ? RegDirty_2 : _GEN_1; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_3 = 5'h3 == io_Id_Rs1 ? RegDirty_3 : _GEN_2; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_4 = 5'h4 == io_Id_Rs1 ? RegDirty_4 : _GEN_3; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_5 = 5'h5 == io_Id_Rs1 ? RegDirty_5 : _GEN_4; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_6 = 5'h6 == io_Id_Rs1 ? RegDirty_6 : _GEN_5; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_7 = 5'h7 == io_Id_Rs1 ? RegDirty_7 : _GEN_6; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_8 = 5'h8 == io_Id_Rs1 ? RegDirty_8 : _GEN_7; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_9 = 5'h9 == io_Id_Rs1 ? RegDirty_9 : _GEN_8; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_10 = 5'ha == io_Id_Rs1 ? RegDirty_10 : _GEN_9; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_11 = 5'hb == io_Id_Rs1 ? RegDirty_11 : _GEN_10; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_12 = 5'hc == io_Id_Rs1 ? RegDirty_12 : _GEN_11; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_13 = 5'hd == io_Id_Rs1 ? RegDirty_13 : _GEN_12; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_14 = 5'he == io_Id_Rs1 ? RegDirty_14 : _GEN_13; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_15 = 5'hf == io_Id_Rs1 ? RegDirty_15 : _GEN_14; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_16 = 5'h10 == io_Id_Rs1 ? RegDirty_16 : _GEN_15; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_17 = 5'h11 == io_Id_Rs1 ? RegDirty_17 : _GEN_16; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_18 = 5'h12 == io_Id_Rs1 ? RegDirty_18 : _GEN_17; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_19 = 5'h13 == io_Id_Rs1 ? RegDirty_19 : _GEN_18; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_20 = 5'h14 == io_Id_Rs1 ? RegDirty_20 : _GEN_19; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_21 = 5'h15 == io_Id_Rs1 ? RegDirty_21 : _GEN_20; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_22 = 5'h16 == io_Id_Rs1 ? RegDirty_22 : _GEN_21; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_23 = 5'h17 == io_Id_Rs1 ? RegDirty_23 : _GEN_22; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_24 = 5'h18 == io_Id_Rs1 ? RegDirty_24 : _GEN_23; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_25 = 5'h19 == io_Id_Rs1 ? RegDirty_25 : _GEN_24; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_26 = 5'h1a == io_Id_Rs1 ? RegDirty_26 : _GEN_25; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_27 = 5'h1b == io_Id_Rs1 ? RegDirty_27 : _GEN_26; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_28 = 5'h1c == io_Id_Rs1 ? RegDirty_28 : _GEN_27; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_29 = 5'h1d == io_Id_Rs1 ? RegDirty_29 : _GEN_28; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_30 = 5'h1e == io_Id_Rs1 ? RegDirty_30 : _GEN_29; // @[RegFile.scala 41:{41,41}]
  wire  _GEN_31 = 5'h1f == io_Id_Rs1 ? RegDirty_31 : _GEN_30; // @[RegFile.scala 41:{41,41}]
  wire  _RValid1_T_1 = ~_GEN_31; // @[RegFile.scala 41:41]
  wire  RValid1 = io_Id_Rs1 == 5'h0 | ~_GEN_31; // @[RegFile.scala 41:21]
  wire  _GEN_33 = 5'h1 == io_Id_Rs2 ? RegDirty_1 : RegDirty_0; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_34 = 5'h2 == io_Id_Rs2 ? RegDirty_2 : _GEN_33; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_35 = 5'h3 == io_Id_Rs2 ? RegDirty_3 : _GEN_34; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_36 = 5'h4 == io_Id_Rs2 ? RegDirty_4 : _GEN_35; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_37 = 5'h5 == io_Id_Rs2 ? RegDirty_5 : _GEN_36; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_38 = 5'h6 == io_Id_Rs2 ? RegDirty_6 : _GEN_37; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_39 = 5'h7 == io_Id_Rs2 ? RegDirty_7 : _GEN_38; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_40 = 5'h8 == io_Id_Rs2 ? RegDirty_8 : _GEN_39; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_41 = 5'h9 == io_Id_Rs2 ? RegDirty_9 : _GEN_40; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_42 = 5'ha == io_Id_Rs2 ? RegDirty_10 : _GEN_41; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_43 = 5'hb == io_Id_Rs2 ? RegDirty_11 : _GEN_42; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_44 = 5'hc == io_Id_Rs2 ? RegDirty_12 : _GEN_43; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_45 = 5'hd == io_Id_Rs2 ? RegDirty_13 : _GEN_44; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_46 = 5'he == io_Id_Rs2 ? RegDirty_14 : _GEN_45; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_47 = 5'hf == io_Id_Rs2 ? RegDirty_15 : _GEN_46; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_48 = 5'h10 == io_Id_Rs2 ? RegDirty_16 : _GEN_47; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_49 = 5'h11 == io_Id_Rs2 ? RegDirty_17 : _GEN_48; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_50 = 5'h12 == io_Id_Rs2 ? RegDirty_18 : _GEN_49; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_51 = 5'h13 == io_Id_Rs2 ? RegDirty_19 : _GEN_50; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_52 = 5'h14 == io_Id_Rs2 ? RegDirty_20 : _GEN_51; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_53 = 5'h15 == io_Id_Rs2 ? RegDirty_21 : _GEN_52; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_54 = 5'h16 == io_Id_Rs2 ? RegDirty_22 : _GEN_53; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_55 = 5'h17 == io_Id_Rs2 ? RegDirty_23 : _GEN_54; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_56 = 5'h18 == io_Id_Rs2 ? RegDirty_24 : _GEN_55; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_57 = 5'h19 == io_Id_Rs2 ? RegDirty_25 : _GEN_56; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_58 = 5'h1a == io_Id_Rs2 ? RegDirty_26 : _GEN_57; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_59 = 5'h1b == io_Id_Rs2 ? RegDirty_27 : _GEN_58; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_60 = 5'h1c == io_Id_Rs2 ? RegDirty_28 : _GEN_59; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_61 = 5'h1d == io_Id_Rs2 ? RegDirty_29 : _GEN_60; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_62 = 5'h1e == io_Id_Rs2 ? RegDirty_30 : _GEN_61; // @[RegFile.scala 42:{41,41}]
  wire  _GEN_63 = 5'h1f == io_Id_Rs2 ? RegDirty_31 : _GEN_62; // @[RegFile.scala 42:{41,41}]
  wire  _RValid2_T_1 = ~_GEN_63; // @[RegFile.scala 42:41]
  wire  RValid2 = io_Id_Rs2 == 5'h0 | ~_GEN_63; // @[RegFile.scala 42:21]
  wire [31:0] _GEN_65 = 5'h1 == io_Id_Rs1 ? RegStack_1 : RegStack_0; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_66 = 5'h2 == io_Id_Rs1 ? RegStack_2 : _GEN_65; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_67 = 5'h3 == io_Id_Rs1 ? RegStack_3 : _GEN_66; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_68 = 5'h4 == io_Id_Rs1 ? RegStack_4 : _GEN_67; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_69 = 5'h5 == io_Id_Rs1 ? RegStack_5 : _GEN_68; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_70 = 5'h6 == io_Id_Rs1 ? RegStack_6 : _GEN_69; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_71 = 5'h7 == io_Id_Rs1 ? RegStack_7 : _GEN_70; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_72 = 5'h8 == io_Id_Rs1 ? RegStack_8 : _GEN_71; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_73 = 5'h9 == io_Id_Rs1 ? RegStack_9 : _GEN_72; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_74 = 5'ha == io_Id_Rs1 ? RegStack_10 : _GEN_73; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_75 = 5'hb == io_Id_Rs1 ? RegStack_11 : _GEN_74; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_76 = 5'hc == io_Id_Rs1 ? RegStack_12 : _GEN_75; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_77 = 5'hd == io_Id_Rs1 ? RegStack_13 : _GEN_76; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_78 = 5'he == io_Id_Rs1 ? RegStack_14 : _GEN_77; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_79 = 5'hf == io_Id_Rs1 ? RegStack_15 : _GEN_78; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_80 = 5'h10 == io_Id_Rs1 ? RegStack_16 : _GEN_79; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_81 = 5'h11 == io_Id_Rs1 ? RegStack_17 : _GEN_80; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_82 = 5'h12 == io_Id_Rs1 ? RegStack_18 : _GEN_81; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_83 = 5'h13 == io_Id_Rs1 ? RegStack_19 : _GEN_82; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_84 = 5'h14 == io_Id_Rs1 ? RegStack_20 : _GEN_83; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_85 = 5'h15 == io_Id_Rs1 ? RegStack_21 : _GEN_84; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_86 = 5'h16 == io_Id_Rs1 ? RegStack_22 : _GEN_85; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_87 = 5'h17 == io_Id_Rs1 ? RegStack_23 : _GEN_86; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_88 = 5'h18 == io_Id_Rs1 ? RegStack_24 : _GEN_87; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_89 = 5'h19 == io_Id_Rs1 ? RegStack_25 : _GEN_88; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_90 = 5'h1a == io_Id_Rs1 ? RegStack_26 : _GEN_89; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_91 = 5'h1b == io_Id_Rs1 ? RegStack_27 : _GEN_90; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_92 = 5'h1c == io_Id_Rs1 ? RegStack_28 : _GEN_91; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_93 = 5'h1d == io_Id_Rs1 ? RegStack_29 : _GEN_92; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_94 = 5'h1e == io_Id_Rs1 ? RegStack_30 : _GEN_93; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_95 = 5'h1f == io_Id_Rs1 ? RegStack_31 : _GEN_94; // @[RegFile.scala 45:{22,22}]
  wire [31:0] _GEN_97 = 5'h1 == io_Id_Rs2 ? RegStack_1 : RegStack_0; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_98 = 5'h2 == io_Id_Rs2 ? RegStack_2 : _GEN_97; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_99 = 5'h3 == io_Id_Rs2 ? RegStack_3 : _GEN_98; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_100 = 5'h4 == io_Id_Rs2 ? RegStack_4 : _GEN_99; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_101 = 5'h5 == io_Id_Rs2 ? RegStack_5 : _GEN_100; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_102 = 5'h6 == io_Id_Rs2 ? RegStack_6 : _GEN_101; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_103 = 5'h7 == io_Id_Rs2 ? RegStack_7 : _GEN_102; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_104 = 5'h8 == io_Id_Rs2 ? RegStack_8 : _GEN_103; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_105 = 5'h9 == io_Id_Rs2 ? RegStack_9 : _GEN_104; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_106 = 5'ha == io_Id_Rs2 ? RegStack_10 : _GEN_105; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_107 = 5'hb == io_Id_Rs2 ? RegStack_11 : _GEN_106; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_108 = 5'hc == io_Id_Rs2 ? RegStack_12 : _GEN_107; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_109 = 5'hd == io_Id_Rs2 ? RegStack_13 : _GEN_108; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_110 = 5'he == io_Id_Rs2 ? RegStack_14 : _GEN_109; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_111 = 5'hf == io_Id_Rs2 ? RegStack_15 : _GEN_110; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_112 = 5'h10 == io_Id_Rs2 ? RegStack_16 : _GEN_111; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_113 = 5'h11 == io_Id_Rs2 ? RegStack_17 : _GEN_112; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_114 = 5'h12 == io_Id_Rs2 ? RegStack_18 : _GEN_113; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_115 = 5'h13 == io_Id_Rs2 ? RegStack_19 : _GEN_114; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_116 = 5'h14 == io_Id_Rs2 ? RegStack_20 : _GEN_115; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_117 = 5'h15 == io_Id_Rs2 ? RegStack_21 : _GEN_116; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_118 = 5'h16 == io_Id_Rs2 ? RegStack_22 : _GEN_117; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_119 = 5'h17 == io_Id_Rs2 ? RegStack_23 : _GEN_118; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_120 = 5'h18 == io_Id_Rs2 ? RegStack_24 : _GEN_119; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_121 = 5'h19 == io_Id_Rs2 ? RegStack_25 : _GEN_120; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_122 = 5'h1a == io_Id_Rs2 ? RegStack_26 : _GEN_121; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_123 = 5'h1b == io_Id_Rs2 ? RegStack_27 : _GEN_122; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_124 = 5'h1c == io_Id_Rs2 ? RegStack_28 : _GEN_123; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_125 = 5'h1d == io_Id_Rs2 ? RegStack_29 : _GEN_124; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_126 = 5'h1e == io_Id_Rs2 ? RegStack_30 : _GEN_125; // @[RegFile.scala 46:{22,22}]
  wire [31:0] _GEN_127 = 5'h1f == io_Id_Rs2 ? RegStack_31 : _GEN_126; // @[RegFile.scala 46:{22,22}]
  assign io_Id_RData1 = _RValid1_T_1 ? _GEN_95 : 32'h0; // @[RegFile.scala 45:22]
  assign io_Id_RData2 = _RValid2_T_1 ? _GEN_127 : 32'h0; // @[RegFile.scala 46:22]
  assign io_Id_RValid = RValid1 & RValid2; // @[RegFile.scala 44:27]
  always @(posedge clock) begin
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_0 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h0 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_0 <= 32'h0;
      end else begin
        RegStack_0 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_1 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_1 <= 32'h0;
      end else begin
        RegStack_1 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_2 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h2 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_2 <= 32'h0;
      end else begin
        RegStack_2 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_3 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h3 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_3 <= 32'h0;
      end else begin
        RegStack_3 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_4 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h4 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_4 <= 32'h0;
      end else begin
        RegStack_4 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_5 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h5 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_5 <= 32'h0;
      end else begin
        RegStack_5 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_6 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h6 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_6 <= 32'h0;
      end else begin
        RegStack_6 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_7 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h7 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_7 <= 32'h0;
      end else begin
        RegStack_7 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_8 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h8 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_8 <= 32'h0;
      end else begin
        RegStack_8 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_9 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h9 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_9 <= 32'h0;
      end else begin
        RegStack_9 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_10 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'ha == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_10 <= 32'h0;
      end else begin
        RegStack_10 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_11 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'hb == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_11 <= 32'h0;
      end else begin
        RegStack_11 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_12 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'hc == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_12 <= 32'h0;
      end else begin
        RegStack_12 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_13 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'hd == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_13 <= 32'h0;
      end else begin
        RegStack_13 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_14 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'he == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_14 <= 32'h0;
      end else begin
        RegStack_14 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_15 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'hf == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_15 <= 32'h0;
      end else begin
        RegStack_15 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_16 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h10 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_16 <= 32'h0;
      end else begin
        RegStack_16 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_17 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h11 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_17 <= 32'h0;
      end else begin
        RegStack_17 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_18 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h12 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_18 <= 32'h0;
      end else begin
        RegStack_18 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_19 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h13 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_19 <= 32'h0;
      end else begin
        RegStack_19 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_20 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h14 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_20 <= 32'h0;
      end else begin
        RegStack_20 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_21 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h15 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_21 <= 32'h0;
      end else begin
        RegStack_21 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_22 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h16 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_22 <= 32'h0;
      end else begin
        RegStack_22 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_23 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h17 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_23 <= 32'h0;
      end else begin
        RegStack_23 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_24 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h18 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_24 <= 32'h0;
      end else begin
        RegStack_24 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_25 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h19 == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_25 <= 32'h0;
      end else begin
        RegStack_25 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_26 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1a == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_26 <= 32'h0;
      end else begin
        RegStack_26 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_27 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1b == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_27 <= 32'h0;
      end else begin
        RegStack_27 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_28 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1c == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_28 <= 32'h0;
      end else begin
        RegStack_28 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_29 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1d == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_29 <= 32'h0;
      end else begin
        RegStack_29 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_30 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1e == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_30 <= 32'h0;
      end else begin
        RegStack_30 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 28:25]
      RegStack_31 <= 32'h0; // @[RegFile.scala 28:25]
    end else if (5'h1f == io_Wb_Rd) begin // @[RegFile.scala 48:18]
      if (io_Wb_Rd == 5'h0) begin // @[RegFile.scala 48:23]
        RegStack_31 <= 32'h0;
      end else begin
        RegStack_31 <= io_Wb_WData;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_0 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h0 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_0 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h0 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_0 <= 1'h0;
      end else begin
        RegDirty_0 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_1 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_1 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_1 <= 1'h0;
      end else begin
        RegDirty_1 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_2 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h2 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_2 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h2 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_2 <= 1'h0;
      end else begin
        RegDirty_2 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_3 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h3 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_3 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h3 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_3 <= 1'h0;
      end else begin
        RegDirty_3 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_4 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h4 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_4 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h4 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_4 <= 1'h0;
      end else begin
        RegDirty_4 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_5 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h5 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_5 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h5 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_5 <= 1'h0;
      end else begin
        RegDirty_5 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_6 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h6 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_6 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h6 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_6 <= 1'h0;
      end else begin
        RegDirty_6 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_7 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h7 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_7 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h7 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_7 <= 1'h0;
      end else begin
        RegDirty_7 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_8 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h8 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_8 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h8 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_8 <= 1'h0;
      end else begin
        RegDirty_8 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_9 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h9 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_9 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h9 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_9 <= 1'h0;
      end else begin
        RegDirty_9 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_10 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'ha == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_10 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'ha == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_10 <= 1'h0;
      end else begin
        RegDirty_10 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_11 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'hb == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_11 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'hb == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_11 <= 1'h0;
      end else begin
        RegDirty_11 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_12 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'hc == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_12 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'hc == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_12 <= 1'h0;
      end else begin
        RegDirty_12 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_13 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'hd == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_13 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'hd == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_13 <= 1'h0;
      end else begin
        RegDirty_13 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_14 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'he == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_14 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'he == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_14 <= 1'h0;
      end else begin
        RegDirty_14 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_15 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'hf == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_15 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'hf == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_15 <= 1'h0;
      end else begin
        RegDirty_15 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_16 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h10 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_16 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h10 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_16 <= 1'h0;
      end else begin
        RegDirty_16 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_17 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h11 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_17 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h11 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_17 <= 1'h0;
      end else begin
        RegDirty_17 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_18 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h12 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_18 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h12 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_18 <= 1'h0;
      end else begin
        RegDirty_18 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_19 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h13 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_19 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h13 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_19 <= 1'h0;
      end else begin
        RegDirty_19 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_20 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h14 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_20 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h14 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_20 <= 1'h0;
      end else begin
        RegDirty_20 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_21 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h15 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_21 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h15 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_21 <= 1'h0;
      end else begin
        RegDirty_21 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_22 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h16 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_22 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h16 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_22 <= 1'h0;
      end else begin
        RegDirty_22 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_23 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h17 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_23 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h17 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_23 <= 1'h0;
      end else begin
        RegDirty_23 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_24 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h18 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_24 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h18 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_24 <= 1'h0;
      end else begin
        RegDirty_24 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_25 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h19 == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_25 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h19 == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_25 <= 1'h0;
      end else begin
        RegDirty_25 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_26 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1a == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_26 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1a == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_26 <= 1'h0;
      end else begin
        RegDirty_26 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_27 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1b == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_27 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1b == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_27 <= 1'h0;
      end else begin
        RegDirty_27 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_28 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1c == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_28 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1c == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_28 <= 1'h0;
      end else begin
        RegDirty_28 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_29 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1d == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_29 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1d == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_29 <= 1'h0;
      end else begin
        RegDirty_29 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_30 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1e == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_30 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1e == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_30 <= 1'h0;
      end else begin
        RegDirty_30 <= 1'h1;
      end
    end
    if (reset) begin // @[RegFile.scala 29:25]
      RegDirty_31 <= 1'h0; // @[RegFile.scala 29:25]
    end else if (5'h1f == io_Wb_Rd) begin // @[RegFile.scala 53:20]
      RegDirty_31 <= 1'h0; // @[RegFile.scala 53:20]
    end else if (5'h1f == io_Id_Rd) begin // @[RegFile.scala 52:20]
      if (io_Id_Rd == 5'h0) begin // @[RegFile.scala 52:26]
        RegDirty_31 <= 1'h0;
      end else begin
        RegDirty_31 <= 1'h1;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RegStack_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  RegStack_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  RegStack_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  RegStack_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  RegStack_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  RegStack_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  RegStack_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  RegStack_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  RegStack_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  RegStack_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  RegStack_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  RegStack_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  RegStack_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  RegStack_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  RegStack_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  RegStack_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  RegStack_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  RegStack_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  RegStack_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  RegStack_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  RegStack_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  RegStack_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  RegStack_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  RegStack_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  RegStack_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  RegStack_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  RegStack_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  RegStack_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  RegStack_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  RegStack_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  RegStack_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  RegStack_31 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  RegDirty_0 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  RegDirty_1 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  RegDirty_2 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  RegDirty_3 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  RegDirty_4 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  RegDirty_5 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  RegDirty_6 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  RegDirty_7 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  RegDirty_8 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  RegDirty_9 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  RegDirty_10 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  RegDirty_11 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  RegDirty_12 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  RegDirty_13 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  RegDirty_14 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  RegDirty_15 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  RegDirty_16 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  RegDirty_17 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  RegDirty_18 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  RegDirty_19 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  RegDirty_20 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  RegDirty_21 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  RegDirty_22 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  RegDirty_23 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  RegDirty_24 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  RegDirty_25 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  RegDirty_26 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  RegDirty_27 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  RegDirty_28 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  RegDirty_29 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  RegDirty_30 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  RegDirty_31 = _RAND_63[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrReg(
  input         clock,
  input         reset,
  input  [11:0] io_Id_CsrAddr,
  output [31:0] io_Id_CsrData,
  input  [11:0] io_Exe_CsrAddr,
  input  [31:0] io_Exe_CsrData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] fflags; // @[CsrReg.scala 30:21]
  reg [31:0] frm; // @[CsrReg.scala 31:21]
  reg [31:0] fcsr; // @[CsrReg.scala 32:21]
  reg [31:0] mstatus; // @[CsrReg.scala 34:23]
  reg [31:0] misa; // @[CsrReg.scala 35:23]
  reg [31:0] mie; // @[CsrReg.scala 36:23]
  reg [31:0] mtvec; // @[CsrReg.scala 37:23]
  reg [31:0] mscratch; // @[CsrReg.scala 38:23]
  reg [31:0] mepc; // @[CsrReg.scala 39:23]
  reg [31:0] mcause; // @[CsrReg.scala 40:23]
  reg [31:0] mtval; // @[CsrReg.scala 41:23]
  reg [31:0] mip; // @[CsrReg.scala 42:23]
  reg [31:0] mcycle; // @[CsrReg.scala 43:23]
  reg [31:0] mcycleh; // @[CsrReg.scala 44:23]
  reg [31:0] minstret; // @[CsrReg.scala 45:23]
  reg [31:0] minstreth; // @[CsrReg.scala 46:23]
  reg [31:0] mvendorid; // @[CsrReg.scala 48:23]
  reg [31:0] marchid; // @[CsrReg.scala 49:23]
  reg [31:0] mimpid; // @[CsrReg.scala 50:23]
  reg [31:0] mhartid; // @[CsrReg.scala 51:23]
  wire [31:0] _GEN_0 = 12'hf14 == io_Exe_CsrAddr ? io_Exe_CsrData : mhartid; // @[CsrReg.scala 53:14 112:16 51:23]
  wire [31:0] _GEN_1 = 12'hf13 == io_Exe_CsrAddr ? io_Exe_CsrData : mimpid; // @[CsrReg.scala 53:14 109:15 50:23]
  wire [31:0] _GEN_2 = 12'hf13 == io_Exe_CsrAddr ? mhartid : _GEN_0; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_3 = 12'hf12 == io_Exe_CsrAddr ? io_Exe_CsrData : marchid; // @[CsrReg.scala 53:14 106:16 49:23]
  wire [31:0] _GEN_4 = 12'hf12 == io_Exe_CsrAddr ? mimpid : _GEN_1; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_5 = 12'hf12 == io_Exe_CsrAddr ? mhartid : _GEN_2; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_6 = 12'hf11 == io_Exe_CsrAddr ? io_Exe_CsrData : mvendorid; // @[CsrReg.scala 53:14 103:17 48:23]
  wire [31:0] _GEN_7 = 12'hf11 == io_Exe_CsrAddr ? marchid : _GEN_3; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_8 = 12'hf11 == io_Exe_CsrAddr ? mimpid : _GEN_4; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_9 = 12'hf11 == io_Exe_CsrAddr ? mhartid : _GEN_5; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_10 = 12'hb82 == io_Exe_CsrAddr ? io_Exe_CsrData : minstreth; // @[CsrReg.scala 53:14 100:19 46:23]
  wire [31:0] _GEN_11 = 12'hb82 == io_Exe_CsrAddr ? mvendorid : _GEN_6; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_12 = 12'hb82 == io_Exe_CsrAddr ? marchid : _GEN_7; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_13 = 12'hb82 == io_Exe_CsrAddr ? mimpid : _GEN_8; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_14 = 12'hb82 == io_Exe_CsrAddr ? mhartid : _GEN_9; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_15 = 12'hb02 == io_Exe_CsrAddr ? io_Exe_CsrData : minstret; // @[CsrReg.scala 53:14 97:17 45:23]
  wire [31:0] _GEN_16 = 12'hb02 == io_Exe_CsrAddr ? minstreth : _GEN_10; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_17 = 12'hb02 == io_Exe_CsrAddr ? mvendorid : _GEN_11; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_18 = 12'hb02 == io_Exe_CsrAddr ? marchid : _GEN_12; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_19 = 12'hb02 == io_Exe_CsrAddr ? mimpid : _GEN_13; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_20 = 12'hb02 == io_Exe_CsrAddr ? mhartid : _GEN_14; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_21 = 12'hb80 == io_Exe_CsrAddr ? io_Exe_CsrData : mcycleh; // @[CsrReg.scala 53:14 94:17 44:23]
  wire [31:0] _GEN_22 = 12'hb80 == io_Exe_CsrAddr ? minstret : _GEN_15; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_23 = 12'hb80 == io_Exe_CsrAddr ? minstreth : _GEN_16; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_24 = 12'hb80 == io_Exe_CsrAddr ? mvendorid : _GEN_17; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_25 = 12'hb80 == io_Exe_CsrAddr ? marchid : _GEN_18; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_26 = 12'hb80 == io_Exe_CsrAddr ? mimpid : _GEN_19; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_27 = 12'hb80 == io_Exe_CsrAddr ? mhartid : _GEN_20; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_28 = 12'hb00 == io_Exe_CsrAddr ? io_Exe_CsrData : mcycle; // @[CsrReg.scala 53:14 91:15 43:23]
  wire [31:0] _GEN_29 = 12'hb00 == io_Exe_CsrAddr ? mcycleh : _GEN_21; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_30 = 12'hb00 == io_Exe_CsrAddr ? minstret : _GEN_22; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_31 = 12'hb00 == io_Exe_CsrAddr ? minstreth : _GEN_23; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_32 = 12'hb00 == io_Exe_CsrAddr ? mvendorid : _GEN_24; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_33 = 12'hb00 == io_Exe_CsrAddr ? marchid : _GEN_25; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_34 = 12'hb00 == io_Exe_CsrAddr ? mimpid : _GEN_26; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_35 = 12'hb00 == io_Exe_CsrAddr ? mhartid : _GEN_27; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_36 = 12'h344 == io_Exe_CsrAddr ? io_Exe_CsrData : mip; // @[CsrReg.scala 53:14 88:15 42:23]
  wire [31:0] _GEN_37 = 12'h344 == io_Exe_CsrAddr ? mcycle : _GEN_28; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_38 = 12'h344 == io_Exe_CsrAddr ? mcycleh : _GEN_29; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_39 = 12'h344 == io_Exe_CsrAddr ? minstret : _GEN_30; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_40 = 12'h344 == io_Exe_CsrAddr ? minstreth : _GEN_31; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_41 = 12'h344 == io_Exe_CsrAddr ? mvendorid : _GEN_32; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_42 = 12'h344 == io_Exe_CsrAddr ? marchid : _GEN_33; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_43 = 12'h344 == io_Exe_CsrAddr ? mimpid : _GEN_34; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_44 = 12'h344 == io_Exe_CsrAddr ? mhartid : _GEN_35; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_45 = 12'h343 == io_Exe_CsrAddr ? io_Exe_CsrData : mtval; // @[CsrReg.scala 53:14 85:15 41:23]
  wire [31:0] _GEN_46 = 12'h343 == io_Exe_CsrAddr ? mip : _GEN_36; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_47 = 12'h343 == io_Exe_CsrAddr ? mcycle : _GEN_37; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_48 = 12'h343 == io_Exe_CsrAddr ? mcycleh : _GEN_38; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_49 = 12'h343 == io_Exe_CsrAddr ? minstret : _GEN_39; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_50 = 12'h343 == io_Exe_CsrAddr ? minstreth : _GEN_40; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_51 = 12'h343 == io_Exe_CsrAddr ? mvendorid : _GEN_41; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_52 = 12'h343 == io_Exe_CsrAddr ? marchid : _GEN_42; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_53 = 12'h343 == io_Exe_CsrAddr ? mimpid : _GEN_43; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_54 = 12'h343 == io_Exe_CsrAddr ? mhartid : _GEN_44; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_55 = 12'h342 == io_Exe_CsrAddr ? io_Exe_CsrData : mcause; // @[CsrReg.scala 53:14 82:15 40:23]
  wire [31:0] _GEN_56 = 12'h342 == io_Exe_CsrAddr ? mtval : _GEN_45; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_57 = 12'h342 == io_Exe_CsrAddr ? mip : _GEN_46; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_58 = 12'h342 == io_Exe_CsrAddr ? mcycle : _GEN_47; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_59 = 12'h342 == io_Exe_CsrAddr ? mcycleh : _GEN_48; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_60 = 12'h342 == io_Exe_CsrAddr ? minstret : _GEN_49; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_61 = 12'h342 == io_Exe_CsrAddr ? minstreth : _GEN_50; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_62 = 12'h342 == io_Exe_CsrAddr ? mvendorid : _GEN_51; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_63 = 12'h342 == io_Exe_CsrAddr ? marchid : _GEN_52; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_64 = 12'h342 == io_Exe_CsrAddr ? mimpid : _GEN_53; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_65 = 12'h342 == io_Exe_CsrAddr ? mhartid : _GEN_54; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_66 = 12'h341 == io_Exe_CsrAddr ? io_Exe_CsrData : mepc; // @[CsrReg.scala 53:14 79:15 39:23]
  wire [31:0] _GEN_67 = 12'h341 == io_Exe_CsrAddr ? mcause : _GEN_55; // @[CsrReg.scala 53:14 40:23]
  wire [31:0] _GEN_68 = 12'h341 == io_Exe_CsrAddr ? mtval : _GEN_56; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_69 = 12'h341 == io_Exe_CsrAddr ? mip : _GEN_57; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_70 = 12'h341 == io_Exe_CsrAddr ? mcycle : _GEN_58; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_71 = 12'h341 == io_Exe_CsrAddr ? mcycleh : _GEN_59; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_72 = 12'h341 == io_Exe_CsrAddr ? minstret : _GEN_60; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_73 = 12'h341 == io_Exe_CsrAddr ? minstreth : _GEN_61; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_74 = 12'h341 == io_Exe_CsrAddr ? mvendorid : _GEN_62; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_75 = 12'h341 == io_Exe_CsrAddr ? marchid : _GEN_63; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_76 = 12'h341 == io_Exe_CsrAddr ? mimpid : _GEN_64; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_77 = 12'h341 == io_Exe_CsrAddr ? mhartid : _GEN_65; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_78 = 12'h340 == io_Exe_CsrAddr ? io_Exe_CsrData : mscratch; // @[CsrReg.scala 53:14 76:16 38:23]
  wire [31:0] _GEN_79 = 12'h340 == io_Exe_CsrAddr ? mepc : _GEN_66; // @[CsrReg.scala 53:14 39:23]
  wire [31:0] _GEN_80 = 12'h340 == io_Exe_CsrAddr ? mcause : _GEN_67; // @[CsrReg.scala 53:14 40:23]
  wire [31:0] _GEN_81 = 12'h340 == io_Exe_CsrAddr ? mtval : _GEN_68; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_82 = 12'h340 == io_Exe_CsrAddr ? mip : _GEN_69; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_83 = 12'h340 == io_Exe_CsrAddr ? mcycle : _GEN_70; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_84 = 12'h340 == io_Exe_CsrAddr ? mcycleh : _GEN_71; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_85 = 12'h340 == io_Exe_CsrAddr ? minstret : _GEN_72; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_86 = 12'h340 == io_Exe_CsrAddr ? minstreth : _GEN_73; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_87 = 12'h340 == io_Exe_CsrAddr ? mvendorid : _GEN_74; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_88 = 12'h340 == io_Exe_CsrAddr ? marchid : _GEN_75; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_89 = 12'h340 == io_Exe_CsrAddr ? mimpid : _GEN_76; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_90 = 12'h340 == io_Exe_CsrAddr ? mhartid : _GEN_77; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_91 = 12'h305 == io_Exe_CsrAddr ? io_Exe_CsrData : mtvec; // @[CsrReg.scala 53:14 73:14 37:23]
  wire [31:0] _GEN_92 = 12'h305 == io_Exe_CsrAddr ? mscratch : _GEN_78; // @[CsrReg.scala 53:14 38:23]
  wire [31:0] _GEN_93 = 12'h305 == io_Exe_CsrAddr ? mepc : _GEN_79; // @[CsrReg.scala 53:14 39:23]
  wire [31:0] _GEN_94 = 12'h305 == io_Exe_CsrAddr ? mcause : _GEN_80; // @[CsrReg.scala 53:14 40:23]
  wire [31:0] _GEN_95 = 12'h305 == io_Exe_CsrAddr ? mtval : _GEN_81; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_96 = 12'h305 == io_Exe_CsrAddr ? mip : _GEN_82; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_97 = 12'h305 == io_Exe_CsrAddr ? mcycle : _GEN_83; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_98 = 12'h305 == io_Exe_CsrAddr ? mcycleh : _GEN_84; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_99 = 12'h305 == io_Exe_CsrAddr ? minstret : _GEN_85; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_100 = 12'h305 == io_Exe_CsrAddr ? minstreth : _GEN_86; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_101 = 12'h305 == io_Exe_CsrAddr ? mvendorid : _GEN_87; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_102 = 12'h305 == io_Exe_CsrAddr ? marchid : _GEN_88; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_103 = 12'h305 == io_Exe_CsrAddr ? mimpid : _GEN_89; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_104 = 12'h305 == io_Exe_CsrAddr ? mhartid : _GEN_90; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_105 = 12'h304 == io_Exe_CsrAddr ? io_Exe_CsrData : mie; // @[CsrReg.scala 53:14 70:14 36:23]
  wire [31:0] _GEN_106 = 12'h304 == io_Exe_CsrAddr ? mtvec : _GEN_91; // @[CsrReg.scala 53:14 37:23]
  wire [31:0] _GEN_107 = 12'h304 == io_Exe_CsrAddr ? mscratch : _GEN_92; // @[CsrReg.scala 53:14 38:23]
  wire [31:0] _GEN_108 = 12'h304 == io_Exe_CsrAddr ? mepc : _GEN_93; // @[CsrReg.scala 53:14 39:23]
  wire [31:0] _GEN_109 = 12'h304 == io_Exe_CsrAddr ? mcause : _GEN_94; // @[CsrReg.scala 53:14 40:23]
  wire [31:0] _GEN_110 = 12'h304 == io_Exe_CsrAddr ? mtval : _GEN_95; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_111 = 12'h304 == io_Exe_CsrAddr ? mip : _GEN_96; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_112 = 12'h304 == io_Exe_CsrAddr ? mcycle : _GEN_97; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_113 = 12'h304 == io_Exe_CsrAddr ? mcycleh : _GEN_98; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_114 = 12'h304 == io_Exe_CsrAddr ? minstret : _GEN_99; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_115 = 12'h304 == io_Exe_CsrAddr ? minstreth : _GEN_100; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_116 = 12'h304 == io_Exe_CsrAddr ? mvendorid : _GEN_101; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_117 = 12'h304 == io_Exe_CsrAddr ? marchid : _GEN_102; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_118 = 12'h304 == io_Exe_CsrAddr ? mimpid : _GEN_103; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_119 = 12'h304 == io_Exe_CsrAddr ? mhartid : _GEN_104; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_120 = 12'h301 == io_Exe_CsrAddr ? io_Exe_CsrData : misa; // @[CsrReg.scala 53:14 67:14 35:23]
  wire [31:0] _GEN_121 = 12'h301 == io_Exe_CsrAddr ? mie : _GEN_105; // @[CsrReg.scala 53:14 36:23]
  wire [31:0] _GEN_122 = 12'h301 == io_Exe_CsrAddr ? mtvec : _GEN_106; // @[CsrReg.scala 53:14 37:23]
  wire [31:0] _GEN_123 = 12'h301 == io_Exe_CsrAddr ? mscratch : _GEN_107; // @[CsrReg.scala 53:14 38:23]
  wire [31:0] _GEN_124 = 12'h301 == io_Exe_CsrAddr ? mepc : _GEN_108; // @[CsrReg.scala 53:14 39:23]
  wire [31:0] _GEN_125 = 12'h301 == io_Exe_CsrAddr ? mcause : _GEN_109; // @[CsrReg.scala 53:14 40:23]
  wire [31:0] _GEN_126 = 12'h301 == io_Exe_CsrAddr ? mtval : _GEN_110; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_127 = 12'h301 == io_Exe_CsrAddr ? mip : _GEN_111; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_128 = 12'h301 == io_Exe_CsrAddr ? mcycle : _GEN_112; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_129 = 12'h301 == io_Exe_CsrAddr ? mcycleh : _GEN_113; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_130 = 12'h301 == io_Exe_CsrAddr ? minstret : _GEN_114; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_131 = 12'h301 == io_Exe_CsrAddr ? minstreth : _GEN_115; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_132 = 12'h301 == io_Exe_CsrAddr ? mvendorid : _GEN_116; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_133 = 12'h301 == io_Exe_CsrAddr ? marchid : _GEN_117; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_134 = 12'h301 == io_Exe_CsrAddr ? mimpid : _GEN_118; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_135 = 12'h301 == io_Exe_CsrAddr ? mhartid : _GEN_119; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_136 = 12'h300 == io_Exe_CsrAddr ? io_Exe_CsrData : mstatus; // @[CsrReg.scala 53:14 64:14 34:23]
  wire [31:0] _GEN_137 = 12'h300 == io_Exe_CsrAddr ? misa : _GEN_120; // @[CsrReg.scala 53:14 35:23]
  wire [31:0] _GEN_138 = 12'h300 == io_Exe_CsrAddr ? mie : _GEN_121; // @[CsrReg.scala 53:14 36:23]
  wire [31:0] _GEN_139 = 12'h300 == io_Exe_CsrAddr ? mtvec : _GEN_122; // @[CsrReg.scala 53:14 37:23]
  wire [31:0] _GEN_140 = 12'h300 == io_Exe_CsrAddr ? mscratch : _GEN_123; // @[CsrReg.scala 53:14 38:23]
  wire [31:0] _GEN_141 = 12'h300 == io_Exe_CsrAddr ? mepc : _GEN_124; // @[CsrReg.scala 53:14 39:23]
  wire [31:0] _GEN_142 = 12'h300 == io_Exe_CsrAddr ? mcause : _GEN_125; // @[CsrReg.scala 53:14 40:23]
  wire [31:0] _GEN_143 = 12'h300 == io_Exe_CsrAddr ? mtval : _GEN_126; // @[CsrReg.scala 53:14 41:23]
  wire [31:0] _GEN_144 = 12'h300 == io_Exe_CsrAddr ? mip : _GEN_127; // @[CsrReg.scala 53:14 42:23]
  wire [31:0] _GEN_145 = 12'h300 == io_Exe_CsrAddr ? mcycle : _GEN_128; // @[CsrReg.scala 53:14 43:23]
  wire [31:0] _GEN_146 = 12'h300 == io_Exe_CsrAddr ? mcycleh : _GEN_129; // @[CsrReg.scala 53:14 44:23]
  wire [31:0] _GEN_147 = 12'h300 == io_Exe_CsrAddr ? minstret : _GEN_130; // @[CsrReg.scala 53:14 45:23]
  wire [31:0] _GEN_148 = 12'h300 == io_Exe_CsrAddr ? minstreth : _GEN_131; // @[CsrReg.scala 53:14 46:23]
  wire [31:0] _GEN_149 = 12'h300 == io_Exe_CsrAddr ? mvendorid : _GEN_132; // @[CsrReg.scala 53:14 48:23]
  wire [31:0] _GEN_150 = 12'h300 == io_Exe_CsrAddr ? marchid : _GEN_133; // @[CsrReg.scala 53:14 49:23]
  wire [31:0] _GEN_151 = 12'h300 == io_Exe_CsrAddr ? mimpid : _GEN_134; // @[CsrReg.scala 53:14 50:23]
  wire [31:0] _GEN_152 = 12'h300 == io_Exe_CsrAddr ? mhartid : _GEN_135; // @[CsrReg.scala 53:14 51:23]
  wire [31:0] _GEN_210 = 12'hf14 == io_Id_CsrAddr ? mhartid : 32'h0; // @[CsrReg.scala 119:18 178:13 27:7]
  wire [31:0] _GEN_211 = 12'hf13 == io_Id_CsrAddr ? mimpid : _GEN_210; // @[CsrReg.scala 119:18 175:13]
  wire [31:0] _GEN_212 = 12'hf12 == io_Id_CsrAddr ? marchid : _GEN_211; // @[CsrReg.scala 119:18 172:13]
  wire [31:0] _GEN_213 = 12'hf11 == io_Id_CsrAddr ? mvendorid : _GEN_212; // @[CsrReg.scala 119:18 169:13]
  wire [31:0] _GEN_214 = 12'hb82 == io_Id_CsrAddr ? minstreth : _GEN_213; // @[CsrReg.scala 119:18 166:13]
  wire [31:0] _GEN_215 = 12'hb02 == io_Id_CsrAddr ? minstret : _GEN_214; // @[CsrReg.scala 119:18 163:13]
  wire [31:0] _GEN_216 = 12'hb80 == io_Id_CsrAddr ? mcycleh : _GEN_215; // @[CsrReg.scala 119:18 160:14]
  wire [31:0] _GEN_217 = 12'hb00 == io_Id_CsrAddr ? mcycle : _GEN_216; // @[CsrReg.scala 119:18 157:13]
  wire [31:0] _GEN_218 = 12'h344 == io_Id_CsrAddr ? mip : _GEN_217; // @[CsrReg.scala 119:18 154:13]
  wire [31:0] _GEN_219 = 12'h343 == io_Id_CsrAddr ? mtval : _GEN_218; // @[CsrReg.scala 119:18 151:13]
  wire [31:0] _GEN_220 = 12'h342 == io_Id_CsrAddr ? mcause : _GEN_219; // @[CsrReg.scala 119:18 148:13]
  wire [31:0] _GEN_221 = 12'h341 == io_Id_CsrAddr ? mepc : _GEN_220; // @[CsrReg.scala 119:18 145:13]
  wire [31:0] _GEN_222 = 12'h340 == io_Id_CsrAddr ? mscratch : _GEN_221; // @[CsrReg.scala 119:18 142:13]
  wire [31:0] _GEN_223 = 12'h305 == io_Id_CsrAddr ? mtvec : _GEN_222; // @[CsrReg.scala 119:18 139:13]
  wire [31:0] _GEN_224 = 12'h304 == io_Id_CsrAddr ? mie : _GEN_223; // @[CsrReg.scala 119:18 136:13]
  wire [31:0] _GEN_225 = 12'h301 == io_Id_CsrAddr ? misa : _GEN_224; // @[CsrReg.scala 119:18 133:13]
  wire [31:0] _GEN_226 = 12'h300 == io_Id_CsrAddr ? mstatus : _GEN_225; // @[CsrReg.scala 119:18 130:13]
  wire [31:0] _GEN_227 = 12'h3 == io_Id_CsrAddr ? fcsr : _GEN_226; // @[CsrReg.scala 119:18 127:13]
  wire [31:0] _GEN_228 = 12'h2 == io_Id_CsrAddr ? frm : _GEN_227; // @[CsrReg.scala 119:18 124:13]
  wire [31:0] _GEN_229 = 12'h1 == io_Id_CsrAddr ? fflags : _GEN_228; // @[CsrReg.scala 119:18 121:13]
  assign io_Id_CsrData = io_Id_CsrAddr == io_Exe_CsrAddr ? io_Exe_CsrData : _GEN_229; // @[CsrReg.scala 116:23 117:11]
  always @(posedge clock) begin
    if (reset) begin // @[CsrReg.scala 30:21]
      fflags <= 32'h0; // @[CsrReg.scala 30:21]
    end else if (12'h1 == io_Exe_CsrAddr) begin // @[CsrReg.scala 53:14]
      fflags <= io_Exe_CsrData; // @[CsrReg.scala 55:14]
    end
    if (reset) begin // @[CsrReg.scala 31:21]
      frm <= 32'h0; // @[CsrReg.scala 31:21]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (12'h2 == io_Exe_CsrAddr) begin // @[CsrReg.scala 53:14]
        frm <= io_Exe_CsrData; // @[CsrReg.scala 58:14]
      end
    end
    if (reset) begin // @[CsrReg.scala 32:21]
      fcsr <= 32'h0; // @[CsrReg.scala 32:21]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (12'h3 == io_Exe_CsrAddr) begin // @[CsrReg.scala 53:14]
          fcsr <= io_Exe_CsrData; // @[CsrReg.scala 61:14]
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 34:23]
      mstatus <= 32'h0; // @[CsrReg.scala 34:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mstatus <= _GEN_136;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 35:23]
      misa <= 32'h0; // @[CsrReg.scala 35:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          misa <= _GEN_137;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 36:23]
      mie <= 32'h0; // @[CsrReg.scala 36:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mie <= _GEN_138;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 37:23]
      mtvec <= 32'h0; // @[CsrReg.scala 37:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mtvec <= _GEN_139;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 38:23]
      mscratch <= 32'h0; // @[CsrReg.scala 38:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mscratch <= _GEN_140;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 39:23]
      mepc <= 32'h0; // @[CsrReg.scala 39:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mepc <= _GEN_141;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 40:23]
      mcause <= 32'h0; // @[CsrReg.scala 40:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mcause <= _GEN_142;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 41:23]
      mtval <= 32'h0; // @[CsrReg.scala 41:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mtval <= _GEN_143;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 42:23]
      mip <= 32'h0; // @[CsrReg.scala 42:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mip <= _GEN_144;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 43:23]
      mcycle <= 32'h0; // @[CsrReg.scala 43:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mcycle <= _GEN_145;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 44:23]
      mcycleh <= 32'h0; // @[CsrReg.scala 44:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mcycleh <= _GEN_146;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 45:23]
      minstret <= 32'h0; // @[CsrReg.scala 45:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          minstret <= _GEN_147;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 46:23]
      minstreth <= 32'h0; // @[CsrReg.scala 46:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          minstreth <= _GEN_148;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 48:23]
      mvendorid <= 32'h0; // @[CsrReg.scala 48:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mvendorid <= _GEN_149;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 49:23]
      marchid <= 32'h0; // @[CsrReg.scala 49:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          marchid <= _GEN_150;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 50:23]
      mimpid <= 32'h0; // @[CsrReg.scala 50:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mimpid <= _GEN_151;
        end
      end
    end
    if (reset) begin // @[CsrReg.scala 51:23]
      mhartid <= 32'h0; // @[CsrReg.scala 51:23]
    end else if (!(12'h1 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
      if (!(12'h2 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
        if (!(12'h3 == io_Exe_CsrAddr)) begin // @[CsrReg.scala 53:14]
          mhartid <= _GEN_152;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fflags = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  frm = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  fcsr = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mstatus = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  misa = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mie = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  mtvec = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  mscratch = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  mepc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  mcause = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  mtval = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  mip = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  mcycle = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  mcycleh = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  minstret = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  minstreth = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  mvendorid = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  marchid = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  mimpid = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mhartid = _RAND_19[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CoreTop(
  input         clock,
  input         reset,
  output        io_Axi_ExeData_data_sram_en,
  output        io_Axi_ExeData_data_sram_wen,
  output [31:0] io_Axi_ExeData_data_sram_addr,
  output [31:0] io_Axi_ExeData_data_sram_wdata,
  output [1:0]  io_Axi_ExeData_data_size,
  input  [31:0] io_Axi_DataMem_data_sram_rdata,
  input         io_Axi_DataMem_data_ok,
  input         io_Axi_DataMem_data_addr_ok,
  output        io_Instr_PreIfInstr_inst_sram_en,
  output [31:0] io_Instr_PreIfInstr_inst_sram_addr,
  input  [31:0] io_Instr_InstrIf_inst_sram_rdata,
  output [31:0] io_Debug_DebugInstr,
  output [31:0] io_Debug_DebugPc,
  output        io_Debug_DebugIfValid,
  output        io_Debug_DebugIfEn,
  output [9:0]  io_Debug_Debug_alu_op,
  output [31:0] io_Debug_Debug_data1,
  output [31:0] io_Debug_Debug_data2,
  output        io_Debug_Debug_mmu_en,
  output        io_Debug_Debug_mmu_wen,
  output [4:0]  io_Debug_Debug_mmu_op,
  output [31:0] io_Debug_Debug_mmu_RData2,
  output        io_Debug_Debug_pcu_en,
  output [7:0]  io_Debug_Debug_pcu_op,
  output [31:0] io_Debug_Debug_pcu_data1,
  output [31:0] io_Debug_Debug_pcu_data2,
  output [4:0]  io_Debug_Debug_rd_r,
  output        io_Debug_Debug_csr_en,
  output [2:0]  io_Debug_Debug_csr_op,
  output [11:0] io_Debug_Debug_csr_waddr,
  output [31:0] io_Debug_Debug_csr_data,
  output [31:0] io_Debug_Debug_csr_imm,
  output        io_Debug_Debug_IdValid,
  output [31:0] io_Debug_DebugResult,
  output [4:0]  io_Debug_DebugRd_r,
  output        io_Debug_DebugDataEn,
  output        io_Debug_DebugDataWen,
  output [31:0] io_Debug_DebugDataWdata,
  output [1:0]  io_Debug_DebugDataSize,
  output        io_Debug_DebugDataMemValid,
  output [4:0]  io_Debug_DebugLoadOp,
  output        io_Debug_DebugPcJump,
  output [31:0] io_Debug_DebugNextPc,
  output [11:0] io_Debug_DebugCsrWAddr,
  output [31:0] io_Debug_DebugCsrWData,
  output        io_Debug_DebugExeValid,
  output [31:0] io_Debug_DebugWData,
  output [4:0]  io_Debug_DebugMemRd_r
);
  wire  CorePreIf_clock; // @[Core_top.scala 75:27]
  wire  CorePreIf_reset; // @[Core_top.scala 75:27]
  wire  CorePreIf_io_Instr_inst_sram_en; // @[Core_top.scala 75:27]
  wire [31:0] CorePreIf_io_Instr_inst_sram_addr; // @[Core_top.scala 75:27]
  wire  CorePreIf_io_If_IfReady; // @[Core_top.scala 75:27]
  wire [31:0] CorePreIf_io_If_Pc; // @[Core_top.scala 75:27]
  wire  CorePreIf_io_Exe_PcJump; // @[Core_top.scala 75:27]
  wire [31:0] CorePreIf_io_Exe_NextPc; // @[Core_top.scala 75:27]
  wire  CoreIf_clock; // @[Core_top.scala 76:27]
  wire  CoreIf_reset; // @[Core_top.scala 76:27]
  wire [31:0] CoreIf_io_Instr_inst_sram_rdata; // @[Core_top.scala 76:27]
  wire  CoreIf_io_Id_IdReady; // @[Core_top.scala 76:27]
  wire [31:0] CoreIf_io_Id_IfInstr; // @[Core_top.scala 76:27]
  wire [31:0] CoreIf_io_Id_Pc; // @[Core_top.scala 76:27]
  wire  CoreIf_io_Id_IfValid; // @[Core_top.scala 76:27]
  wire  CoreIf_io_PreIf_IfReady; // @[Core_top.scala 76:27]
  wire [31:0] CoreIf_io_PreIf_Pc; // @[Core_top.scala 76:27]
  wire  CoreIf_io_Exe_PcJump; // @[Core_top.scala 76:27]
  wire [31:0] CoreIf_io_DebugInstr; // @[Core_top.scala 76:27]
  wire [31:0] CoreIf_io_DebugPc; // @[Core_top.scala 76:27]
  wire  CoreIf_io_DebugIfValid; // @[Core_top.scala 76:27]
  wire  CoreIf_io_DebugIfEn; // @[Core_top.scala 76:27]
  wire  CoreId_clock; // @[Core_top.scala 77:27]
  wire  CoreId_reset; // @[Core_top.scala 77:27]
  wire  CoreId_io_If_IdReady; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_If_IfInstr; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_If_Pc; // @[Core_top.scala 77:27]
  wire  CoreId_io_If_IfValid; // @[Core_top.scala 77:27]
  wire [9:0] CoreId_io_Exe_AluOp; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_Data1; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_Data2; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_MmuEn; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_MmuWen; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_Exe_MmuOp; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_MmuRData2; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_PcuEn; // @[Core_top.scala 77:27]
  wire [7:0] CoreId_io_Exe_PcuOp; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_PcuData1; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_PcuData2; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_Exe_Rd; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_ExeReady; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_PcJump; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_CsrEn; // @[Core_top.scala 77:27]
  wire [2:0] CoreId_io_Exe_CsrOp; // @[Core_top.scala 77:27]
  wire [11:0] CoreId_io_Exe_CsrWAddr; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_CsrData; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Exe_CsrImm; // @[Core_top.scala 77:27]
  wire  CoreId_io_Exe_IdValid; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_RegFile_Rs1; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_RegFile_Rs2; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_RegFile_Rd; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_RegFile_RData1; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_RegFile_RData2; // @[Core_top.scala 77:27]
  wire  CoreId_io_RegFile_RValid; // @[Core_top.scala 77:27]
  wire [11:0] CoreId_io_CsrReg_CsrAddr; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_CsrReg_CsrData; // @[Core_top.scala 77:27]
  wire [9:0] CoreId_io_Debug_alu_op; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_data1; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_data2; // @[Core_top.scala 77:27]
  wire  CoreId_io_Debug_mmu_en; // @[Core_top.scala 77:27]
  wire  CoreId_io_Debug_mmu_wen; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_Debug_mmu_op; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_mmu_RData2; // @[Core_top.scala 77:27]
  wire  CoreId_io_Debug_pcu_en; // @[Core_top.scala 77:27]
  wire [7:0] CoreId_io_Debug_pcu_op; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_pcu_data1; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_pcu_data2; // @[Core_top.scala 77:27]
  wire [4:0] CoreId_io_Debug_rd_r; // @[Core_top.scala 77:27]
  wire  CoreId_io_Debug_csr_en; // @[Core_top.scala 77:27]
  wire [2:0] CoreId_io_Debug_csr_op; // @[Core_top.scala 77:27]
  wire [11:0] CoreId_io_Debug_csr_waddr; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_csr_data; // @[Core_top.scala 77:27]
  wire [31:0] CoreId_io_Debug_csr_imm; // @[Core_top.scala 77:27]
  wire  CoreId_io_Debug_IdValid; // @[Core_top.scala 77:27]
  wire  CoreExe_clock; // @[Core_top.scala 78:27]
  wire  CoreExe_reset; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Mem_MemReady; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Mem_Result; // @[Core_top.scala 78:27]
  wire [4:0] CoreExe_io_Mem_Rd; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Mem_WrValid; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Mem_DataMemValid; // @[Core_top.scala 78:27]
  wire [4:0] CoreExe_io_Mem_LoadOp; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Mem_ExeValid; // @[Core_top.scala 78:27]
  wire [9:0] CoreExe_io_Id_AluOp; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_Data1; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_Data2; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_MmuEn; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_MmuWen; // @[Core_top.scala 78:27]
  wire [4:0] CoreExe_io_Id_MmuOp; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_MmuRData2; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_PcuEn; // @[Core_top.scala 78:27]
  wire [7:0] CoreExe_io_Id_PcuOp; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_PcuData1; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_PcuData2; // @[Core_top.scala 78:27]
  wire [4:0] CoreExe_io_Id_Rd; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_ExeReady; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_PcJump; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_CsrEn; // @[Core_top.scala 78:27]
  wire [2:0] CoreExe_io_Id_CsrOp; // @[Core_top.scala 78:27]
  wire [11:0] CoreExe_io_Id_CsrWAddr; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_CsrData; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Id_CsrImm; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Id_IdValid; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Data_data_sram_en; // @[Core_top.scala 78:27]
  wire  CoreExe_io_Data_data_sram_wen; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Data_data_sram_addr; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_Data_data_sram_wdata; // @[Core_top.scala 78:27]
  wire [1:0] CoreExe_io_Data_data_size; // @[Core_top.scala 78:27]
  wire  CoreExe_io_If_PcJump; // @[Core_top.scala 78:27]
  wire  CoreExe_io_PreIf_PcJump; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_PreIf_NextPc; // @[Core_top.scala 78:27]
  wire [11:0] CoreExe_io_CsrReg_CsrAddr; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_CsrReg_CsrData; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_DebugResult; // @[Core_top.scala 78:27]
  wire [4:0] CoreExe_io_DebugRd_r; // @[Core_top.scala 78:27]
  wire  CoreExe_io_DebugDataEn; // @[Core_top.scala 78:27]
  wire  CoreExe_io_DebugDataWen; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_DebugDataWdata; // @[Core_top.scala 78:27]
  wire [1:0] CoreExe_io_DebugDataSize; // @[Core_top.scala 78:27]
  wire  CoreExe_io_DebugDataMemValid; // @[Core_top.scala 78:27]
  wire [4:0] CoreExe_io_DebugLoadOp; // @[Core_top.scala 78:27]
  wire  CoreExe_io_DebugPcJump; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_DebugNextPc; // @[Core_top.scala 78:27]
  wire [11:0] CoreExe_io_DebugCsrWAddr; // @[Core_top.scala 78:27]
  wire [31:0] CoreExe_io_DebugCsrWData; // @[Core_top.scala 78:27]
  wire  CoreExe_io_DebugExeValid; // @[Core_top.scala 78:27]
  wire  CoreMem_clock; // @[Core_top.scala 79:27]
  wire  CoreMem_reset; // @[Core_top.scala 79:27]
  wire  CoreMem_io_Exe_MemReady; // @[Core_top.scala 79:27]
  wire [31:0] CoreMem_io_Exe_Result; // @[Core_top.scala 79:27]
  wire [4:0] CoreMem_io_Exe_Rd; // @[Core_top.scala 79:27]
  wire  CoreMem_io_Exe_WrValid; // @[Core_top.scala 79:27]
  wire  CoreMem_io_Exe_DataMemValid; // @[Core_top.scala 79:27]
  wire [4:0] CoreMem_io_Exe_LoadOp; // @[Core_top.scala 79:27]
  wire  CoreMem_io_Exe_ExeValid; // @[Core_top.scala 79:27]
  wire [31:0] CoreMem_io_Wb_WData; // @[Core_top.scala 79:27]
  wire [4:0] CoreMem_io_Wb_Rd; // @[Core_top.scala 79:27]
  wire [31:0] CoreMem_io_Data_data_sram_rdata; // @[Core_top.scala 79:27]
  wire  CoreMem_io_Data_data_ok; // @[Core_top.scala 79:27]
  wire  CoreMem_io_Data_data_addr_ok; // @[Core_top.scala 79:27]
  wire [31:0] CoreMem_io_DebugWData; // @[Core_top.scala 79:27]
  wire [4:0] CoreMem_io_DebugRd_r; // @[Core_top.scala 79:27]
  wire [31:0] CoreWb_io_Mem_WData; // @[Core_top.scala 80:27]
  wire [4:0] CoreWb_io_Mem_Rd; // @[Core_top.scala 80:27]
  wire [4:0] CoreWb_io_RegFile_Rd; // @[Core_top.scala 80:27]
  wire [31:0] CoreWb_io_RegFile_WData; // @[Core_top.scala 80:27]
  wire  RegFile_clock; // @[Core_top.scala 81:27]
  wire  RegFile_reset; // @[Core_top.scala 81:27]
  wire [4:0] RegFile_io_Id_Rs1; // @[Core_top.scala 81:27]
  wire [4:0] RegFile_io_Id_Rs2; // @[Core_top.scala 81:27]
  wire [4:0] RegFile_io_Id_Rd; // @[Core_top.scala 81:27]
  wire [31:0] RegFile_io_Id_RData1; // @[Core_top.scala 81:27]
  wire [31:0] RegFile_io_Id_RData2; // @[Core_top.scala 81:27]
  wire  RegFile_io_Id_RValid; // @[Core_top.scala 81:27]
  wire [4:0] RegFile_io_Wb_Rd; // @[Core_top.scala 81:27]
  wire [31:0] RegFile_io_Wb_WData; // @[Core_top.scala 81:27]
  wire  CsrReg_clock; // @[Core_top.scala 82:27]
  wire  CsrReg_reset; // @[Core_top.scala 82:27]
  wire [11:0] CsrReg_io_Id_CsrAddr; // @[Core_top.scala 82:27]
  wire [31:0] CsrReg_io_Id_CsrData; // @[Core_top.scala 82:27]
  wire [11:0] CsrReg_io_Exe_CsrAddr; // @[Core_top.scala 82:27]
  wire [31:0] CsrReg_io_Exe_CsrData; // @[Core_top.scala 82:27]
  CorePreIf CorePreIf ( // @[Core_top.scala 75:27]
    .clock(CorePreIf_clock),
    .reset(CorePreIf_reset),
    .io_Instr_inst_sram_en(CorePreIf_io_Instr_inst_sram_en),
    .io_Instr_inst_sram_addr(CorePreIf_io_Instr_inst_sram_addr),
    .io_If_IfReady(CorePreIf_io_If_IfReady),
    .io_If_Pc(CorePreIf_io_If_Pc),
    .io_Exe_PcJump(CorePreIf_io_Exe_PcJump),
    .io_Exe_NextPc(CorePreIf_io_Exe_NextPc)
  );
  CoreIf CoreIf ( // @[Core_top.scala 76:27]
    .clock(CoreIf_clock),
    .reset(CoreIf_reset),
    .io_Instr_inst_sram_rdata(CoreIf_io_Instr_inst_sram_rdata),
    .io_Id_IdReady(CoreIf_io_Id_IdReady),
    .io_Id_IfInstr(CoreIf_io_Id_IfInstr),
    .io_Id_Pc(CoreIf_io_Id_Pc),
    .io_Id_IfValid(CoreIf_io_Id_IfValid),
    .io_PreIf_IfReady(CoreIf_io_PreIf_IfReady),
    .io_PreIf_Pc(CoreIf_io_PreIf_Pc),
    .io_Exe_PcJump(CoreIf_io_Exe_PcJump),
    .io_DebugInstr(CoreIf_io_DebugInstr),
    .io_DebugPc(CoreIf_io_DebugPc),
    .io_DebugIfValid(CoreIf_io_DebugIfValid),
    .io_DebugIfEn(CoreIf_io_DebugIfEn)
  );
  CoreId CoreId ( // @[Core_top.scala 77:27]
    .clock(CoreId_clock),
    .reset(CoreId_reset),
    .io_If_IdReady(CoreId_io_If_IdReady),
    .io_If_IfInstr(CoreId_io_If_IfInstr),
    .io_If_Pc(CoreId_io_If_Pc),
    .io_If_IfValid(CoreId_io_If_IfValid),
    .io_Exe_AluOp(CoreId_io_Exe_AluOp),
    .io_Exe_Data1(CoreId_io_Exe_Data1),
    .io_Exe_Data2(CoreId_io_Exe_Data2),
    .io_Exe_MmuEn(CoreId_io_Exe_MmuEn),
    .io_Exe_MmuWen(CoreId_io_Exe_MmuWen),
    .io_Exe_MmuOp(CoreId_io_Exe_MmuOp),
    .io_Exe_MmuRData2(CoreId_io_Exe_MmuRData2),
    .io_Exe_PcuEn(CoreId_io_Exe_PcuEn),
    .io_Exe_PcuOp(CoreId_io_Exe_PcuOp),
    .io_Exe_PcuData1(CoreId_io_Exe_PcuData1),
    .io_Exe_PcuData2(CoreId_io_Exe_PcuData2),
    .io_Exe_Rd(CoreId_io_Exe_Rd),
    .io_Exe_ExeReady(CoreId_io_Exe_ExeReady),
    .io_Exe_PcJump(CoreId_io_Exe_PcJump),
    .io_Exe_CsrEn(CoreId_io_Exe_CsrEn),
    .io_Exe_CsrOp(CoreId_io_Exe_CsrOp),
    .io_Exe_CsrWAddr(CoreId_io_Exe_CsrWAddr),
    .io_Exe_CsrData(CoreId_io_Exe_CsrData),
    .io_Exe_CsrImm(CoreId_io_Exe_CsrImm),
    .io_Exe_IdValid(CoreId_io_Exe_IdValid),
    .io_RegFile_Rs1(CoreId_io_RegFile_Rs1),
    .io_RegFile_Rs2(CoreId_io_RegFile_Rs2),
    .io_RegFile_Rd(CoreId_io_RegFile_Rd),
    .io_RegFile_RData1(CoreId_io_RegFile_RData1),
    .io_RegFile_RData2(CoreId_io_RegFile_RData2),
    .io_RegFile_RValid(CoreId_io_RegFile_RValid),
    .io_CsrReg_CsrAddr(CoreId_io_CsrReg_CsrAddr),
    .io_CsrReg_CsrData(CoreId_io_CsrReg_CsrData),
    .io_Debug_alu_op(CoreId_io_Debug_alu_op),
    .io_Debug_data1(CoreId_io_Debug_data1),
    .io_Debug_data2(CoreId_io_Debug_data2),
    .io_Debug_mmu_en(CoreId_io_Debug_mmu_en),
    .io_Debug_mmu_wen(CoreId_io_Debug_mmu_wen),
    .io_Debug_mmu_op(CoreId_io_Debug_mmu_op),
    .io_Debug_mmu_RData2(CoreId_io_Debug_mmu_RData2),
    .io_Debug_pcu_en(CoreId_io_Debug_pcu_en),
    .io_Debug_pcu_op(CoreId_io_Debug_pcu_op),
    .io_Debug_pcu_data1(CoreId_io_Debug_pcu_data1),
    .io_Debug_pcu_data2(CoreId_io_Debug_pcu_data2),
    .io_Debug_rd_r(CoreId_io_Debug_rd_r),
    .io_Debug_csr_en(CoreId_io_Debug_csr_en),
    .io_Debug_csr_op(CoreId_io_Debug_csr_op),
    .io_Debug_csr_waddr(CoreId_io_Debug_csr_waddr),
    .io_Debug_csr_data(CoreId_io_Debug_csr_data),
    .io_Debug_csr_imm(CoreId_io_Debug_csr_imm),
    .io_Debug_IdValid(CoreId_io_Debug_IdValid)
  );
  CoreExe CoreExe ( // @[Core_top.scala 78:27]
    .clock(CoreExe_clock),
    .reset(CoreExe_reset),
    .io_Mem_MemReady(CoreExe_io_Mem_MemReady),
    .io_Mem_Result(CoreExe_io_Mem_Result),
    .io_Mem_Rd(CoreExe_io_Mem_Rd),
    .io_Mem_WrValid(CoreExe_io_Mem_WrValid),
    .io_Mem_DataMemValid(CoreExe_io_Mem_DataMemValid),
    .io_Mem_LoadOp(CoreExe_io_Mem_LoadOp),
    .io_Mem_ExeValid(CoreExe_io_Mem_ExeValid),
    .io_Id_AluOp(CoreExe_io_Id_AluOp),
    .io_Id_Data1(CoreExe_io_Id_Data1),
    .io_Id_Data2(CoreExe_io_Id_Data2),
    .io_Id_MmuEn(CoreExe_io_Id_MmuEn),
    .io_Id_MmuWen(CoreExe_io_Id_MmuWen),
    .io_Id_MmuOp(CoreExe_io_Id_MmuOp),
    .io_Id_MmuRData2(CoreExe_io_Id_MmuRData2),
    .io_Id_PcuEn(CoreExe_io_Id_PcuEn),
    .io_Id_PcuOp(CoreExe_io_Id_PcuOp),
    .io_Id_PcuData1(CoreExe_io_Id_PcuData1),
    .io_Id_PcuData2(CoreExe_io_Id_PcuData2),
    .io_Id_Rd(CoreExe_io_Id_Rd),
    .io_Id_ExeReady(CoreExe_io_Id_ExeReady),
    .io_Id_PcJump(CoreExe_io_Id_PcJump),
    .io_Id_CsrEn(CoreExe_io_Id_CsrEn),
    .io_Id_CsrOp(CoreExe_io_Id_CsrOp),
    .io_Id_CsrWAddr(CoreExe_io_Id_CsrWAddr),
    .io_Id_CsrData(CoreExe_io_Id_CsrData),
    .io_Id_CsrImm(CoreExe_io_Id_CsrImm),
    .io_Id_IdValid(CoreExe_io_Id_IdValid),
    .io_Data_data_sram_en(CoreExe_io_Data_data_sram_en),
    .io_Data_data_sram_wen(CoreExe_io_Data_data_sram_wen),
    .io_Data_data_sram_addr(CoreExe_io_Data_data_sram_addr),
    .io_Data_data_sram_wdata(CoreExe_io_Data_data_sram_wdata),
    .io_Data_data_size(CoreExe_io_Data_data_size),
    .io_If_PcJump(CoreExe_io_If_PcJump),
    .io_PreIf_PcJump(CoreExe_io_PreIf_PcJump),
    .io_PreIf_NextPc(CoreExe_io_PreIf_NextPc),
    .io_CsrReg_CsrAddr(CoreExe_io_CsrReg_CsrAddr),
    .io_CsrReg_CsrData(CoreExe_io_CsrReg_CsrData),
    .io_DebugResult(CoreExe_io_DebugResult),
    .io_DebugRd_r(CoreExe_io_DebugRd_r),
    .io_DebugDataEn(CoreExe_io_DebugDataEn),
    .io_DebugDataWen(CoreExe_io_DebugDataWen),
    .io_DebugDataWdata(CoreExe_io_DebugDataWdata),
    .io_DebugDataSize(CoreExe_io_DebugDataSize),
    .io_DebugDataMemValid(CoreExe_io_DebugDataMemValid),
    .io_DebugLoadOp(CoreExe_io_DebugLoadOp),
    .io_DebugPcJump(CoreExe_io_DebugPcJump),
    .io_DebugNextPc(CoreExe_io_DebugNextPc),
    .io_DebugCsrWAddr(CoreExe_io_DebugCsrWAddr),
    .io_DebugCsrWData(CoreExe_io_DebugCsrWData),
    .io_DebugExeValid(CoreExe_io_DebugExeValid)
  );
  CoreMem CoreMem ( // @[Core_top.scala 79:27]
    .clock(CoreMem_clock),
    .reset(CoreMem_reset),
    .io_Exe_MemReady(CoreMem_io_Exe_MemReady),
    .io_Exe_Result(CoreMem_io_Exe_Result),
    .io_Exe_Rd(CoreMem_io_Exe_Rd),
    .io_Exe_WrValid(CoreMem_io_Exe_WrValid),
    .io_Exe_DataMemValid(CoreMem_io_Exe_DataMemValid),
    .io_Exe_LoadOp(CoreMem_io_Exe_LoadOp),
    .io_Exe_ExeValid(CoreMem_io_Exe_ExeValid),
    .io_Wb_WData(CoreMem_io_Wb_WData),
    .io_Wb_Rd(CoreMem_io_Wb_Rd),
    .io_Data_data_sram_rdata(CoreMem_io_Data_data_sram_rdata),
    .io_Data_data_ok(CoreMem_io_Data_data_ok),
    .io_Data_data_addr_ok(CoreMem_io_Data_data_addr_ok),
    .io_DebugWData(CoreMem_io_DebugWData),
    .io_DebugRd_r(CoreMem_io_DebugRd_r)
  );
  CoreWb CoreWb ( // @[Core_top.scala 80:27]
    .io_Mem_WData(CoreWb_io_Mem_WData),
    .io_Mem_Rd(CoreWb_io_Mem_Rd),
    .io_RegFile_Rd(CoreWb_io_RegFile_Rd),
    .io_RegFile_WData(CoreWb_io_RegFile_WData)
  );
  RegFile RegFile ( // @[Core_top.scala 81:27]
    .clock(RegFile_clock),
    .reset(RegFile_reset),
    .io_Id_Rs1(RegFile_io_Id_Rs1),
    .io_Id_Rs2(RegFile_io_Id_Rs2),
    .io_Id_Rd(RegFile_io_Id_Rd),
    .io_Id_RData1(RegFile_io_Id_RData1),
    .io_Id_RData2(RegFile_io_Id_RData2),
    .io_Id_RValid(RegFile_io_Id_RValid),
    .io_Wb_Rd(RegFile_io_Wb_Rd),
    .io_Wb_WData(RegFile_io_Wb_WData)
  );
  CsrReg CsrReg ( // @[Core_top.scala 82:27]
    .clock(CsrReg_clock),
    .reset(CsrReg_reset),
    .io_Id_CsrAddr(CsrReg_io_Id_CsrAddr),
    .io_Id_CsrData(CsrReg_io_Id_CsrData),
    .io_Exe_CsrAddr(CsrReg_io_Exe_CsrAddr),
    .io_Exe_CsrData(CsrReg_io_Exe_CsrData)
  );
  assign io_Axi_ExeData_data_sram_en = CoreExe_io_Data_data_sram_en; // @[Core_top.scala 90:35]
  assign io_Axi_ExeData_data_sram_wen = CoreExe_io_Data_data_sram_wen; // @[Core_top.scala 91:35]
  assign io_Axi_ExeData_data_sram_addr = CoreExe_io_Data_data_sram_addr; // @[Core_top.scala 92:35]
  assign io_Axi_ExeData_data_sram_wdata = CoreExe_io_Data_data_sram_wdata; // @[Core_top.scala 93:35]
  assign io_Axi_ExeData_data_size = CoreExe_io_Data_data_size; // @[Core_top.scala 94:35]
  assign io_Instr_PreIfInstr_inst_sram_en = CorePreIf_io_Instr_inst_sram_en; // @[Core_top.scala 84:43]
  assign io_Instr_PreIfInstr_inst_sram_addr = CorePreIf_io_Instr_inst_sram_addr; // @[Core_top.scala 86:43]
  assign io_Debug_DebugInstr = CoreIf_io_DebugInstr; // @[Core_top.scala 116:26]
  assign io_Debug_DebugPc = CoreIf_io_DebugPc; // @[Core_top.scala 117:26]
  assign io_Debug_DebugIfValid = CoreIf_io_DebugIfValid; // @[Core_top.scala 118:26]
  assign io_Debug_DebugIfEn = CoreIf_io_DebugIfEn; // @[Core_top.scala 119:26]
  assign io_Debug_Debug_alu_op = CoreId_io_Debug_alu_op; // @[Core_top.scala 121:26]
  assign io_Debug_Debug_data1 = CoreId_io_Debug_data1; // @[Core_top.scala 122:26]
  assign io_Debug_Debug_data2 = CoreId_io_Debug_data2; // @[Core_top.scala 123:26]
  assign io_Debug_Debug_mmu_en = CoreId_io_Debug_mmu_en; // @[Core_top.scala 124:26]
  assign io_Debug_Debug_mmu_wen = CoreId_io_Debug_mmu_wen; // @[Core_top.scala 125:26]
  assign io_Debug_Debug_mmu_op = CoreId_io_Debug_mmu_op; // @[Core_top.scala 126:26]
  assign io_Debug_Debug_mmu_RData2 = CoreId_io_Debug_mmu_RData2; // @[Core_top.scala 127:26]
  assign io_Debug_Debug_pcu_en = CoreId_io_Debug_pcu_en; // @[Core_top.scala 128:26]
  assign io_Debug_Debug_pcu_op = CoreId_io_Debug_pcu_op; // @[Core_top.scala 129:26]
  assign io_Debug_Debug_pcu_data1 = CoreId_io_Debug_pcu_data1; // @[Core_top.scala 130:26]
  assign io_Debug_Debug_pcu_data2 = CoreId_io_Debug_pcu_data2; // @[Core_top.scala 131:26]
  assign io_Debug_Debug_rd_r = CoreId_io_Debug_rd_r; // @[Core_top.scala 132:26]
  assign io_Debug_Debug_csr_en = CoreId_io_Debug_csr_en; // @[Core_top.scala 133:26]
  assign io_Debug_Debug_csr_op = CoreId_io_Debug_csr_op; // @[Core_top.scala 134:26]
  assign io_Debug_Debug_csr_waddr = CoreId_io_Debug_csr_waddr; // @[Core_top.scala 135:26]
  assign io_Debug_Debug_csr_data = CoreId_io_Debug_csr_data; // @[Core_top.scala 136:26]
  assign io_Debug_Debug_csr_imm = CoreId_io_Debug_csr_imm; // @[Core_top.scala 137:26]
  assign io_Debug_Debug_IdValid = CoreId_io_Debug_IdValid; // @[Core_top.scala 138:26]
  assign io_Debug_DebugResult = CoreExe_io_DebugResult; // @[Core_top.scala 141:28]
  assign io_Debug_DebugRd_r = CoreExe_io_DebugRd_r; // @[Core_top.scala 142:28]
  assign io_Debug_DebugDataEn = CoreExe_io_DebugDataEn; // @[Core_top.scala 143:28]
  assign io_Debug_DebugDataWen = CoreExe_io_DebugDataWen; // @[Core_top.scala 144:28]
  assign io_Debug_DebugDataWdata = CoreExe_io_DebugDataWdata; // @[Core_top.scala 145:28]
  assign io_Debug_DebugDataSize = CoreExe_io_DebugDataSize; // @[Core_top.scala 146:28]
  assign io_Debug_DebugDataMemValid = CoreExe_io_DebugDataMemValid; // @[Core_top.scala 147:28]
  assign io_Debug_DebugLoadOp = CoreExe_io_DebugLoadOp; // @[Core_top.scala 148:28]
  assign io_Debug_DebugPcJump = CoreExe_io_DebugPcJump; // @[Core_top.scala 149:28]
  assign io_Debug_DebugNextPc = CoreExe_io_DebugNextPc; // @[Core_top.scala 150:28]
  assign io_Debug_DebugCsrWAddr = CoreExe_io_DebugCsrWAddr; // @[Core_top.scala 151:28]
  assign io_Debug_DebugCsrWData = CoreExe_io_DebugCsrWData; // @[Core_top.scala 152:28]
  assign io_Debug_DebugExeValid = CoreExe_io_DebugExeValid; // @[Core_top.scala 153:28]
  assign io_Debug_DebugWData = CoreMem_io_DebugWData; // @[Core_top.scala 155:28]
  assign io_Debug_DebugMemRd_r = CoreMem_io_DebugRd_r; // @[Core_top.scala 156:31]
  assign CorePreIf_clock = clock;
  assign CorePreIf_reset = reset;
  assign CorePreIf_io_If_IfReady = CoreIf_io_PreIf_IfReady; // @[Core_top.scala 100:21]
  assign CorePreIf_io_Exe_PcJump = CoreExe_io_PreIf_PcJump; // @[Core_top.scala 110:22]
  assign CorePreIf_io_Exe_NextPc = CoreExe_io_PreIf_NextPc; // @[Core_top.scala 110:22]
  assign CoreIf_clock = clock;
  assign CoreIf_reset = reset;
  assign CoreIf_io_Instr_inst_sram_rdata = io_Instr_InstrIf_inst_sram_rdata; // @[Core_top.scala 88:37]
  assign CoreIf_io_Id_IdReady = CoreId_io_If_IdReady; // @[Core_top.scala 102:18]
  assign CoreIf_io_PreIf_Pc = CorePreIf_io_If_Pc; // @[Core_top.scala 100:21]
  assign CoreIf_io_Exe_PcJump = CoreExe_io_If_PcJump; // @[Core_top.scala 109:19]
  assign CoreId_clock = clock;
  assign CoreId_reset = reset;
  assign CoreId_io_If_IfInstr = CoreIf_io_Id_IfInstr; // @[Core_top.scala 102:18]
  assign CoreId_io_If_Pc = CoreIf_io_Id_Pc; // @[Core_top.scala 102:18]
  assign CoreId_io_If_IfValid = CoreIf_io_Id_IfValid; // @[Core_top.scala 102:18]
  assign CoreId_io_Exe_ExeReady = CoreExe_io_Id_ExeReady; // @[Core_top.scala 103:19]
  assign CoreId_io_Exe_PcJump = CoreExe_io_Id_PcJump; // @[Core_top.scala 103:19]
  assign CoreId_io_RegFile_RData1 = RegFile_io_Id_RData1; // @[Core_top.scala 104:23]
  assign CoreId_io_RegFile_RData2 = RegFile_io_Id_RData2; // @[Core_top.scala 104:23]
  assign CoreId_io_RegFile_RValid = RegFile_io_Id_RValid; // @[Core_top.scala 104:23]
  assign CoreId_io_CsrReg_CsrData = CsrReg_io_Id_CsrData; // @[Core_top.scala 112:19]
  assign CoreExe_clock = clock;
  assign CoreExe_reset = reset;
  assign CoreExe_io_Mem_MemReady = CoreMem_io_Exe_MemReady; // @[Core_top.scala 105:20]
  assign CoreExe_io_Id_AluOp = CoreId_io_Exe_AluOp; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_Data1 = CoreId_io_Exe_Data1; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_Data2 = CoreId_io_Exe_Data2; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_MmuEn = CoreId_io_Exe_MmuEn; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_MmuWen = CoreId_io_Exe_MmuWen; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_MmuOp = CoreId_io_Exe_MmuOp; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_MmuRData2 = CoreId_io_Exe_MmuRData2; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_PcuEn = CoreId_io_Exe_PcuEn; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_PcuOp = CoreId_io_Exe_PcuOp; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_PcuData1 = CoreId_io_Exe_PcuData1; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_PcuData2 = CoreId_io_Exe_PcuData2; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_Rd = CoreId_io_Exe_Rd; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_CsrEn = CoreId_io_Exe_CsrEn; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_CsrOp = CoreId_io_Exe_CsrOp; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_CsrWAddr = CoreId_io_Exe_CsrWAddr; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_CsrData = CoreId_io_Exe_CsrData; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_CsrImm = CoreId_io_Exe_CsrImm; // @[Core_top.scala 103:19]
  assign CoreExe_io_Id_IdValid = CoreId_io_Exe_IdValid; // @[Core_top.scala 103:19]
  assign CoreMem_clock = clock;
  assign CoreMem_reset = reset;
  assign CoreMem_io_Exe_Result = CoreExe_io_Mem_Result; // @[Core_top.scala 105:20]
  assign CoreMem_io_Exe_Rd = CoreExe_io_Mem_Rd; // @[Core_top.scala 105:20]
  assign CoreMem_io_Exe_WrValid = CoreExe_io_Mem_WrValid; // @[Core_top.scala 105:20]
  assign CoreMem_io_Exe_DataMemValid = CoreExe_io_Mem_DataMemValid; // @[Core_top.scala 105:20]
  assign CoreMem_io_Exe_LoadOp = CoreExe_io_Mem_LoadOp; // @[Core_top.scala 105:20]
  assign CoreMem_io_Exe_ExeValid = CoreExe_io_Mem_ExeValid; // @[Core_top.scala 105:20]
  assign CoreMem_io_Data_data_sram_rdata = io_Axi_DataMem_data_sram_rdata; // @[Core_top.scala 98:37]
  assign CoreMem_io_Data_data_ok = io_Axi_DataMem_data_ok; // @[Core_top.scala 97:37]
  assign CoreMem_io_Data_data_addr_ok = io_Axi_DataMem_data_addr_ok; // @[Core_top.scala 96:37]
  assign CoreWb_io_Mem_WData = CoreMem_io_Wb_WData; // @[Core_top.scala 106:20]
  assign CoreWb_io_Mem_Rd = CoreMem_io_Wb_Rd; // @[Core_top.scala 106:20]
  assign RegFile_clock = clock;
  assign RegFile_reset = reset;
  assign RegFile_io_Id_Rs1 = CoreId_io_RegFile_Rs1; // @[Core_top.scala 104:23]
  assign RegFile_io_Id_Rs2 = CoreId_io_RegFile_Rs2; // @[Core_top.scala 104:23]
  assign RegFile_io_Id_Rd = CoreId_io_RegFile_Rd; // @[Core_top.scala 104:23]
  assign RegFile_io_Wb_Rd = CoreWb_io_RegFile_Rd; // @[Core_top.scala 107:23]
  assign RegFile_io_Wb_WData = CoreWb_io_RegFile_WData; // @[Core_top.scala 107:23]
  assign CsrReg_clock = clock;
  assign CsrReg_reset = reset;
  assign CsrReg_io_Id_CsrAddr = CoreId_io_CsrReg_CsrAddr; // @[Core_top.scala 112:19]
  assign CsrReg_io_Exe_CsrAddr = CoreExe_io_CsrReg_CsrAddr; // @[Core_top.scala 113:19]
  assign CsrReg_io_Exe_CsrData = CoreExe_io_CsrReg_CsrData; // @[Core_top.scala 113:19]
endmodule
module AxiMasterAxi(
  input         clock,
  input         reset,
  input         io_Cpu_ExeData_data_sram_en,
  input         io_Cpu_ExeData_data_sram_wen,
  input  [31:0] io_Cpu_ExeData_data_sram_addr,
  input  [31:0] io_Cpu_ExeData_data_sram_wdata,
  input  [1:0]  io_Cpu_ExeData_data_size,
  output [31:0] io_Cpu_DataMem_data_sram_rdata,
  output        io_Cpu_DataMem_data_ok,
  output        io_Cpu_DataMem_data_addr_ok,
  output [31:0] io_AR_ArAddr,
  output        io_AR_ArValid,
  input  [31:0] io_R_RData,
  input         io_R_RLast,
  input         io_R_RValid,
  output [31:0] io_AW_AwAddr,
  output [2:0]  io_AW_Awize,
  output        io_AW_AwValid,
  output [31:0] io_W_WData,
  output        io_W_WLast,
  output        io_W_WValid,
  input         io_B_Bvalid,
  output        io_DeBugAddrOk,
  output        io_DeBugDataOk,
  output [31:0] io_DeBugRData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] RegState; // @[SramAxi.scala 101:26]
  reg [31:0] ArAddr; // @[SramAxi.scala 102:26]
  reg  ArValid; // @[SramAxi.scala 104:26]
  reg [31:0] AwAddr; // @[SramAxi.scala 106:26]
  reg [1:0] Awsize; // @[SramAxi.scala 107:27]
  reg  AwValid; // @[SramAxi.scala 108:26]
  reg [31:0] WData; // @[SramAxi.scala 110:26]
  reg  WLast; // @[SramAxi.scala 111:26]
  reg  WValid; // @[SramAxi.scala 112:26]
  reg  AddrOk; // @[SramAxi.scala 114:26]
  reg  DataOk; // @[SramAxi.scala 115:26]
  reg [31:0] RData; // @[SramAxi.scala 116:26]
  wire  _T_1 = io_Cpu_ExeData_data_sram_en & io_Cpu_ExeData_data_sram_wen; // @[SramAxi.scala 126:20]
  wire  _T_3 = io_Cpu_ExeData_data_sram_en & ~io_Cpu_ExeData_data_sram_wen; // @[SramAxi.scala 135:26]
  wire [2:0] _GEN_18 = io_R_RLast ? 3'h0 : RegState; // @[SramAxi.scala 185:18 186:18 101:26]
  wire [31:0] _GEN_20 = io_R_RValid ? io_R_RData : 32'h0; // @[SramAxi.scala 188:19 190:16 193:16]
  wire [2:0] _GEN_21 = 3'h4 == RegState ? _GEN_18 : RegState; // @[SramAxi.scala 119:19 101:26]
  wire  _GEN_22 = 3'h4 == RegState ? io_R_RValid : DataOk; // @[SramAxi.scala 119:19 115:26]
  wire [31:0] _GEN_23 = 3'h4 == RegState ? _GEN_20 : RData; // @[SramAxi.scala 119:19 116:26]
  wire  _GEN_24 = 3'h2 == RegState | AddrOk; // @[SramAxi.scala 119:19 176:15 114:26]
  wire  _GEN_26 = 3'h2 == RegState | WLast; // @[SramAxi.scala 119:19 178:15 111:26]
  wire  _GEN_27 = 3'h2 == RegState | WValid; // @[SramAxi.scala 119:19 179:15 112:26]
  assign io_Cpu_DataMem_data_sram_rdata = RData; // @[SramAxi.scala 232:33]
  assign io_Cpu_DataMem_data_ok = DataOk; // @[SramAxi.scala 231:33]
  assign io_Cpu_DataMem_data_addr_ok = AddrOk; // @[SramAxi.scala 230:33]
  assign io_AR_ArAddr = ArAddr; // @[SramAxi.scala 202:16]
  assign io_AR_ArValid = ArValid; // @[SramAxi.scala 209:16]
  assign io_AW_AwAddr = AwAddr; // @[SramAxi.scala 212:16]
  assign io_AW_Awize = {{1'd0}, Awsize}; // @[SramAxi.scala 214:16]
  assign io_AW_AwValid = AwValid; // @[SramAxi.scala 219:16]
  assign io_W_WData = WData; // @[SramAxi.scala 222:16]
  assign io_W_WLast = WLast; // @[SramAxi.scala 224:16]
  assign io_W_WValid = WValid; // @[SramAxi.scala 225:16]
  assign io_DeBugAddrOk = AddrOk; // @[SramAxi.scala 233:16]
  assign io_DeBugDataOk = DataOk; // @[SramAxi.scala 234:16]
  assign io_DeBugRData = RData; // @[SramAxi.scala 235:16]
  always @(posedge clock) begin
    if (reset) begin // @[SramAxi.scala 101:26]
      RegState <= 3'h0; // @[SramAxi.scala 101:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_Cpu_ExeData_data_sram_en & io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 126:34]
        RegState <= 3'h1; // @[SramAxi.scala 127:18]
      end else if (io_Cpu_ExeData_data_sram_en & ~io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 135:41]
        RegState <= 3'h4; // @[SramAxi.scala 136:18]
      end else begin
        RegState <= 3'h0; // @[SramAxi.scala 145:18]
      end
    end else if (3'h1 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_B_Bvalid) begin // @[SramAxi.scala 160:17]
        RegState <= 3'h2; // @[SramAxi.scala 161:16]
      end else begin
        RegState <= 3'h1; // @[SramAxi.scala 168:16]
      end
    end else if (3'h2 == RegState) begin // @[SramAxi.scala 119:19]
      RegState <= 3'h0; // @[SramAxi.scala 180:15]
    end else begin
      RegState <= _GEN_21;
    end
    if (reset) begin // @[SramAxi.scala 102:26]
      ArAddr <= 32'h0; // @[SramAxi.scala 102:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_Cpu_ExeData_data_sram_en & io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 126:34]
        ArAddr <= 32'h0; // @[SramAxi.scala 131:18]
      end else if (io_Cpu_ExeData_data_sram_en & ~io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 135:41]
        ArAddr <= io_Cpu_ExeData_data_sram_addr; // @[SramAxi.scala 137:18]
      end else begin
        ArAddr <= 32'h0; // @[SramAxi.scala 149:18]
      end
    end
    if (reset) begin // @[SramAxi.scala 104:26]
      ArValid <= 1'h0; // @[SramAxi.scala 104:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_Cpu_ExeData_data_sram_en & io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 126:34]
        ArValid <= 1'h0; // @[SramAxi.scala 133:18]
      end else begin
        ArValid <= _T_3;
      end
    end
    if (reset) begin // @[SramAxi.scala 106:26]
      AwAddr <= 32'h0; // @[SramAxi.scala 106:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_Cpu_ExeData_data_sram_en & io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 126:34]
        AwAddr <= io_Cpu_ExeData_data_sram_addr; // @[SramAxi.scala 128:18]
      end else begin
        AwAddr <= 32'h0;
      end
    end else if (3'h1 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_B_Bvalid) begin // @[SramAxi.scala 160:17]
        AwAddr <= 32'h0; // @[SramAxi.scala 162:16]
      end
    end
    if (reset) begin // @[SramAxi.scala 107:27]
      Awsize <= 2'h0; // @[SramAxi.scala 107:27]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_Cpu_ExeData_data_sram_en & io_Cpu_ExeData_data_sram_wen) begin // @[SramAxi.scala 126:34]
        Awsize <= io_Cpu_ExeData_data_size; // @[SramAxi.scala 129:19]
      end else begin
        Awsize <= 2'h0;
      end
    end else if (3'h1 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_B_Bvalid) begin // @[SramAxi.scala 160:17]
        Awsize <= 2'h0; // @[SramAxi.scala 163:16]
      end
    end
    if (reset) begin // @[SramAxi.scala 108:26]
      AwValid <= 1'h0; // @[SramAxi.scala 108:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      AwValid <= _T_1;
    end else if (3'h1 == RegState) begin // @[SramAxi.scala 119:19]
      if (io_B_Bvalid) begin // @[SramAxi.scala 160:17]
        AwValid <= 1'h0; // @[SramAxi.scala 164:16]
      end
    end
    if (reset) begin // @[SramAxi.scala 110:26]
      WData <= 32'h0; // @[SramAxi.scala 110:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      WData <= 32'h0; // @[SramAxi.scala 123:14]
    end else if (!(3'h1 == RegState)) begin // @[SramAxi.scala 119:19]
      if (3'h2 == RegState) begin // @[SramAxi.scala 119:19]
        WData <= io_Cpu_ExeData_data_sram_wdata; // @[SramAxi.scala 177:15]
      end
    end
    if (reset) begin // @[SramAxi.scala 111:26]
      WLast <= 1'h0; // @[SramAxi.scala 111:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      WLast <= 1'h0; // @[SramAxi.scala 124:14]
    end else if (!(3'h1 == RegState)) begin // @[SramAxi.scala 119:19]
      WLast <= _GEN_26;
    end
    if (reset) begin // @[SramAxi.scala 112:26]
      WValid <= 1'h0; // @[SramAxi.scala 112:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      WValid <= 1'h0; // @[SramAxi.scala 125:14]
    end else if (!(3'h1 == RegState)) begin // @[SramAxi.scala 119:19]
      WValid <= _GEN_27;
    end
    if (reset) begin // @[SramAxi.scala 114:26]
      AddrOk <= 1'h0; // @[SramAxi.scala 114:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      AddrOk <= 1'h0; // @[SramAxi.scala 122:14]
    end else if (!(3'h1 == RegState)) begin // @[SramAxi.scala 119:19]
      AddrOk <= _GEN_24;
    end
    if (reset) begin // @[SramAxi.scala 115:26]
      DataOk <= 1'h0; // @[SramAxi.scala 115:26]
    end else if (3'h0 == RegState) begin // @[SramAxi.scala 119:19]
      DataOk <= 1'h0; // @[SramAxi.scala 121:14]
    end else if (!(3'h1 == RegState)) begin // @[SramAxi.scala 119:19]
      if (!(3'h2 == RegState)) begin // @[SramAxi.scala 119:19]
        DataOk <= _GEN_22;
      end
    end
    if (reset) begin // @[SramAxi.scala 116:26]
      RData <= 32'h0; // @[SramAxi.scala 116:26]
    end else if (!(3'h0 == RegState)) begin // @[SramAxi.scala 119:19]
      if (!(3'h1 == RegState)) begin // @[SramAxi.scala 119:19]
        if (!(3'h2 == RegState)) begin // @[SramAxi.scala 119:19]
          RData <= _GEN_23;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RegState = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  ArAddr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ArValid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  AwAddr = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  Awsize = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  AwValid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  WData = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  WLast = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  WValid = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  AddrOk = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  DataOk = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  RData = _RAND_11[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataMemSlave(
  input         clock,
  input         reset,
  output        io_MemData_data_sram_en,
  output [3:0]  io_MemData_data_sram_wen,
  output [31:0] io_MemData_data_sram_addr,
  output [31:0] io_MemData_data_sram_wdata,
  input  [31:0] io_MemData_data_sram_rdata,
  input  [31:0] io_AR_ArAddr,
  input         io_AR_ArValid,
  output [31:0] io_R_RData,
  output        io_R_RLast,
  output        io_R_RValid,
  input  [31:0] io_AW_AwAddr,
  input  [2:0]  io_AW_Awize,
  input         io_AW_AwValid,
  input  [31:0] io_W_WData,
  input         io_W_WLast,
  input         io_W_WValid,
  output        io_B_Bvalid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] RegState; // @[AxiMem.scala 63:26]
  reg  DataEn; // @[AxiMem.scala 64:26]
  reg [3:0] DataWen; // @[AxiMem.scala 65:26]
  reg [31:0] DataAddr; // @[AxiMem.scala 66:26]
  reg [31:0] MemWData; // @[AxiMem.scala 67:26]
  reg  RValid; // @[AxiMem.scala 69:26]
  reg  RLast; // @[AxiMem.scala 70:26]
  reg  Bvalid; // @[AxiMem.scala 71:26]
  reg [31:0] AxiRData; // @[AxiMem.scala 72:26]
  wire [3:0] _DataWen_T_3 = io_AW_Awize == 3'h3 ? 4'hf : 4'h0; // @[AxiMem.scala 83:24]
  wire [3:0] _DataWen_T_4 = io_AW_Awize == 3'h1 ? 4'h3 : _DataWen_T_3; // @[AxiMem.scala 82:24]
  wire [1:0] _GEN_10 = io_W_WLast ? 2'h0 : RegState; // @[AxiMem.scala 112:16 113:16 63:26]
  wire [31:0] _GEN_14 = io_W_WValid ? io_W_WData : MemWData; // @[AxiMem.scala 116:17 121:16 67:26]
  wire  _GEN_15 = 2'h3 == RegState | RValid; // @[AxiMem.scala 132:14 75:19 69:26]
  wire [31:0] _GEN_16 = 2'h3 == RegState ? io_MemData_data_sram_rdata : AxiRData; // @[AxiMem.scala 133:14 75:19 72:26]
  wire [1:0] _GEN_17 = 2'h3 == RegState ? 2'h0 : RegState; // @[AxiMem.scala 134:14 75:19 63:26]
  wire  _GEN_18 = 2'h3 == RegState | RLast; // @[AxiMem.scala 135:14 75:19 70:26]
  wire  _GEN_19 = 2'h2 == RegState ? 1'h0 : Bvalid; // @[AxiMem.scala 111:14 75:19 71:26]
  assign io_MemData_data_sram_en = DataEn; // @[AxiMem.scala 153:29]
  assign io_MemData_data_sram_wen = DataWen; // @[AxiMem.scala 154:29]
  assign io_MemData_data_sram_addr = DataAddr; // @[AxiMem.scala 155:29]
  assign io_MemData_data_sram_wdata = MemWData; // @[AxiMem.scala 156:29]
  assign io_R_RData = AxiRData; // @[AxiMem.scala 144:15]
  assign io_R_RLast = RLast; // @[AxiMem.scala 143:15]
  assign io_R_RValid = RValid; // @[AxiMem.scala 145:15]
  assign io_B_Bvalid = Bvalid; // @[AxiMem.scala 148:15]
  always @(posedge clock) begin
    if (reset) begin // @[AxiMem.scala 63:26]
      RegState <= 2'h0; // @[AxiMem.scala 63:26]
    end else if (2'h0 == RegState) begin // @[AxiMem.scala 75:19]
      if (io_AW_AwValid) begin // @[AxiMem.scala 79:18]
        RegState <= 2'h1; // @[AxiMem.scala 80:18]
      end else if (io_AR_ArValid) begin // @[AxiMem.scala 88:24]
        RegState <= 2'h3; // @[AxiMem.scala 89:18]
      end else begin
        RegState <= 2'h0; // @[AxiMem.scala 95:18]
      end
    end else if (2'h1 == RegState) begin // @[AxiMem.scala 75:19]
      RegState <= 2'h2;
    end else if (2'h2 == RegState) begin // @[AxiMem.scala 75:19]
      RegState <= _GEN_10;
    end else begin
      RegState <= _GEN_17;
    end
    if (reset) begin // @[AxiMem.scala 64:26]
      DataEn <= 1'h0; // @[AxiMem.scala 64:26]
    end else if (2'h0 == RegState) begin // @[AxiMem.scala 75:19]
      if (io_AW_AwValid) begin // @[AxiMem.scala 79:18]
        DataEn <= 1'h0; // @[AxiMem.scala 85:18]
      end else begin
        DataEn <= io_AR_ArValid;
      end
    end else if (!(2'h1 == RegState)) begin // @[AxiMem.scala 75:19]
      if (2'h2 == RegState) begin // @[AxiMem.scala 75:19]
        DataEn <= io_W_WValid;
      end
    end
    if (reset) begin // @[AxiMem.scala 65:26]
      DataWen <= 4'h0; // @[AxiMem.scala 65:26]
    end else if (2'h0 == RegState) begin // @[AxiMem.scala 75:19]
      if (io_AW_AwValid) begin // @[AxiMem.scala 79:18]
        if (io_AW_Awize == 3'h0) begin // @[AxiMem.scala 81:24]
          DataWen <= 4'h1;
        end else begin
          DataWen <= _DataWen_T_4;
        end
      end else begin
        DataWen <= 4'h0;
      end
    end
    if (reset) begin // @[AxiMem.scala 66:26]
      DataAddr <= 32'h0; // @[AxiMem.scala 66:26]
    end else if (2'h0 == RegState) begin // @[AxiMem.scala 75:19]
      if (io_AW_AwValid) begin // @[AxiMem.scala 79:18]
        DataAddr <= io_AW_AwAddr; // @[AxiMem.scala 86:18]
      end else if (io_AR_ArValid) begin // @[AxiMem.scala 88:24]
        DataAddr <= io_AR_ArAddr; // @[AxiMem.scala 91:18]
      end else begin
        DataAddr <= 32'h0; // @[AxiMem.scala 97:18]
      end
    end
    if (reset) begin // @[AxiMem.scala 67:26]
      MemWData <= 32'h0; // @[AxiMem.scala 67:26]
    end else if (!(2'h0 == RegState)) begin // @[AxiMem.scala 75:19]
      if (!(2'h1 == RegState)) begin // @[AxiMem.scala 75:19]
        if (2'h2 == RegState) begin // @[AxiMem.scala 75:19]
          MemWData <= _GEN_14;
        end
      end
    end
    if (reset) begin // @[AxiMem.scala 69:26]
      RValid <= 1'h0; // @[AxiMem.scala 69:26]
    end else if (2'h0 == RegState) begin // @[AxiMem.scala 75:19]
      RValid <= 1'h0; // @[AxiMem.scala 78:14]
    end else if (!(2'h1 == RegState)) begin // @[AxiMem.scala 75:19]
      if (!(2'h2 == RegState)) begin // @[AxiMem.scala 75:19]
        RValid <= _GEN_15;
      end
    end
    if (reset) begin // @[AxiMem.scala 70:26]
      RLast <= 1'h0; // @[AxiMem.scala 70:26]
    end else if (2'h0 == RegState) begin // @[AxiMem.scala 75:19]
      RLast <= 1'h0; // @[AxiMem.scala 77:14]
    end else if (!(2'h1 == RegState)) begin // @[AxiMem.scala 75:19]
      if (!(2'h2 == RegState)) begin // @[AxiMem.scala 75:19]
        RLast <= _GEN_18;
      end
    end
    if (reset) begin // @[AxiMem.scala 71:26]
      Bvalid <= 1'h0; // @[AxiMem.scala 71:26]
    end else if (!(2'h0 == RegState)) begin // @[AxiMem.scala 75:19]
      Bvalid <= 2'h1 == RegState | _GEN_19;
    end
    if (reset) begin // @[AxiMem.scala 72:26]
      AxiRData <= 32'h0; // @[AxiMem.scala 72:26]
    end else if (!(2'h0 == RegState)) begin // @[AxiMem.scala 75:19]
      if (!(2'h1 == RegState)) begin // @[AxiMem.scala 75:19]
        if (!(2'h2 == RegState)) begin // @[AxiMem.scala 75:19]
          AxiRData <= _GEN_16;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RegState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  DataEn = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  DataWen = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  DataAddr = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  MemWData = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  RValid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  RLast = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  Bvalid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  AxiRData = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SocTop(
  input         clock,
  input         reset,
  output        io_Instr_PreIfInstr_inst_sram_en,
  output [3:0]  io_Instr_PreIfInstr_inst_sram_wen,
  output [31:0] io_Instr_PreIfInstr_inst_sram_addr,
  output [31:0] io_Instr_PreIfInstr_inst_sram_wdata,
  input  [31:0] io_Instr_InstrIf_inst_sram_rdata,
  output        io_MemData_data_sram_en,
  output [3:0]  io_MemData_data_sram_wen,
  output [31:0] io_MemData_data_sram_addr,
  output [31:0] io_MemData_data_sram_wdata,
  input  [31:0] io_MemData_data_sram_rdata,
  output [31:0] io_Debug_DebugInstr,
  output [31:0] io_Debug_DebugPc,
  output        io_Debug_DebugIfValid,
  output        io_Debug_DebugIfEn,
  output [9:0]  io_Debug_Debug_alu_op,
  output [31:0] io_Debug_Debug_data1,
  output [31:0] io_Debug_Debug_data2,
  output        io_Debug_Debug_mmu_en,
  output        io_Debug_Debug_mmu_wen,
  output [4:0]  io_Debug_Debug_mmu_op,
  output [31:0] io_Debug_Debug_mmu_RData2,
  output        io_Debug_Debug_pcu_en,
  output [7:0]  io_Debug_Debug_pcu_op,
  output [31:0] io_Debug_Debug_pcu_data1,
  output [31:0] io_Debug_Debug_pcu_data2,
  output [4:0]  io_Debug_Debug_rd_r,
  output        io_Debug_Debug_csr_en,
  output [2:0]  io_Debug_Debug_csr_op,
  output [11:0] io_Debug_Debug_csr_waddr,
  output [31:0] io_Debug_Debug_csr_data,
  output [31:0] io_Debug_Debug_csr_imm,
  output        io_Debug_Debug_IdValid,
  output [31:0] io_Debug_DebugResult,
  output [4:0]  io_Debug_DebugRd_r,
  output        io_Debug_DebugDataEn,
  output        io_Debug_DebugDataWen,
  output [31:0] io_Debug_DebugDataWdata,
  output [1:0]  io_Debug_DebugDataSize,
  output        io_Debug_DebugDataMemValid,
  output [4:0]  io_Debug_DebugLoadOp,
  output        io_Debug_DebugPcJump,
  output [31:0] io_Debug_DebugNextPc,
  output [11:0] io_Debug_DebugCsrWAddr,
  output [31:0] io_Debug_DebugCsrWData,
  output        io_Debug_DebugExeValid,
  output [31:0] io_Debug_DebugWData,
  output [4:0]  io_Debug_DebugMemRd_r,
  output        io_DeBugAddrOk,
  output        io_DeBugDataOk,
  output [31:0] io_DeBugRData
);
  wire  Cpu_clock; // @[SocTop.scala 15:29]
  wire  Cpu_reset; // @[SocTop.scala 15:29]
  wire  Cpu_io_Axi_ExeData_data_sram_en; // @[SocTop.scala 15:29]
  wire  Cpu_io_Axi_ExeData_data_sram_wen; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Axi_ExeData_data_sram_addr; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Axi_ExeData_data_sram_wdata; // @[SocTop.scala 15:29]
  wire [1:0] Cpu_io_Axi_ExeData_data_size; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Axi_DataMem_data_sram_rdata; // @[SocTop.scala 15:29]
  wire  Cpu_io_Axi_DataMem_data_ok; // @[SocTop.scala 15:29]
  wire  Cpu_io_Axi_DataMem_data_addr_ok; // @[SocTop.scala 15:29]
  wire  Cpu_io_Instr_PreIfInstr_inst_sram_en; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Instr_PreIfInstr_inst_sram_addr; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Instr_InstrIf_inst_sram_rdata; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugInstr; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugPc; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugIfValid; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugIfEn; // @[SocTop.scala 15:29]
  wire [9:0] Cpu_io_Debug_Debug_alu_op; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_data1; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_data2; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_Debug_mmu_en; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_Debug_mmu_wen; // @[SocTop.scala 15:29]
  wire [4:0] Cpu_io_Debug_Debug_mmu_op; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_mmu_RData2; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_Debug_pcu_en; // @[SocTop.scala 15:29]
  wire [7:0] Cpu_io_Debug_Debug_pcu_op; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_pcu_data1; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_pcu_data2; // @[SocTop.scala 15:29]
  wire [4:0] Cpu_io_Debug_Debug_rd_r; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_Debug_csr_en; // @[SocTop.scala 15:29]
  wire [2:0] Cpu_io_Debug_Debug_csr_op; // @[SocTop.scala 15:29]
  wire [11:0] Cpu_io_Debug_Debug_csr_waddr; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_csr_data; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_Debug_csr_imm; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_Debug_IdValid; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugResult; // @[SocTop.scala 15:29]
  wire [4:0] Cpu_io_Debug_DebugRd_r; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugDataEn; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugDataWen; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugDataWdata; // @[SocTop.scala 15:29]
  wire [1:0] Cpu_io_Debug_DebugDataSize; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugDataMemValid; // @[SocTop.scala 15:29]
  wire [4:0] Cpu_io_Debug_DebugLoadOp; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugPcJump; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugNextPc; // @[SocTop.scala 15:29]
  wire [11:0] Cpu_io_Debug_DebugCsrWAddr; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugCsrWData; // @[SocTop.scala 15:29]
  wire  Cpu_io_Debug_DebugExeValid; // @[SocTop.scala 15:29]
  wire [31:0] Cpu_io_Debug_DebugWData; // @[SocTop.scala 15:29]
  wire [4:0] Cpu_io_Debug_DebugMemRd_r; // @[SocTop.scala 15:29]
  wire  SramAxi_clock; // @[SocTop.scala 16:29]
  wire  SramAxi_reset; // @[SocTop.scala 16:29]
  wire  SramAxi_io_Cpu_ExeData_data_sram_en; // @[SocTop.scala 16:29]
  wire  SramAxi_io_Cpu_ExeData_data_sram_wen; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_Cpu_ExeData_data_sram_addr; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_Cpu_ExeData_data_sram_wdata; // @[SocTop.scala 16:29]
  wire [1:0] SramAxi_io_Cpu_ExeData_data_size; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_Cpu_DataMem_data_sram_rdata; // @[SocTop.scala 16:29]
  wire  SramAxi_io_Cpu_DataMem_data_ok; // @[SocTop.scala 16:29]
  wire  SramAxi_io_Cpu_DataMem_data_addr_ok; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_AR_ArAddr; // @[SocTop.scala 16:29]
  wire  SramAxi_io_AR_ArValid; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_R_RData; // @[SocTop.scala 16:29]
  wire  SramAxi_io_R_RLast; // @[SocTop.scala 16:29]
  wire  SramAxi_io_R_RValid; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_AW_AwAddr; // @[SocTop.scala 16:29]
  wire [2:0] SramAxi_io_AW_Awize; // @[SocTop.scala 16:29]
  wire  SramAxi_io_AW_AwValid; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_W_WData; // @[SocTop.scala 16:29]
  wire  SramAxi_io_W_WLast; // @[SocTop.scala 16:29]
  wire  SramAxi_io_W_WValid; // @[SocTop.scala 16:29]
  wire  SramAxi_io_B_Bvalid; // @[SocTop.scala 16:29]
  wire  SramAxi_io_DeBugAddrOk; // @[SocTop.scala 16:29]
  wire  SramAxi_io_DeBugDataOk; // @[SocTop.scala 16:29]
  wire [31:0] SramAxi_io_DeBugRData; // @[SocTop.scala 16:29]
  wire  DataMemSlave_clock; // @[SocTop.scala 17:29]
  wire  DataMemSlave_reset; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_MemData_data_sram_en; // @[SocTop.scala 17:29]
  wire [3:0] DataMemSlave_io_MemData_data_sram_wen; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_MemData_data_sram_addr; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_MemData_data_sram_wdata; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_MemData_data_sram_rdata; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_AR_ArAddr; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_AR_ArValid; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_R_RData; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_R_RLast; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_R_RValid; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_AW_AwAddr; // @[SocTop.scala 17:29]
  wire [2:0] DataMemSlave_io_AW_Awize; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_AW_AwValid; // @[SocTop.scala 17:29]
  wire [31:0] DataMemSlave_io_W_WData; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_W_WLast; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_W_WValid; // @[SocTop.scala 17:29]
  wire  DataMemSlave_io_B_Bvalid; // @[SocTop.scala 17:29]
  CoreTop Cpu ( // @[SocTop.scala 15:29]
    .clock(Cpu_clock),
    .reset(Cpu_reset),
    .io_Axi_ExeData_data_sram_en(Cpu_io_Axi_ExeData_data_sram_en),
    .io_Axi_ExeData_data_sram_wen(Cpu_io_Axi_ExeData_data_sram_wen),
    .io_Axi_ExeData_data_sram_addr(Cpu_io_Axi_ExeData_data_sram_addr),
    .io_Axi_ExeData_data_sram_wdata(Cpu_io_Axi_ExeData_data_sram_wdata),
    .io_Axi_ExeData_data_size(Cpu_io_Axi_ExeData_data_size),
    .io_Axi_DataMem_data_sram_rdata(Cpu_io_Axi_DataMem_data_sram_rdata),
    .io_Axi_DataMem_data_ok(Cpu_io_Axi_DataMem_data_ok),
    .io_Axi_DataMem_data_addr_ok(Cpu_io_Axi_DataMem_data_addr_ok),
    .io_Instr_PreIfInstr_inst_sram_en(Cpu_io_Instr_PreIfInstr_inst_sram_en),
    .io_Instr_PreIfInstr_inst_sram_addr(Cpu_io_Instr_PreIfInstr_inst_sram_addr),
    .io_Instr_InstrIf_inst_sram_rdata(Cpu_io_Instr_InstrIf_inst_sram_rdata),
    .io_Debug_DebugInstr(Cpu_io_Debug_DebugInstr),
    .io_Debug_DebugPc(Cpu_io_Debug_DebugPc),
    .io_Debug_DebugIfValid(Cpu_io_Debug_DebugIfValid),
    .io_Debug_DebugIfEn(Cpu_io_Debug_DebugIfEn),
    .io_Debug_Debug_alu_op(Cpu_io_Debug_Debug_alu_op),
    .io_Debug_Debug_data1(Cpu_io_Debug_Debug_data1),
    .io_Debug_Debug_data2(Cpu_io_Debug_Debug_data2),
    .io_Debug_Debug_mmu_en(Cpu_io_Debug_Debug_mmu_en),
    .io_Debug_Debug_mmu_wen(Cpu_io_Debug_Debug_mmu_wen),
    .io_Debug_Debug_mmu_op(Cpu_io_Debug_Debug_mmu_op),
    .io_Debug_Debug_mmu_RData2(Cpu_io_Debug_Debug_mmu_RData2),
    .io_Debug_Debug_pcu_en(Cpu_io_Debug_Debug_pcu_en),
    .io_Debug_Debug_pcu_op(Cpu_io_Debug_Debug_pcu_op),
    .io_Debug_Debug_pcu_data1(Cpu_io_Debug_Debug_pcu_data1),
    .io_Debug_Debug_pcu_data2(Cpu_io_Debug_Debug_pcu_data2),
    .io_Debug_Debug_rd_r(Cpu_io_Debug_Debug_rd_r),
    .io_Debug_Debug_csr_en(Cpu_io_Debug_Debug_csr_en),
    .io_Debug_Debug_csr_op(Cpu_io_Debug_Debug_csr_op),
    .io_Debug_Debug_csr_waddr(Cpu_io_Debug_Debug_csr_waddr),
    .io_Debug_Debug_csr_data(Cpu_io_Debug_Debug_csr_data),
    .io_Debug_Debug_csr_imm(Cpu_io_Debug_Debug_csr_imm),
    .io_Debug_Debug_IdValid(Cpu_io_Debug_Debug_IdValid),
    .io_Debug_DebugResult(Cpu_io_Debug_DebugResult),
    .io_Debug_DebugRd_r(Cpu_io_Debug_DebugRd_r),
    .io_Debug_DebugDataEn(Cpu_io_Debug_DebugDataEn),
    .io_Debug_DebugDataWen(Cpu_io_Debug_DebugDataWen),
    .io_Debug_DebugDataWdata(Cpu_io_Debug_DebugDataWdata),
    .io_Debug_DebugDataSize(Cpu_io_Debug_DebugDataSize),
    .io_Debug_DebugDataMemValid(Cpu_io_Debug_DebugDataMemValid),
    .io_Debug_DebugLoadOp(Cpu_io_Debug_DebugLoadOp),
    .io_Debug_DebugPcJump(Cpu_io_Debug_DebugPcJump),
    .io_Debug_DebugNextPc(Cpu_io_Debug_DebugNextPc),
    .io_Debug_DebugCsrWAddr(Cpu_io_Debug_DebugCsrWAddr),
    .io_Debug_DebugCsrWData(Cpu_io_Debug_DebugCsrWData),
    .io_Debug_DebugExeValid(Cpu_io_Debug_DebugExeValid),
    .io_Debug_DebugWData(Cpu_io_Debug_DebugWData),
    .io_Debug_DebugMemRd_r(Cpu_io_Debug_DebugMemRd_r)
  );
  AxiMasterAxi SramAxi ( // @[SocTop.scala 16:29]
    .clock(SramAxi_clock),
    .reset(SramAxi_reset),
    .io_Cpu_ExeData_data_sram_en(SramAxi_io_Cpu_ExeData_data_sram_en),
    .io_Cpu_ExeData_data_sram_wen(SramAxi_io_Cpu_ExeData_data_sram_wen),
    .io_Cpu_ExeData_data_sram_addr(SramAxi_io_Cpu_ExeData_data_sram_addr),
    .io_Cpu_ExeData_data_sram_wdata(SramAxi_io_Cpu_ExeData_data_sram_wdata),
    .io_Cpu_ExeData_data_size(SramAxi_io_Cpu_ExeData_data_size),
    .io_Cpu_DataMem_data_sram_rdata(SramAxi_io_Cpu_DataMem_data_sram_rdata),
    .io_Cpu_DataMem_data_ok(SramAxi_io_Cpu_DataMem_data_ok),
    .io_Cpu_DataMem_data_addr_ok(SramAxi_io_Cpu_DataMem_data_addr_ok),
    .io_AR_ArAddr(SramAxi_io_AR_ArAddr),
    .io_AR_ArValid(SramAxi_io_AR_ArValid),
    .io_R_RData(SramAxi_io_R_RData),
    .io_R_RLast(SramAxi_io_R_RLast),
    .io_R_RValid(SramAxi_io_R_RValid),
    .io_AW_AwAddr(SramAxi_io_AW_AwAddr),
    .io_AW_Awize(SramAxi_io_AW_Awize),
    .io_AW_AwValid(SramAxi_io_AW_AwValid),
    .io_W_WData(SramAxi_io_W_WData),
    .io_W_WLast(SramAxi_io_W_WLast),
    .io_W_WValid(SramAxi_io_W_WValid),
    .io_B_Bvalid(SramAxi_io_B_Bvalid),
    .io_DeBugAddrOk(SramAxi_io_DeBugAddrOk),
    .io_DeBugDataOk(SramAxi_io_DeBugDataOk),
    .io_DeBugRData(SramAxi_io_DeBugRData)
  );
  DataMemSlave DataMemSlave ( // @[SocTop.scala 17:29]
    .clock(DataMemSlave_clock),
    .reset(DataMemSlave_reset),
    .io_MemData_data_sram_en(DataMemSlave_io_MemData_data_sram_en),
    .io_MemData_data_sram_wen(DataMemSlave_io_MemData_data_sram_wen),
    .io_MemData_data_sram_addr(DataMemSlave_io_MemData_data_sram_addr),
    .io_MemData_data_sram_wdata(DataMemSlave_io_MemData_data_sram_wdata),
    .io_MemData_data_sram_rdata(DataMemSlave_io_MemData_data_sram_rdata),
    .io_AR_ArAddr(DataMemSlave_io_AR_ArAddr),
    .io_AR_ArValid(DataMemSlave_io_AR_ArValid),
    .io_R_RData(DataMemSlave_io_R_RData),
    .io_R_RLast(DataMemSlave_io_R_RLast),
    .io_R_RValid(DataMemSlave_io_R_RValid),
    .io_AW_AwAddr(DataMemSlave_io_AW_AwAddr),
    .io_AW_Awize(DataMemSlave_io_AW_Awize),
    .io_AW_AwValid(DataMemSlave_io_AW_AwValid),
    .io_W_WData(DataMemSlave_io_W_WData),
    .io_W_WLast(DataMemSlave_io_W_WLast),
    .io_W_WValid(DataMemSlave_io_W_WValid),
    .io_B_Bvalid(DataMemSlave_io_B_Bvalid)
  );
  assign io_Instr_PreIfInstr_inst_sram_en = Cpu_io_Instr_PreIfInstr_inst_sram_en; // @[SocTop.scala 27:43]
  assign io_Instr_PreIfInstr_inst_sram_wen = 4'h0; // @[SocTop.scala 28:43]
  assign io_Instr_PreIfInstr_inst_sram_addr = Cpu_io_Instr_PreIfInstr_inst_sram_addr; // @[SocTop.scala 29:43]
  assign io_Instr_PreIfInstr_inst_sram_wdata = 32'h0; // @[SocTop.scala 30:43]
  assign io_MemData_data_sram_en = DataMemSlave_io_MemData_data_sram_en; // @[SocTop.scala 33:31]
  assign io_MemData_data_sram_wen = DataMemSlave_io_MemData_data_sram_wen; // @[SocTop.scala 34:31]
  assign io_MemData_data_sram_addr = DataMemSlave_io_MemData_data_sram_addr; // @[SocTop.scala 35:31]
  assign io_MemData_data_sram_wdata = DataMemSlave_io_MemData_data_sram_wdata; // @[SocTop.scala 36:31]
  assign io_Debug_DebugInstr = Cpu_io_Debug_DebugInstr; // @[SocTop.scala 40:26]
  assign io_Debug_DebugPc = Cpu_io_Debug_DebugPc; // @[SocTop.scala 41:26]
  assign io_Debug_DebugIfValid = Cpu_io_Debug_DebugIfValid; // @[SocTop.scala 42:26]
  assign io_Debug_DebugIfEn = Cpu_io_Debug_DebugIfEn; // @[SocTop.scala 43:26]
  assign io_Debug_Debug_alu_op = Cpu_io_Debug_Debug_alu_op; // @[SocTop.scala 45:26]
  assign io_Debug_Debug_data1 = Cpu_io_Debug_Debug_data1; // @[SocTop.scala 46:26]
  assign io_Debug_Debug_data2 = Cpu_io_Debug_Debug_data2; // @[SocTop.scala 47:26]
  assign io_Debug_Debug_mmu_en = Cpu_io_Debug_Debug_mmu_en; // @[SocTop.scala 48:26]
  assign io_Debug_Debug_mmu_wen = Cpu_io_Debug_Debug_mmu_wen; // @[SocTop.scala 49:26]
  assign io_Debug_Debug_mmu_op = Cpu_io_Debug_Debug_mmu_op; // @[SocTop.scala 50:26]
  assign io_Debug_Debug_mmu_RData2 = Cpu_io_Debug_Debug_mmu_RData2; // @[SocTop.scala 51:26]
  assign io_Debug_Debug_pcu_en = Cpu_io_Debug_Debug_pcu_en; // @[SocTop.scala 52:26]
  assign io_Debug_Debug_pcu_op = Cpu_io_Debug_Debug_pcu_op; // @[SocTop.scala 53:26]
  assign io_Debug_Debug_pcu_data1 = Cpu_io_Debug_Debug_pcu_data1; // @[SocTop.scala 54:26]
  assign io_Debug_Debug_pcu_data2 = Cpu_io_Debug_Debug_pcu_data2; // @[SocTop.scala 55:26]
  assign io_Debug_Debug_rd_r = Cpu_io_Debug_Debug_rd_r; // @[SocTop.scala 56:26]
  assign io_Debug_Debug_csr_en = Cpu_io_Debug_Debug_csr_en; // @[SocTop.scala 57:26]
  assign io_Debug_Debug_csr_op = Cpu_io_Debug_Debug_csr_op; // @[SocTop.scala 58:26]
  assign io_Debug_Debug_csr_waddr = Cpu_io_Debug_Debug_csr_waddr; // @[SocTop.scala 59:26]
  assign io_Debug_Debug_csr_data = Cpu_io_Debug_Debug_csr_data; // @[SocTop.scala 60:26]
  assign io_Debug_Debug_csr_imm = Cpu_io_Debug_Debug_csr_imm; // @[SocTop.scala 61:26]
  assign io_Debug_Debug_IdValid = Cpu_io_Debug_Debug_IdValid; // @[SocTop.scala 62:26]
  assign io_Debug_DebugResult = Cpu_io_Debug_DebugResult; // @[SocTop.scala 65:28]
  assign io_Debug_DebugRd_r = Cpu_io_Debug_DebugRd_r; // @[SocTop.scala 66:28]
  assign io_Debug_DebugDataEn = Cpu_io_Debug_DebugDataEn; // @[SocTop.scala 67:28]
  assign io_Debug_DebugDataWen = Cpu_io_Debug_DebugDataWen; // @[SocTop.scala 68:28]
  assign io_Debug_DebugDataWdata = Cpu_io_Debug_DebugDataWdata; // @[SocTop.scala 69:28]
  assign io_Debug_DebugDataSize = Cpu_io_Debug_DebugDataSize; // @[SocTop.scala 70:28]
  assign io_Debug_DebugDataMemValid = Cpu_io_Debug_DebugDataMemValid; // @[SocTop.scala 71:28]
  assign io_Debug_DebugLoadOp = Cpu_io_Debug_DebugLoadOp; // @[SocTop.scala 72:28]
  assign io_Debug_DebugPcJump = Cpu_io_Debug_DebugPcJump; // @[SocTop.scala 73:28]
  assign io_Debug_DebugNextPc = Cpu_io_Debug_DebugNextPc; // @[SocTop.scala 74:28]
  assign io_Debug_DebugCsrWAddr = Cpu_io_Debug_DebugCsrWAddr; // @[SocTop.scala 75:28]
  assign io_Debug_DebugCsrWData = Cpu_io_Debug_DebugCsrWData; // @[SocTop.scala 76:28]
  assign io_Debug_DebugExeValid = Cpu_io_Debug_DebugExeValid; // @[SocTop.scala 77:28]
  assign io_Debug_DebugWData = Cpu_io_Debug_DebugWData; // @[SocTop.scala 79:28]
  assign io_Debug_DebugMemRd_r = Cpu_io_Debug_DebugMemRd_r; // @[SocTop.scala 80:28]
  assign io_DeBugAddrOk = SramAxi_io_DeBugAddrOk; // @[SocTop.scala 82:16]
  assign io_DeBugDataOk = SramAxi_io_DeBugDataOk; // @[SocTop.scala 83:16]
  assign io_DeBugRData = SramAxi_io_DeBugRData; // @[SocTop.scala 84:16]
  assign Cpu_clock = clock;
  assign Cpu_reset = reset;
  assign Cpu_io_Axi_DataMem_data_sram_rdata = SramAxi_io_Cpu_DataMem_data_sram_rdata; // @[SocTop.scala 19:15]
  assign Cpu_io_Axi_DataMem_data_ok = SramAxi_io_Cpu_DataMem_data_ok; // @[SocTop.scala 19:15]
  assign Cpu_io_Axi_DataMem_data_addr_ok = SramAxi_io_Cpu_DataMem_data_addr_ok; // @[SocTop.scala 19:15]
  assign Cpu_io_Instr_InstrIf_inst_sram_rdata = io_Instr_InstrIf_inst_sram_rdata; // @[SocTop.scala 31:43]
  assign SramAxi_clock = clock;
  assign SramAxi_reset = reset;
  assign SramAxi_io_Cpu_ExeData_data_sram_en = Cpu_io_Axi_ExeData_data_sram_en; // @[SocTop.scala 19:15]
  assign SramAxi_io_Cpu_ExeData_data_sram_wen = Cpu_io_Axi_ExeData_data_sram_wen; // @[SocTop.scala 19:15]
  assign SramAxi_io_Cpu_ExeData_data_sram_addr = Cpu_io_Axi_ExeData_data_sram_addr; // @[SocTop.scala 19:15]
  assign SramAxi_io_Cpu_ExeData_data_sram_wdata = Cpu_io_Axi_ExeData_data_sram_wdata; // @[SocTop.scala 19:15]
  assign SramAxi_io_Cpu_ExeData_data_size = Cpu_io_Axi_ExeData_data_size; // @[SocTop.scala 19:15]
  assign SramAxi_io_R_RData = DataMemSlave_io_R_RData; // @[SocTop.scala 23:18]
  assign SramAxi_io_R_RLast = DataMemSlave_io_R_RLast; // @[SocTop.scala 23:18]
  assign SramAxi_io_R_RValid = DataMemSlave_io_R_RValid; // @[SocTop.scala 23:18]
  assign SramAxi_io_B_Bvalid = DataMemSlave_io_B_Bvalid; // @[SocTop.scala 25:18]
  assign DataMemSlave_clock = clock;
  assign DataMemSlave_reset = reset;
  assign DataMemSlave_io_MemData_data_sram_rdata = io_MemData_data_sram_rdata; // @[SocTop.scala 37:45]
  assign DataMemSlave_io_AR_ArAddr = SramAxi_io_AR_ArAddr; // @[SocTop.scala 21:18]
  assign DataMemSlave_io_AR_ArValid = SramAxi_io_AR_ArValid; // @[SocTop.scala 21:18]
  assign DataMemSlave_io_AW_AwAddr = SramAxi_io_AW_AwAddr; // @[SocTop.scala 22:18]
  assign DataMemSlave_io_AW_Awize = SramAxi_io_AW_Awize; // @[SocTop.scala 22:18]
  assign DataMemSlave_io_AW_AwValid = SramAxi_io_AW_AwValid; // @[SocTop.scala 22:18]
  assign DataMemSlave_io_W_WData = SramAxi_io_W_WData; // @[SocTop.scala 24:18]
  assign DataMemSlave_io_W_WLast = SramAxi_io_W_WLast; // @[SocTop.scala 24:18]
  assign DataMemSlave_io_W_WValid = SramAxi_io_W_WValid; // @[SocTop.scala 24:18]
endmodule
