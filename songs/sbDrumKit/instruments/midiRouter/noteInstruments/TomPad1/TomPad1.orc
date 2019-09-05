gSMidiNoteSampleList[giTomPad1Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTomPad1Note] filelen gSMidiNoteSampleList[giTomPad1Note]
giMidiNoteInterruptList[giTomPad1Note] = 0

instr 2054 ;TomPad1, PadA11,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", 3014, 0, giMidiNoteDurationList[giTom2Note], iNoteVelocity*2, 4.07
endin
