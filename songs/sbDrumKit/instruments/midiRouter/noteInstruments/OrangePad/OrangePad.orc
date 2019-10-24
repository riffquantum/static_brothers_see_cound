gSMidiNoteSampleList[giOrangePadNote] = "songs/sbDrumKit/samples/EA7847_R8_Crsh.wav"
giMidiNoteDurationList[giOrangePadNote] filelen gSMidiNoteSampleList[giOrangePadNote]
giMidiNoteInterruptList[giOrangePadNote] = 0

instr 2043 ;, OrangePad, PadA12
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", "PitchedDownCrash", 0, giMidiNoteDurationList[giCrashNote], iNoteVelocity, 4.07
endin
