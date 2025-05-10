module Tick(
  input   clock,
  input   reset,
  output  io_tick
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] r1; // @[KnightRider.scala 66:19]
  wire  limit = r1 == 32'h7f2814; // @[KnightRider.scala 68:18]
  wire [31:0] _r1_T_1 = r1 + 32'h1; // @[KnightRider.scala 71:12]
  assign io_tick = r1 == 32'h7f2814; // @[KnightRider.scala 68:18]
  always @(posedge clock) begin
    if (reset) begin // @[KnightRider.scala 66:19]
      r1 <= 32'h0; // @[KnightRider.scala 66:19]
    end else if (limit) begin // @[KnightRider.scala 72:15]
      r1 <= 32'h0; // @[KnightRider.scala 73:8]
    end else begin
      r1 <= _r1_T_1; // @[KnightRider.scala 71:6]
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
  r1 = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module KnightRider(
  input        clock,
  input        reset,
  output [5:0] io_led
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  tick_clock; // @[KnightRider.scala 35:20]
  wire  tick_reset; // @[KnightRider.scala 35:20]
  wire  tick_io_tick; // @[KnightRider.scala 35:20]
  reg  stateReg; // @[KnightRider.scala 32:25]
  reg [5:0] ledReg; // @[KnightRider.scala 33:23]
  wire  _GEN_0 = ledReg[1] ? 1'h0 : stateReg; // @[KnightRider.scala 43:35 44:16 32:25]
  wire  _GEN_1 = ledReg[4] | _GEN_0; // @[KnightRider.scala 41:29 42:16]
  wire [6:0] _ledReg_T = {ledReg, 1'h0}; // @[KnightRider.scala 48:24]
  wire [6:0] _GEN_2 = ~stateReg ? _ledReg_T : {{2'd0}, ledReg[5:1]}; // @[KnightRider.scala 47:31 48:14 50:14]
  wire [6:0] _GEN_4 = tick_io_tick ? _GEN_2 : {{1'd0}, ledReg}; // @[KnightRider.scala 33:23 38:30]
  wire [6:0] _GEN_5 = reset ? 7'h1 : _GEN_4; // @[KnightRider.scala 33:{23,23}]
  Tick tick ( // @[KnightRider.scala 35:20]
    .clock(tick_clock),
    .reset(tick_reset),
    .io_tick(tick_io_tick)
  );
  assign io_led = ledReg; // @[KnightRider.scala 54:10]
  assign tick_clock = clock;
  assign tick_reset = reset;
  always @(posedge clock) begin
    if (reset) begin // @[KnightRider.scala 32:25]
      stateReg <= 1'h0; // @[KnightRider.scala 32:25]
    end else if (tick_io_tick) begin // @[KnightRider.scala 38:30]
      stateReg <= _GEN_1;
    end
    ledReg <= _GEN_5[5:0]; // @[KnightRider.scala 33:{23,23}]
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
  stateReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ledReg = _RAND_1[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module KnightTop(
  input        clock,
  input        reset,
  input  [3:0] io_btn,
  output [5:0] io_led
);
  wire  knight_clock; // @[KnightRider.scala 123:22]
  wire  knight_reset; // @[KnightRider.scala 123:22]
  wire [5:0] knight_io_led; // @[KnightRider.scala 123:22]
  KnightRider knight ( // @[KnightRider.scala 123:22]
    .clock(knight_clock),
    .reset(knight_reset),
    .io_led(knight_io_led)
  );
  assign io_led = knight_io_led; // @[KnightRider.scala 125:10]
  assign knight_clock = clock;
  assign knight_reset = reset;
endmodule
