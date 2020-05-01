giMidiNoteInterruptList[giKickNote] = 0

instr 2082 ;Kick, PadB9,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity
  iDuration filelen "songs/sbDrumKit/samples/EA7604_R8_Bd.wav"

  event_i "i", "CbKick", 0, iDuration, iAmplitude

  interruptThenTrigger nstrnum("LongDeepKick"), 0, iDuration, iAmplitude

  event_i "i", "SharpKick", 0, iDuration, iAmplitude
endin
