/* Return an Amplitude from input value or MIDI input. Explicit input will pass through unaltered, MIDI velocity will be processed and passed through. */

opcode flexibleAmplitudeInput, i, i
  iAmplitude xin

  if iAmplitude == 0 then
    iNoteVelocity veloc
    iAmplitude = iNoteVelocity/127 * 0dbfs/10
  endif

  xout iAmplitude
endop
