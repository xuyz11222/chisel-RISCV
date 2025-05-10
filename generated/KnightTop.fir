circuit KnightTop :
  module ResetGen :
    input clock : Clock
    input reset : Reset
    output io : { resetOut : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (UInt<1>("h0"), cnt) @[KnightRider.scala 92:16]
    node _T = neq(cnt, UInt<4>("hf")) @[KnightRider.scala 94:12]
    when _T : @[KnightRider.scala 94:22]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[KnightRider.scala 95:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[KnightRider.scala 95:16]
      cnt <= _cnt_T_1 @[KnightRider.scala 95:9]
      io.resetOut <= UInt<1>("h1") @[KnightRider.scala 96:17]
    else :
      cnt <= cnt @[KnightRider.scala 98:9]
      io.resetOut <= UInt<1>("h0") @[KnightRider.scala 99:17]

  module Tick :
    input clock : Clock
    input reset : Reset
    output io : { tick : UInt<1>}

    reg r1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[KnightRider.scala 66:19]
    node limit = eq(r1, UInt<23>("h7f2814")) @[KnightRider.scala 68:18]
    node _r1_T = add(r1, UInt<1>("h1")) @[KnightRider.scala 71:12]
    node _r1_T_1 = tail(_r1_T, 1) @[KnightRider.scala 71:12]
    r1 <= _r1_T_1 @[KnightRider.scala 71:6]
    when limit : @[KnightRider.scala 72:15]
      r1 <= UInt<1>("h0") @[KnightRider.scala 73:8]
    io.tick <= limit @[KnightRider.scala 76:11]

  module KnightRider :
    input clock : Clock
    input reset : Reset
    output io : { led : UInt<6>}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[KnightRider.scala 32:25]
    reg ledReg : UInt<6>, clock with :
      reset => (reset, UInt<6>("h1")) @[KnightRider.scala 33:23]
    inst tick of Tick @[KnightRider.scala 35:20]
    tick.clock <= clock
    tick.reset <= reset
    node _T = eq(tick.io.tick, UInt<1>("h1")) @[KnightRider.scala 38:21]
    when _T : @[KnightRider.scala 38:30]
      node _T_1 = bits(ledReg, 4, 4) @[KnightRider.scala 41:16]
      node _T_2 = eq(_T_1, UInt<1>("h1")) @[KnightRider.scala 41:20]
      when _T_2 : @[KnightRider.scala 41:29]
        stateReg <= UInt<1>("h1") @[KnightRider.scala 42:16]
      else :
        node _T_3 = bits(ledReg, 1, 1) @[KnightRider.scala 43:22]
        node _T_4 = eq(_T_3, UInt<1>("h1")) @[KnightRider.scala 43:26]
        when _T_4 : @[KnightRider.scala 43:35]
          stateReg <= UInt<1>("h0") @[KnightRider.scala 44:16]
      node _T_5 = eq(stateReg, UInt<1>("h0")) @[KnightRider.scala 47:19]
      when _T_5 : @[KnightRider.scala 47:31]
        node _ledReg_T = shl(ledReg, 1) @[KnightRider.scala 48:24]
        ledReg <= _ledReg_T @[KnightRider.scala 48:14]
      else :
        node _ledReg_T_1 = shr(ledReg, 1) @[KnightRider.scala 50:24]
        ledReg <= _ledReg_T_1 @[KnightRider.scala 50:14]
    io.led <= ledReg @[KnightRider.scala 54:10]

  module KnightTop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip btn : UInt<4>, led : UInt<6>}

    node _manReset_T = bits(io.btn, 3, 3) @[KnightRider.scala 114:26]
    node _manReset_T_1 = not(_manReset_T) @[KnightRider.scala 114:19]
    node manReset = bits(_manReset_T_1, 0, 0) @[KnightRider.scala 114:31]
    reg syncBtn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncBtn_REG) @[KnightRider.scala 115:32]
    syncBtn_REG <= manReset @[KnightRider.scala 115:32]
    reg syncBtn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncBtn) @[KnightRider.scala 115:24]
    syncBtn <= syncBtn_REG @[KnightRider.scala 115:24]
    inst resGen of ResetGen @[KnightRider.scala 117:22]
    resGen.clock <= clock
    resGen.reset <= reset
    node resetVal = or(syncBtn, resGen.io.resetOut) @[KnightRider.scala 120:26]
    inst knight of KnightRider @[KnightRider.scala 123:22]
    knight.clock <= clock
    knight.reset <= reset
    io.led <= knight.io.led @[KnightRider.scala 125:10]

