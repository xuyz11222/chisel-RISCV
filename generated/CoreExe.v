module ALU(
  input  [9:0]  io_op,
  input  [31:0] io_data1,
  input  [31:0] io_data2,
  output [31:0] io_result
);
  wire  op_sub = io_op[1]; // @[Alu.scala 21:19]
  wire  op_slt = io_op[2]; // @[Alu.scala 22:19]
  wire  op_sltu = io_op[3]; // @[Alu.scala 23:19]
  wire  op_sra = io_op[9]; // @[Alu.scala 29:19]
  wire  _adder_b_T_1 = op_sub | op_slt | op_sltu; // @[Alu.scala 32:42]
  wire [31:0] _adder_b_T_2 = ~io_data2; // @[Alu.scala 32:55]
  wire [31:0] adder_b = op_sub | op_slt | op_sltu ? _adder_b_T_2 : io_data2; // @[Alu.scala 32:24]
  wire [31:0] _adder_cout_result_T_1 = io_data1 + adder_b; // @[Alu.scala 35:32]
  wire [31:0] _GEN_10 = {{31'd0}, _adder_b_T_1}; // @[Alu.scala 35:42]
  wire [31:0] _adder_cout_result_T_3 = _adder_cout_result_T_1 + _GEN_10; // @[Alu.scala 35:42]
  wire [32:0] adder_cout_result = {{1'd0}, _adder_cout_result_T_3}; // @[Alu.scala 34:30 35:21]
  wire  adder_cout = adder_cout_result[32]; // @[Alu.scala 37:39]
  wire [31:0] add_sub_result = adder_cout_result[31:0]; // @[Alu.scala 38:39]
  wire  _slt_result_T_3 = io_data1[31] & ~io_data2[31]; // @[Alu.scala 41:36]
  wire  _slt_result_T_9 = _slt_result_T_3 | io_data1[31] == io_data2[31] & add_sub_result[31]; // @[Alu.scala 42:25]
  wire [31:0] slt_result = {31'h0,_slt_result_T_9}; // @[Cat.scala 31:58]
  wire  _sltu_result_T = ~adder_cout; // @[Alu.scala 43:37]
  wire [31:0] sltu_result = {31'h0,_sltu_result_T}; // @[Cat.scala 31:58]
  wire [31:0] and_result = io_data1 & io_data2; // @[Alu.scala 44:26]
  wire [31:0] or_result = io_data1 | io_data2; // @[Alu.scala 45:26]
  wire [31:0] xor_result = io_data1 ^ io_data2; // @[Alu.scala 46:26]
  wire [62:0] _GEN_11 = {{31'd0}, io_data1}; // @[Alu.scala 47:26]
  wire [62:0] sll_result = _GEN_11 << io_data2[4:0]; // @[Alu.scala 47:26]
  wire  _data1_64_T_1 = op_sra & io_data1[31]; // @[Alu.scala 48:38]
  wire [31:0] _data1_64_T_3 = _data1_64_T_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 74:12]
  wire [63:0] data1_64 = {_data1_64_T_3,io_data1}; // @[Cat.scala 31:58]
  wire [63:0] sr64_result = data1_64 >> io_data2[4:0]; // @[Alu.scala 49:29]
  wire [31:0] sr_result = sr64_result[31:0]; // @[Alu.scala 50:32]
  wire [31:0] _GEN_0 = 10'h200 == io_op ? sr_result : 32'h0; // @[Alu.scala 17:10 52:13 62:22]
  wire [31:0] _GEN_1 = 10'h100 == io_op ? sr_result : _GEN_0; // @[Alu.scala 52:13 61:22]
  wire [62:0] _GEN_2 = 10'h80 == io_op ? sll_result : {{31'd0}, _GEN_1}; // @[Alu.scala 52:13 60:22]
  wire [62:0] _GEN_3 = 10'h40 == io_op ? {{31'd0}, xor_result} : _GEN_2; // @[Alu.scala 52:13 59:21]
  wire [62:0] _GEN_4 = 10'h20 == io_op ? {{31'd0}, or_result} : _GEN_3; // @[Alu.scala 52:13 58:21]
  wire [62:0] _GEN_5 = 10'h10 == io_op ? {{31'd0}, and_result} : _GEN_4; // @[Alu.scala 52:13 57:21]
  wire [62:0] _GEN_6 = 10'h8 == io_op ? {{31'd0}, sltu_result} : _GEN_5; // @[Alu.scala 52:13 56:20]
  wire [62:0] _GEN_7 = 10'h4 == io_op ? {{31'd0}, slt_result} : _GEN_6; // @[Alu.scala 52:13 55:20]
  wire [62:0] _GEN_8 = 10'h2 == io_op ? {{31'd0}, add_sub_result} : _GEN_7; // @[Alu.scala 52:13 54:20]
  wire [62:0] _GEN_9 = 10'h1 == io_op ? {{31'd0}, add_sub_result} : _GEN_8; // @[Alu.scala 52:13 53:20]
  assign io_result = _GEN_9[31:0]; // @[Alu.scala 16:20]
endmodule
module CoreExe(
  input         clock,
  input         reset,
  input         io_Mem_MemReady,
  output [31:0] io_Mem_Result,
  output [4:0]  io_Mem_Rd,
  input  [9:0]  io_Id_AluOp,
  input  [31:0] io_Id_Data1,
  input  [31:0] io_Id_Data2,
  input         io_Id_MmuEn,
  input         io_Id_MmuWen,
  input  [4:0]  io_Id_MmuOp,
  input  [31:0] io_Id_MmuRData2,
  input  [4:0]  io_Id_Rd,
  output        io_Id_ExeReady
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [9:0] ALU_io_op; // @[Core_exe.scala 19:21]
  wire [31:0] ALU_io_data1; // @[Core_exe.scala 19:21]
  wire [31:0] ALU_io_data2; // @[Core_exe.scala 19:21]
  wire [31:0] ALU_io_result; // @[Core_exe.scala 19:21]
  reg [31:0] Result; // @[Core_exe.scala 28:27]
  reg [4:0] Rd_r; // @[Core_exe.scala 29:27]
  ALU ALU ( // @[Core_exe.scala 19:21]
    .io_op(ALU_io_op),
    .io_data1(ALU_io_data1),
    .io_data2(ALU_io_data2),
    .io_result(ALU_io_result)
  );
  assign io_Mem_Result = Result; // @[Core_exe.scala 35:19]
  assign io_Mem_Rd = Rd_r; // @[Core_exe.scala 36:19]
  assign io_Id_ExeReady = io_Mem_MemReady; // @[Core_exe.scala 37:19]
  assign ALU_io_op = io_Id_AluOp; // @[Core_exe.scala 31:17]
  assign ALU_io_data1 = io_Id_Data1; // @[Core_exe.scala 32:17]
  assign ALU_io_data2 = io_Id_Data2; // @[Core_exe.scala 33:17]
  always @(posedge clock) begin
    if (reset) begin // @[Core_exe.scala 28:27]
      Result <= 32'h0; // @[Core_exe.scala 28:27]
    end else if (io_Mem_MemReady) begin // @[Core_exe.scala 39:19]
      Result <= ALU_io_result; // @[Core_exe.scala 40:16]
    end
    if (reset) begin // @[Core_exe.scala 29:27]
      Rd_r <= 5'h0; // @[Core_exe.scala 29:27]
    end else if (io_Mem_MemReady) begin // @[Core_exe.scala 39:19]
      Rd_r <= io_Id_Rd; // @[Core_exe.scala 41:16]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
