module Debounce(
  input        clock,
  input        reset,
  input        io_btnU,
  input  [7:0] io_sw,
  output [7:0] io_led
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  btnSync_REG; // @[Debounce.scala 13:38]
  reg  btnSync; // @[Debounce.scala 13:30]
  reg [19:0] tick_reg; // @[Debounce.scala 18:22]
  wire  tick = tick_reg == 20'hf423f; // @[Debounce.scala 19:20]
  wire [19:0] _tick_reg_T_1 = tick_reg + 20'h1; // @[Debounce.scala 20:31]
  reg  btnDeb; // @[Debounce.scala 35:19]
  reg [2:0] btnFilter_reg; // @[Debounce.scala 25:22]
  wire [2:0] _btnFilter_reg_T_1 = {btnFilter_reg[1:0],btnDeb}; // @[Cat.scala 31:58]
  wire  btnFilter = btnFilter_reg[2] & btnFilter_reg[1] | btnFilter_reg[2] & btnFilter_reg[0] | btnFilter_reg[1] &
    btnFilter_reg[0]; // @[Debounce.scala 29:43]
  reg  risingEdge_REG; // @[Debounce.scala 15:37]
  wire  risingEdge = btnFilter & ~risingEdge_REG; // @[Debounce.scala 15:27]
  reg [7:0] r1; // @[Debounce.scala 45:19]
  wire [7:0] _r1_T_1 = r1 + 8'h1; // @[Debounce.scala 47:14]
  assign io_led = r1; // @[Debounce.scala 50:10]
  always @(posedge clock) begin
    btnSync_REG <= io_btnU; // @[Debounce.scala 13:38]
    btnSync <= btnSync_REG; // @[Debounce.scala 13:30]
    if (reset) begin // @[Debounce.scala 18:22]
      tick_reg <= 20'h0; // @[Debounce.scala 18:22]
    end else if (tick) begin // @[Debounce.scala 20:15]
      tick_reg <= 20'h0;
    end else begin
      tick_reg <= _tick_reg_T_1;
    end
    if (tick) begin // @[Debounce.scala 36:15]
      btnDeb <= btnSync; // @[Debounce.scala 37:12]
    end
    if (reset) begin // @[Debounce.scala 25:22]
      btnFilter_reg <= 3'h0; // @[Debounce.scala 25:22]
    end else if (tick) begin // @[Debounce.scala 26:14]
      btnFilter_reg <= _btnFilter_reg_T_1; // @[Debounce.scala 27:11]
    end
    risingEdge_REG <= btnFilter_reg[2] & btnFilter_reg[1] | btnFilter_reg[2] & btnFilter_reg[0] | btnFilter_reg[1] &
      btnFilter_reg[0]; // @[Debounce.scala 29:43]
    if (reset) begin // @[Debounce.scala 45:19]
      r1 <= 8'h0; // @[Debounce.scala 45:19]
    end else if (risingEdge) begin // @[Debounce.scala 46:21]
      r1 <= _r1_T_1; // @[Debounce.scala 47:8]
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
  btnSync_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  btnSync = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  tick_reg = _RAND_2[19:0];
  _RAND_3 = {1{`RANDOM}};
  btnDeb = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  btnFilter_reg = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  risingEdge_REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  r1 = _RAND_6[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
