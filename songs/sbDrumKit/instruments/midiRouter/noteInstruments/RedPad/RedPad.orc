gSMidiNoteSampleList[giRedPadNote] = "localSamples/dissonantStab.wav"
giMidiNoteDurationList[giRedPadNote] filelen gSMidiNoteSampleList[giRedPadNote]
giMidiNoteInterruptList[giRedPadNote] ftgen 0, 0, 0, -2, giRedPadNote

instr 2038 ;RedPad, PadA6,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0
endin
