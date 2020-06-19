/* Return an Amplitude from input value or MIDI input. Explicit input will pass through unaltered, MIDI velocity will be processed and passed through. */

opcode flexibleAmplitudeInput, i, ip
  iAmplitude, iCurveDegree xin

  if iAmplitude == 0 then
    iNoteVelocity veloc
    iAmplitude = velocityToAmplitude(iNoteVelocity, iCurveDegree)
  else
    iAmplitude = velocityToAmplitude(iAmplitude, iCurveDegree)
  endif

  xout iAmplitude
endop
