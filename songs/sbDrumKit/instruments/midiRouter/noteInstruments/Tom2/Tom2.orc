gSMidiNoteSampleList[giTom2Note] = "songs/sbDrumKit/samples/EA7619_R8_Tom.wav"
giMidiNoteDurationList[giTom2Note] filelen gSMidiNoteSampleList[giTom2Note]
giMidiNoteInterruptList[giTom2Note] = 0

instr 2051 ;Tom2, PadA7,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0
endin
