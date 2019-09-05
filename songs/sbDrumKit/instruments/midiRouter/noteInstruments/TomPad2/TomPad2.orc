gSMidiNoteSampleList[giTomPad2Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTomPad2Note] filelen gSMidiNoteSampleList[giTomPad2Note]
giMidiNoteInterruptList[giTomPad2Note] = 0

instr 2046 ;TomPad2, PadA11,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

endin
