/* Return a frequency input value or MIDI input. Explicit input can accept numerical pitches (e.g. 6.01) or Hz values (e.g. 261.1). */

opcode flexiblePitchInput, i, i
  iPitch xin

  if iPitch != 0 then
    iFrequency = (iPitch < 15 ? cpspch(iPitch) : iPitch)
  else
    iFrequency cpsmidi
  endif

  xout iFrequency
endop
