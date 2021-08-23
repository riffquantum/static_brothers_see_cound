opcode integerNoteToPitchClass, i, io
  iIntegerNote, iDivisions xin

  iDivisions = iDivisions == 0 ? giDivisionsInTuningSystem : iDivisions

  iOctave = floor(iIntegerNote/iDivisions)
  iNoteNumber = (iIntegerNote % giDivisionsInTuningSystem)/100
  iPitch = iOctave + iNoteNumber

  xout iPitch
endop
