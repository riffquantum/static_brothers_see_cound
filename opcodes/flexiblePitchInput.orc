/* Return a frequency input value or MIDI input. Explicit input can accept numerical pitches (e.g. 6.01) or Hz values (e.g. 261.1). */

opcode flexiblePitchInput, i, i
  iPitch xin

  if iPitch != 0 && iPitch < 15 then
    iFrequency equalTempermentFrequency floor(iPitch), (iPitch - floor(iPitch)) * 100
  elseif iPitch > 15 then
    iFrequency = iPitch
  else
    iNoteNumber notnum
    iFrequency equalTempermentMidiTuning iNoteNumber
  endif

  xout iFrequency
endop
