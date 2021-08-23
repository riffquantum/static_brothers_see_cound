opcode splitPitchClass, ii, i
  iPitch xin

  iSign = iPitch < 0 ? -1 : 1

  iPitch = abs(iPitch)
  iOctave = floor(iPitch)
  iNoteNumber = (iPitch - iOctave) * 100

  iOctave *= iSign
  iNoteNumber *= iSign

  xout iOctave, iNoteNumber
endop
