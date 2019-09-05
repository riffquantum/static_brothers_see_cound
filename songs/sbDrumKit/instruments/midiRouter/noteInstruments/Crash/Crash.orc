gSMidiNoteSampleList[giCrashNote] = "songs/sbDrumKit/samples/EA7815_R8_Crsh.wav"
giMidiNoteDurationList[giCrashNote] = filelen(gSMidiNoteSampleList[giCrashNote]) * 1.6666
giMidiNoteInterruptList[giCrashNote] = 0

instr 2073 ;Crash, Crash, PadA145,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =.6

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", 3012, 0, giMidiNoteDurationList[giCrashNote], iNoteVelocity*2, 4.07
endin
