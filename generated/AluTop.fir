circuit AluTop :
  module Alu :
    input clock : Clock
    input reset : Reset
    output io : { flip fn : UInt<2>, flip a : UInt<4>, flip b : UInt<4>, result : UInt<4>}

    wire result : UInt<4> @[Alu.scala 28:20]
    result <= UInt<1>("h0") @[Alu.scala 30:10]
    node _T = eq(UInt<1>("h0"), io.fn) @[Alu.scala 33:14]
    when _T : @[Alu.scala 33:14]
      node _result_T = add(io.a, io.b) @[Alu.scala 34:27]
      node _result_T_1 = tail(_result_T, 1) @[Alu.scala 34:27]
      result <= _result_T_1 @[Alu.scala 34:22]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.fn) @[Alu.scala 33:14]
      when _T_1 : @[Alu.scala 33:14]
        node _result_T_2 = sub(io.a, io.b) @[Alu.scala 35:27]
        node _result_T_3 = tail(_result_T_2, 1) @[Alu.scala 35:27]
        result <= _result_T_3 @[Alu.scala 35:22]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.fn) @[Alu.scala 33:14]
        when _T_2 : @[Alu.scala 33:14]
          node _result_T_4 = or(io.a, io.b) @[Alu.scala 36:27]
          result <= _result_T_4 @[Alu.scala 36:22]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.fn) @[Alu.scala 33:14]
          when _T_3 : @[Alu.scala 33:14]
            node _result_T_5 = and(io.a, io.b) @[Alu.scala 37:27]
            result <= _result_T_5 @[Alu.scala 37:22]
    io.result <= result @[Alu.scala 41:13]

  module AluTop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sw : UInt<10>, led : UInt<10>}

    inst alu of Alu @[Alu.scala 54:19]
    alu.clock <= clock
    alu.reset <= reset
    node _alu_io_fn_T = bits(io.sw, 1, 0) @[Alu.scala 57:21]
    alu.io.fn <= _alu_io_fn_T @[Alu.scala 57:13]
    node _alu_io_a_T = bits(io.sw, 5, 2) @[Alu.scala 58:20]
    alu.io.a <= _alu_io_a_T @[Alu.scala 58:12]
    node _alu_io_b_T = bits(io.sw, 9, 6) @[Alu.scala 59:20]
    alu.io.b <= _alu_io_b_T @[Alu.scala 59:12]
    io.led <= alu.io.result @[Alu.scala 62:10]

