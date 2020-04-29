gSMidiNoteSampleList[giHatClosedNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatClosedNote] filelen gSMidiNoteSampleList[giHatClosedNote]
giMidiNoteInterruptList[giHatClosedNote] = 0

instr 2047 ;HatClosed, PadA10,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  event_i "i", "ClosedHat", 0, giMidiNoteDurationList[giHatClosedNote], iAmplitude
endin
