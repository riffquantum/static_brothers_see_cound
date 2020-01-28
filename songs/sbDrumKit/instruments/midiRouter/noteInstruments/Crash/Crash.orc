gSMidiNoteSampleList[giCrashNote] = "songs/sbDrumKit/samples/EA7815_R8_Crsh.wav"
giMidiNoteDurationList[giCrashNote] = filelen(gSMidiNoteSampleList[giCrashNote]) * 1.6666
giMidiNoteInterruptList[giCrashNote] = 0
giTriggerDecayTimes[giCrashNote] = 2.831474

instr 2073 ;Crash, Crash, PadA145,
  iNoteVelocity = p4

  event_i "i", "Crash", 0, giMidiNoteDurationList[giCrashNote], iNoteVelocity, 4.07

  skipNote:
endin
