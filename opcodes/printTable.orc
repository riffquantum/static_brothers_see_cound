opcode printTable, i, i
  iTable xin
  iTableLength ftlen iTable

  prints "%nFunction Table %d:%n", iTable

  iIndex init 0
  loop:
    ival table iIndex, iTable
    prints    "Index %d = %f%n", iIndex, ival
  loop_lt   iIndex, 1, iTableLength, loop

  xout iTable
endop
