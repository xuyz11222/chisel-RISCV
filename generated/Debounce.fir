circuit Debounce :
  module Debounce :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip btnU : UInt<1>, flip sw : UInt<8>, led : UInt<8>}

    reg btnSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btnSync_REG) @[Debounce.scala 13:38]
    btnSync_REG <= io.btnU @[Debounce.scala 13:38]
    reg btnSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btnSync) @[Debounce.scala 13:30]
    btnSync <= btnSync_REG @[Debounce.scala 13:30]
    reg tick_reg : UInt<20>, clock with :
      reset => (reset, UInt<20>("h0")) @[Debounce.scala 18:22]
    node tick = eq(tick_reg, UInt<20>("hf423f")) @[Debounce.scala 19:20]
    node _tick_reg_T = add(tick_reg, UInt<1>("h1")) @[Debounce.scala 20:31]
    node _tick_reg_T_1 = tail(_tick_reg_T, 1) @[Debounce.scala 20:31]
    node _tick_reg_T_2 = mux(tick, UInt<1>("h0"), _tick_reg_T_1) @[Debounce.scala 20:15]
    tick_reg <= _tick_reg_T_2 @[Debounce.scala 20:9]
    reg btnDeb : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btnDeb) @[Debounce.scala 35:19]
    when tick : @[Debounce.scala 36:15]
      btnDeb <= btnSync @[Debounce.scala 37:12]
    reg btnFilter_reg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Debounce.scala 25:22]
    when tick : @[Debounce.scala 26:14]
      node _btnFilter_reg_T = bits(btnFilter_reg, 1, 0) @[Debounce.scala 27:21]
      node _btnFilter_reg_T_1 = cat(_btnFilter_reg_T, btnDeb) @[Cat.scala 31:58]
      btnFilter_reg <= _btnFilter_reg_T_1 @[Debounce.scala 27:11]
    node _btnFilter_T = bits(btnFilter_reg, 2, 2) @[Debounce.scala 29:9]
    node _btnFilter_T_1 = bits(btnFilter_reg, 1, 1) @[Debounce.scala 29:18]
    node _btnFilter_T_2 = and(_btnFilter_T, _btnFilter_T_1) @[Debounce.scala 29:13]
    node _btnFilter_T_3 = bits(btnFilter_reg, 2, 2) @[Debounce.scala 29:29]
    node _btnFilter_T_4 = bits(btnFilter_reg, 0, 0) @[Debounce.scala 29:38]
    node _btnFilter_T_5 = and(_btnFilter_T_3, _btnFilter_T_4) @[Debounce.scala 29:33]
    node _btnFilter_T_6 = or(_btnFilter_T_2, _btnFilter_T_5) @[Debounce.scala 29:23]
    node _btnFilter_T_7 = bits(btnFilter_reg, 1, 1) @[Debounce.scala 29:49]
    node _btnFilter_T_8 = bits(btnFilter_reg, 0, 0) @[Debounce.scala 29:58]
    node _btnFilter_T_9 = and(_btnFilter_T_7, _btnFilter_T_8) @[Debounce.scala 29:53]
    node btnFilter = or(_btnFilter_T_6, _btnFilter_T_9) @[Debounce.scala 29:43]
    reg risingEdge_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), risingEdge_REG) @[Debounce.scala 15:37]
    risingEdge_REG <= btnFilter @[Debounce.scala 15:37]
    node _risingEdge_T = eq(risingEdge_REG, UInt<1>("h0")) @[Debounce.scala 15:29]
    node risingEdge = and(btnFilter, _risingEdge_T) @[Debounce.scala 15:27]
    reg r1 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Debounce.scala 45:19]
    when risingEdge : @[Debounce.scala 46:21]
      node _r1_T = add(r1, UInt<1>("h1")) @[Debounce.scala 47:14]
      node _r1_T_1 = tail(_r1_T, 1) @[Debounce.scala 47:14]
      r1 <= _r1_T_1 @[Debounce.scala 47:8]
    io.led <= r1 @[Debounce.scala 50:10]

