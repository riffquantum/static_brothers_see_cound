gSMidiNoteSampleList[giOrangePadNote] = "songs/sbDrumKit/samples/EA7847_R8_Crsh.wav"
giMidiNoteDurationList[giOrangePadNote] filelen gSMidiNoteSampleList[giOrangePadNote]
giMidiNoteInterruptList[giOrangePadNote] = 0

instr 2043 ;, OrangePad, PadA12
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  event_i "i", "PitchedDownCrash", 0, giMidiNoteDurationList[giCrashNote], iAmplitude
endin
