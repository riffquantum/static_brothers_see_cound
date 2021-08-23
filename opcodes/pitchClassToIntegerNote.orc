opcode pitchClassToIntegerNote, i, io
  iPitch, iDivisions xin

  iDivisions = iDivisions == 0 ? giDivisionsInTuningSystem : iDivisions

  iOctave, iNoteNumber splitPitchClass iPitch

  iIntegerNote = (iOctave * iDivisions) + iNoteNumber

  xout iIntegerNote
endop
