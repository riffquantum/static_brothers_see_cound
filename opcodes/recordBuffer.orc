opcode recordBuffer, 0, ia
  iBufferTable, aInput xin

  iWriteTableLength = ftlen(iBufferTable)
  iTableLenInSeconds = iWriteTableLength/sr
  kIndex = (1/(iWriteTableLength/sr))
  aIndex phasor kIndex
  tablew   aInput, aIndex, iBufferTable, 1, 0, 1
endop
