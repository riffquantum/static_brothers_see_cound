/* Return an Amplitude from input value or MIDI input. Explicit input will pass through unaltered, MIDI velocity will be processed and passed through. */

opcode flexibleAmplitudeInput, i, i
  iAmplitude xin

  if iAmplitude == 0 then
    iNoteVelocity veloc
    iAmplitude = velocityToAmplitude(iNoteVelocity)
  endif

  xout iAmplitude
endop
