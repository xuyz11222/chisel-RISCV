module CoreId(
  input         clock,
  input         reset,
  output        io_If_IdReady,
  input  [31:0] io_If_IfInstr,
  output [9:0]  io_Exe_AluOp,
  output [31:0] io_Exe_Data1,
  output [31:0] io_Exe_Data2,
  output        io_Exe_MmuEn,
  output        io_Exe_MmuWen,
  output [4:0]  io_Exe_MmuOp,
  output [31:0] io_Exe_MmuRData2,
  output [4:0]  io_Exe_Rd,
  input         io_Exe_ExeReady,
  output [4:0]  io_RegFile_Rs1,
  output [4:0]  io_RegFile_Rs2,
  output [4:0]  io_RegFile_Rd,
  input  [31:0] io_RegFile_RData1,
  input  [31:0] io_RegFile_RData2,
  input         io_RegFile_RValid
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
`endif // RANDOMIZE_REG_INIT
  reg [9:0] alu_op; // @[Core_id.scala 29:24]
  reg [31:0] data1; // @[Core_id.scala 30:24]
  reg [31:0] data2; // @[Core_id.scala 31:24]
  reg  mmu_en; // @[Core_id.scala 32:24]
  reg  mmu_wen; // @[Core_id.scala 33:24]
  reg [4:0] mmu_op; // @[Core_id.scala 34:24]
  reg [31:0] mmu_RData2; // @[Core_id.scala 35:24]
  reg [4:0] rd_r; // @[Core_id.scala 36:24]
  wire [6:0] opcode = io_If_IfInstr[6:0]; // @[Core_id.scala 46:21]
  wire [4:0] rd = io_If_IfInstr[11:7]; // @[Core_id.scala 47:21]
  wire [2:0] fuct3 = io_If_IfInstr[14:12]; // @[Core_id.scala 48:21]
  wire [4:0] rs1 = io_If_IfInstr[19:15]; // @[Core_id.scala 49:21]
  wire [4:0] rs2 = io_If_IfInstr[24:20]; // @[Core_id.scala 50:21]
  wire [6:0] fuct7 = io_If_IfInstr[31:25]; // @[Core_id.scala 51:21]
  wire  R_op = opcode == 7'h33; // @[Core_id.scala 53:19]
  wire  I_op = opcode == 7'h13; // @[Core_id.scala 54:19]
  wire  S_op = opcode == 7'h23; // @[Core_id.scala 55:19]
  wire  L_op = opcode == 7'h3; // @[Core_id.scala 56:19]
  wire  B_op = opcode == 7'h63; // @[Core_id.scala 57:19]
  wire  J_type = opcode == 7'h6f; // @[Core_id.scala 59:21]
  wire  lui = opcode == 7'h37; // @[Core_id.scala 60:21]
  wire  auipc = opcode == 7'h17; // @[Core_id.scala 61:21]
  wire  jalr = opcode == 7'h67; // @[Core_id.scala 62:21]
  wire  I_type = I_op | L_op | jalr; // @[Core_id.scala 65:24]
  wire  U_type = lui | auipc; // @[Core_id.scala 68:18]
  wire [19:0] _imm_T_2 = io_If_IfInstr[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_4 = {_imm_T_2,io_If_IfInstr[31:20]}; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_11 = {_imm_T_2,fuct7,rd}; // @[Cat.scala 31:58]
  wire [18:0] _imm_T_14 = io_If_IfInstr[31] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_23 = {_imm_T_14,io_If_IfInstr[31],io_If_IfInstr[7],io_If_IfInstr[30:25],io_If_IfInstr[11:8],1'h0}; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_25 = {io_If_IfInstr[31:12],12'h0}; // @[Cat.scala 31:58]
  wire [10:0] _imm_T_28 = io_If_IfInstr[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_37 = {_imm_T_28,io_If_IfInstr[31],io_If_IfInstr[19:12],io_If_IfInstr[20],io_If_IfInstr[30:21],1'h0}
    ; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_38 = J_type ? _imm_T_37 : 32'h0; // @[Core_id.scala 75:17]
  wire [31:0] _imm_T_39 = U_type ? _imm_T_25 : _imm_T_38; // @[Core_id.scala 74:17]
  wire [31:0] _imm_T_40 = B_op ? _imm_T_23 : _imm_T_39; // @[Core_id.scala 73:17]
  wire [31:0] _imm_T_41 = S_op ? _imm_T_11 : _imm_T_40; // @[Core_id.scala 72:17]
  wire  _add_T = fuct3 == 3'h0; // @[Core_id.scala 81:36]
  wire  _add_T_1 = R_op & fuct3 == 3'h0; // @[Core_id.scala 81:27]
  wire  _add_T_2 = fuct7 == 7'h0; // @[Core_id.scala 81:56]
  wire  add = R_op & fuct3 == 3'h0 & fuct7 == 7'h0 | I_op & fuct3 == 3'h0 | L_op | S_op; // @[Core_id.scala 81:99]
  wire  _sub_T_2 = fuct7 == 7'h20; // @[Core_id.scala 82:56]
  wire  sub = _add_T_1 & fuct7 == 7'h20; // @[Core_id.scala 82:47]
  wire  _slt_T = fuct3 == 3'h2; // @[Core_id.scala 83:36]
  wire  slt = R_op & fuct3 == 3'h2 & _add_T_2 | I_op & fuct3 == 3'h2; // @[Core_id.scala 83:65]
  wire  sltu = R_op & fuct3 == 3'h3 & _add_T_2 | I_op & fuct3 == 3'h3; // @[Core_id.scala 84:65]
  wire  and_ = R_op & fuct3 == 3'h7 & _add_T_2 | I_op & fuct3 == 3'h7; // @[Core_id.scala 85:65]
  wire  or_ = R_op & fuct3 == 3'h6 & _add_T_2 | I_op & fuct3 == 3'h6; // @[Core_id.scala 86:66]
  wire  _xor_T = fuct3 == 3'h4; // @[Core_id.scala 87:36]
  wire  xor_ = R_op & fuct3 == 3'h4 & _add_T_2 | I_op & fuct3 == 3'h4; // @[Core_id.scala 87:65]
  wire  _sll_T = fuct3 == 3'h1; // @[Core_id.scala 88:36]
  wire  sll = R_op & fuct3 == 3'h1 & _add_T_2 | I_op & fuct3 == 3'h1 & _add_T_2; // @[Core_id.scala 88:65]
  wire  _srl_T = fuct3 == 3'h5; // @[Core_id.scala 89:36]
  wire  _srl_T_1 = R_op & fuct3 == 3'h5; // @[Core_id.scala 89:27]
  wire  _srl_T_5 = I_op & fuct3 == 3'h5; // @[Core_id.scala 89:74]
  wire  srl = R_op & fuct3 == 3'h5 & _add_T_2 | I_op & fuct3 == 3'h5 & _add_T_2; // @[Core_id.scala 89:65]
  wire  sra = _srl_T_1 & _sub_T_2 | _srl_T_5 & _sub_T_2; // @[Core_id.scala 90:69]
  wire  _io_If_IdReady_T = io_Exe_ExeReady & io_RegFile_RValid; // @[Core_id.scala 99:26]
  wire  _io_RegFile_Rs1_T = R_op | I_type; // @[Core_id.scala 101:27]
  wire [9:0] _alu_op_T_8 = {sra,srl,sll,xor_,or_,and_,sltu,slt,sub,add}; // @[Cat.scala 31:58]
  wire [4:0] _mmu_op_T_3 = {_srl_T,_xor_T,_slt_T,_sll_T,_add_T}; // @[Cat.scala 31:58]
  assign io_If_IdReady = io_Exe_ExeReady & io_RegFile_RValid; // @[Core_id.scala 99:26]
  assign io_Exe_AluOp = alu_op; // @[Core_id.scala 105:18]
  assign io_Exe_Data1 = data1; // @[Core_id.scala 106:18]
  assign io_Exe_Data2 = data2; // @[Core_id.scala 107:18]
  assign io_Exe_MmuEn = mmu_en; // @[Core_id.scala 108:18]
  assign io_Exe_MmuWen = mmu_wen; // @[Core_id.scala 109:18]
  assign io_Exe_MmuOp = mmu_op; // @[Core_id.scala 110:18]
  assign io_Exe_MmuRData2 = mmu_RData2; // @[Core_id.scala 111:18]
  assign io_Exe_Rd = rd_r; // @[Core_id.scala 112:18]
  assign io_RegFile_Rs1 = R_op | I_type | S_op | B_op ? rs1 : 5'h0; // @[Core_id.scala 101:20]
  assign io_RegFile_Rs2 = R_op | S_op | B_op ? rs2 : 5'h0; // @[Core_id.scala 102:20]
  assign io_RegFile_Rd = _io_RegFile_Rs1_T | U_type | J_type ? rd : 5'h0; // @[Core_id.scala 103:20]
  always @(posedge clock) begin
    if (reset) begin // @[Core_id.scala 29:24]
      alu_op <= 10'h0; // @[Core_id.scala 29:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      alu_op <= _alu_op_T_8; // @[Core_id.scala 117:15]
    end
    if (reset) begin // @[Core_id.scala 30:24]
      data1 <= 32'h0; // @[Core_id.scala 30:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      data1 <= io_RegFile_RData1; // @[Core_id.scala 118:15]
    end
    if (reset) begin // @[Core_id.scala 31:24]
      data2 <= 32'h0; // @[Core_id.scala 31:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      if (R_op) begin // @[Core_id.scala 119:22]
        data2 <= io_RegFile_RData2;
      end else if (I_type) begin // @[Core_id.scala 71:17]
        data2 <= _imm_T_4;
      end else begin
        data2 <= _imm_T_41;
      end
    end
    if (reset) begin // @[Core_id.scala 32:24]
      mmu_en <= 1'h0; // @[Core_id.scala 32:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      mmu_en <= L_op | S_op; // @[Core_id.scala 120:15]
    end
    if (reset) begin // @[Core_id.scala 33:24]
      mmu_wen <= 1'h0; // @[Core_id.scala 33:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      mmu_wen <= S_op; // @[Core_id.scala 121:15]
    end
    if (reset) begin // @[Core_id.scala 34:24]
      mmu_op <= 5'h0; // @[Core_id.scala 34:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      mmu_op <= _mmu_op_T_3; // @[Core_id.scala 122:15]
    end
    if (reset) begin // @[Core_id.scala 35:24]
      mmu_RData2 <= 32'h0; // @[Core_id.scala 35:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      if (S_op) begin // @[Core_id.scala 123:22]
        mmu_RData2 <= io_RegFile_RData2;
      end else begin
        mmu_RData2 <= 32'h0;
      end
    end
    if (reset) begin // @[Core_id.scala 36:24]
      rd_r <= 5'h0; // @[Core_id.scala 36:24]
    end else if (_io_If_IdReady_T) begin // @[Core_id.scala 116:24]
      rd_r <= io_RegFile_Rd; // @[Core_id.scala 124:15]
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
  rd_r = _RAND_7[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
