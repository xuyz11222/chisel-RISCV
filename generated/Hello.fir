circuit Hello :
  module Hello :
    input clock : Clock
    input reset : UInt<1>
    output io : { led : UInt<1>}

    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[water_led.scala 14:22]
    reg blkReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[water_led.scala 15:22]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[water_led.scala 17:17]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[water_led.scala 17:17]
    cntReg <= _cntReg_T_1 @[water_led.scala 17:8]
    node _T = eq(cntReg, UInt<25>("h17d783f")) @[water_led.scala 18:13]
    when _T : @[water_led.scala 18:25]
      cntReg <= UInt<1>("h0") @[water_led.scala 19:12]
      node _blkReg_T = not(blkReg) @[water_led.scala 20:15]
      blkReg <= _blkReg_T @[water_led.scala 20:12]
    io.led <= blkReg @[water_led.scala 23:8]

