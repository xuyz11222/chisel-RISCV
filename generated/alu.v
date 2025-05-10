module alu(
  input         clock,
  input         reset,
  input  [9:0]  io_op,
  input  [31:0] io_data1,
  input  [31:0] io_data2,
  output [31:0] io_result
);
  wire  op_sub = io_op[1]; // @[combination circuit.scala 22:19]
  wire  op_slt = io_op[2]; // @[combination circuit.scala 23:19]
  wire  op_sltu = io_op[3]; // @[combination circuit.scala 24:19]
  wire  op_sra = io_op[9]; // @[combination circuit.scala 30:19]
  wire  _adder_b_T_1 = op_sub | op_slt | op_sltu; // @[combination circuit.scala 33:42]
  wire [31:0] _adder_b_T_2 = ~io_data2; // @[combination circuit.scala 33:55]
  wire [31:0] adder_b = op_sub | op_slt | op_sltu ? _adder_b_T_2 : io_data2; // @[combination circuit.scala 33:24]
  wire [31:0] _adder_cout_result_T_1 = io_data1 + adder_b; // @[combination circuit.scala 36:32]
  wire [31:0] _GEN_10 = {{31'd0}, _adder_b_T_1}; // @[combination circuit.scala 36:42]
  wire [31:0] _adder_cout_result_T_3 = _adder_cout_result_T_1 + _GEN_10; // @[combination circuit.scala 36:42]
  wire [32:0] adder_cout_result = {{1'd0}, _adder_cout_result_T_3}; // @[combination circuit.scala 35:30 combination circuit.scala 36:21]
  wire  adder_cout = adder_cout_result[32]; // @[combination circuit.scala 38:39]
  wire [31:0] add_sub_result = adder_cout_result[31:0]; // @[combination circuit.scala 39:39]
  wire  _slt_result_T_3 = io_data1[31] & ~io_data2[31]; // @[combination circuit.scala 42:36]
  wire  _slt_result_T_9 = _slt_result_T_3 | io_data1[31] == io_data2[31] & add_sub_result[31]; // @[combination circuit.scala 43:25]
  wire [31:0] slt_result = {31'h0,_slt_result_T_9}; // @[Cat.scala 31:58]
  wire  _sltu_result_T = ~adder_cout; // @[combination circuit.scala 44:37]
  wire [31:0] sltu_result = {31'h0,_sltu_result_T}; // @[Cat.scala 31:58]
  wire [31:0] and_result = io_data1 & io_data2; // @[combination circuit.scala 45:26]
  wire [31:0] or_result = io_data1 | io_data2; // @[combination circuit.scala 46:26]
  wire [31:0] xor_result = io_data1 ^ io_data2; // @[combination circuit.scala 47:26]
  wire [62:0] _GEN_11 = {{31'd0}, io_data1}; // @[combination circuit.scala 48:26]
  wire [62:0] sll_result = _GEN_11 << io_data2[4:0]; // @[combination circuit.scala 48:26]
  wire  _data1_64_T_1 = op_sra & io_data1[31]; // @[combination circuit.scala 49:38]
  wire [31:0] _data1_64_T_3 = _data1_64_T_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 74:12]
  wire [63:0] data1_64 = {_data1_64_T_3,io_data1}; // @[Cat.scala 31:58]
  wire [63:0] sr64_result = data1_64 >> io_data2[4:0]; // @[combination circuit.scala 50:29]
  wire [31:0] sr_result = sr64_result[31:0]; // @[combination circuit.scala 51:32]
  wire [31:0] _GEN_0 = 10'h200 == io_op ? sr_result : 32'h0; // @[combination circuit.scala 18:10 combination circuit.scala 53:13 combination circuit.scala 63:22]
  wire [31:0] _GEN_1 = 10'h100 == io_op ? sr_result : _GEN_0; // @[combination circuit.scala 53:13 combination circuit.scala 62:22]
  wire [62:0] _GEN_2 = 10'h80 == io_op ? sll_result : {{31'd0}, _GEN_1}; // @[combination circuit.scala 53:13 combination circuit.scala 61:22]
  wire [62:0] _GEN_3 = 10'h40 == io_op ? {{31'd0}, xor_result} : _GEN_2; // @[combination circuit.scala 53:13 combination circuit.scala 60:21]
  wire [62:0] _GEN_4 = 10'h20 == io_op ? {{31'd0}, or_result} : _GEN_3; // @[combination circuit.scala 53:13 combination circuit.scala 59:21]
  wire [62:0] _GEN_5 = 10'h10 == io_op ? {{31'd0}, and_result} : _GEN_4; // @[combination circuit.scala 53:13 combination circuit.scala 58:21]
  wire [62:0] _GEN_6 = 10'h8 == io_op ? {{31'd0}, sltu_result} : _GEN_5; // @[combination circuit.scala 53:13 combination circuit.scala 57:20]
  wire [62:0] _GEN_7 = 10'h4 == io_op ? {{31'd0}, slt_result} : _GEN_6; // @[combination circuit.scala 53:13 combination circuit.scala 56:20]
  wire [62:0] _GEN_8 = 10'h2 == io_op ? {{31'd0}, add_sub_result} : _GEN_7; // @[combination circuit.scala 53:13 combination circuit.scala 55:20]
  wire [62:0] _GEN_9 = 10'h1 == io_op ? {{31'd0}, add_sub_result} : _GEN_8; // @[combination circuit.scala 53:13 combination circuit.scala 54:20]
  assign io_result = _GEN_9[31:0]; // @[combination circuit.scala 17:20]
endmodule
