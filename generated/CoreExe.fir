circuit CoreExe :
  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip op : UInt<10>, flip data1 : UInt<32>, flip data2 : UInt<32>, result : UInt<32>}

    wire result : UInt<32> @[Alu.scala 16:20]
    result <= UInt<1>("h0") @[Alu.scala 17:10]
    io.result <= result @[Alu.scala 18:14]
    node op_add = bits(io.op, 0, 0) @[Alu.scala 20:19]
    node op_sub = bits(io.op, 1, 1) @[Alu.scala 21:19]
    node op_slt = bits(io.op, 2, 2) @[Alu.scala 22:19]
    node op_sltu = bits(io.op, 3, 3) @[Alu.scala 23:19]
    node op_and = bits(io.op, 4, 4) @[Alu.scala 24:19]
    node op_or = bits(io.op, 5, 5) @[Alu.scala 25:19]
    node op_xor = bits(io.op, 6, 6) @[Alu.scala 26:19]
    node op_sll = bits(io.op, 7, 7) @[Alu.scala 27:19]
    node op_srl = bits(io.op, 8, 8) @[Alu.scala 28:19]
    node op_sra = bits(io.op, 9, 9) @[Alu.scala 29:19]
    node _adder_b_T = or(op_sub, op_slt) @[Alu.scala 32:32]
    node _adder_b_T_1 = or(_adder_b_T, op_sltu) @[Alu.scala 32:42]
    node _adder_b_T_2 = not(io.data2) @[Alu.scala 32:55]
    node adder_b = mux(_adder_b_T_1, _adder_b_T_2, io.data2) @[Alu.scala 32:24]
    node _adder_cin_T = or(op_sub, op_slt) @[Alu.scala 33:32]
    node _adder_cin_T_1 = or(_adder_cin_T, op_sltu) @[Alu.scala 33:42]
    node adder_cin = mux(_adder_cin_T_1, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 33:24]
    wire adder_cout_result : UInt<33> @[Alu.scala 34:30]
    node _adder_cout_result_T = add(io.data1, adder_b) @[Alu.scala 35:32]
    node _adder_cout_result_T_1 = tail(_adder_cout_result_T, 1) @[Alu.scala 35:32]
    node _adder_cout_result_T_2 = add(_adder_cout_result_T_1, adder_cin) @[Alu.scala 35:42]
    node _adder_cout_result_T_3 = tail(_adder_cout_result_T_2, 1) @[Alu.scala 35:42]
    adder_cout_result <= _adder_cout_result_T_3 @[Alu.scala 35:21]
    node adder_cout = bits(adder_cout_result, 32, 32) @[Alu.scala 37:39]
    node add_sub_result = bits(adder_cout_result, 31, 0) @[Alu.scala 38:39]
    node _slt_result_T = bits(io.data1, 31, 31) @[Alu.scala 41:31]
    node _slt_result_T_1 = bits(io.data2, 31, 31) @[Alu.scala 41:45]
    node _slt_result_T_2 = not(_slt_result_T_1) @[Alu.scala 41:39]
    node _slt_result_T_3 = and(_slt_result_T, _slt_result_T_2) @[Alu.scala 41:36]
    node _slt_result_T_4 = bits(io.data1, 31, 31) @[Alu.scala 42:35]
    node _slt_result_T_5 = bits(io.data2, 31, 31) @[Alu.scala 42:49]
    node _slt_result_T_6 = eq(_slt_result_T_4, _slt_result_T_5) @[Alu.scala 42:40]
    node _slt_result_T_7 = bits(add_sub_result, 31, 31) @[Alu.scala 42:70]
    node _slt_result_T_8 = and(_slt_result_T_6, _slt_result_T_7) @[Alu.scala 42:55]
    node _slt_result_T_9 = or(_slt_result_T_3, _slt_result_T_8) @[Alu.scala 42:25]
    node slt_result = cat(UInt<31>("h0"), _slt_result_T_9) @[Cat.scala 31:58]
    node _sltu_result_T = not(adder_cout) @[Alu.scala 43:37]
    node sltu_result = cat(UInt<31>("h0"), _sltu_result_T) @[Cat.scala 31:58]
    node and_result = and(io.data1, io.data2) @[Alu.scala 44:26]
    node or_result = or(io.data1, io.data2) @[Alu.scala 45:26]
    node xor_result = xor(io.data1, io.data2) @[Alu.scala 46:26]
    node _sll_result_T = bits(io.data2, 4, 0) @[Alu.scala 47:34]
    node sll_result = dshl(io.data1, _sll_result_T) @[Alu.scala 47:26]
    node _data1_64_T = bits(io.data1, 31, 31) @[Alu.scala 48:45]
    node _data1_64_T_1 = and(op_sra, _data1_64_T) @[Alu.scala 48:38]
    node _data1_64_T_2 = bits(_data1_64_T_1, 0, 0) @[Bitwise.scala 74:15]
    node _data1_64_T_3 = mux(_data1_64_T_2, UInt<32>("hffffffff"), UInt<32>("h0")) @[Bitwise.scala 74:12]
    node data1_64 = cat(_data1_64_T_3, io.data1) @[Cat.scala 31:58]
    node _sr64_result_T = bits(io.data2, 4, 0) @[Alu.scala 49:37]
    node sr64_result = dshr(data1_64, _sr64_result_T) @[Alu.scala 49:29]
    node sr_result = bits(sr64_result, 31, 0) @[Alu.scala 50:32]
    node _T = eq(UInt<1>("h1"), io.op) @[Alu.scala 52:13]
    when _T : @[Alu.scala 52:13]
      result <= add_sub_result @[Alu.scala 53:20]
    else :
      node _T_1 = eq(UInt<2>("h2"), io.op) @[Alu.scala 52:13]
      when _T_1 : @[Alu.scala 52:13]
        result <= add_sub_result @[Alu.scala 54:20]
      else :
        node _T_2 = eq(UInt<3>("h4"), io.op) @[Alu.scala 52:13]
        when _T_2 : @[Alu.scala 52:13]
          result <= slt_result @[Alu.scala 55:20]
        else :
          node _T_3 = eq(UInt<4>("h8"), io.op) @[Alu.scala 52:13]
          when _T_3 : @[Alu.scala 52:13]
            result <= sltu_result @[Alu.scala 56:20]
          else :
            node _T_4 = eq(UInt<5>("h10"), io.op) @[Alu.scala 52:13]
            when _T_4 : @[Alu.scala 52:13]
              result <= and_result @[Alu.scala 57:21]
            else :
              node _T_5 = eq(UInt<6>("h20"), io.op) @[Alu.scala 52:13]
              when _T_5 : @[Alu.scala 52:13]
                result <= or_result @[Alu.scala 58:21]
              else :
                node _T_6 = eq(UInt<7>("h40"), io.op) @[Alu.scala 52:13]
                when _T_6 : @[Alu.scala 52:13]
                  result <= xor_result @[Alu.scala 59:21]
                else :
                  node _T_7 = eq(UInt<8>("h80"), io.op) @[Alu.scala 52:13]
                  when _T_7 : @[Alu.scala 52:13]
                    result <= sll_result @[Alu.scala 60:22]
                  else :
                    node _T_8 = eq(UInt<9>("h100"), io.op) @[Alu.scala 52:13]
                    when _T_8 : @[Alu.scala 52:13]
                      result <= sr_result @[Alu.scala 61:22]
                    else :
                      node _T_9 = eq(UInt<10>("h200"), io.op) @[Alu.scala 52:13]
                      when _T_9 : @[Alu.scala 52:13]
                        result <= sr_result @[Alu.scala 62:22]

  module CoreExe :
    input clock : Clock
    input reset : UInt<1>
    output io : { Mem : { flip MemReady : UInt<1>, Result : UInt<32>, Rd : UInt<5>}, flip Id : { AluOp : UInt<10>, Data1 : UInt<32>, Data2 : UInt<32>, MmuEn : UInt<1>, MmuWen : UInt<1>, MmuOp : UInt<5>, MmuRData2 : UInt<32>, Rd : UInt<5>, flip ExeReady : UInt<1>}}

    inst ALU of ALU @[Core_exe.scala 19:21]
    ALU.clock <= clock
    ALU.reset <= reset
    reg Result : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Core_exe.scala 28:27]
    reg Rd_r : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Core_exe.scala 29:27]
    ALU.io.op <= io.Id.AluOp @[Core_exe.scala 31:17]
    ALU.io.data1 <= io.Id.Data1 @[Core_exe.scala 32:17]
    ALU.io.data2 <= io.Id.Data2 @[Core_exe.scala 33:17]
    io.Mem.Result <= Result @[Core_exe.scala 35:19]
    io.Mem.Rd <= Rd_r @[Core_exe.scala 36:19]
    io.Id.ExeReady <= io.Mem.MemReady @[Core_exe.scala 37:19]
    when io.Mem.MemReady : @[Core_exe.scala 39:19]
      Result <= ALU.io.result @[Core_exe.scala 40:16]
      Rd_r <= io.Id.Rd @[Core_exe.scala 41:16]
    else :
      Result <= Result @[Core_exe.scala 44:15]
      Rd_r <= Rd_r @[Core_exe.scala 45:15]

