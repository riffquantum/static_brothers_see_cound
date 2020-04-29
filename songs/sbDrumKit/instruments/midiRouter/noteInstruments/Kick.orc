gSMidiNoteSampleList[giKickNote] = "songs/sbDrumKit/samples/EA7604_R8_Bd.wav"
giMidiNoteDurationList[giKickNote] filelen gSMidiNoteSampleList[giKickNote]
giMidiNoteInterruptList[giKickNote] ftgen 0, 0, 0, -2, giKickNote

instr 2082 ;Kick, PadB9,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  event_i "i", "CbKick", 0, giMidiNoteDurationList[giKickNote], iAmplitude

  interruptThenTrigger nstrnum("LongDeepKick"), 0, giMidiNoteDurationList[giKickNote], iAmplitude

  event_i "i", "SharpKick", 0, giMidiNoteDurationList[giKickNote], iAmplitude
endin
