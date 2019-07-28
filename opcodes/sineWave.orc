;sineWave

opcode sineWave, i, 0
  iSineTable ftgenonce 0, 0, 16384, 10, 1

  xout iSineTable
endop
