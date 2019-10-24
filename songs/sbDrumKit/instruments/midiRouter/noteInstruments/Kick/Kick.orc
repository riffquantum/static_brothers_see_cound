gSMidiNoteSampleList[giKickNote] = "songs/sbDrumKit/samples/EA7604_R8_Bd.wav"
giMidiNoteDurationList[giKickNote] filelen gSMidiNoteSampleList[giKickNote]
giMidiNoteInterruptList[giKickNote] ftgen 0, 0, 0, -2, giKickNote

instr 2082 ;Kick, PadB9,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", "CbKick", 0, giMidiNoteDurationList[giKickNote], iNoteVelocity, 4.07

  event_i "i", "LongDeepKick", 0, giMidiNoteDurationList[giKickNote], iNoteVelocity, 4.07

  event_i "i", "SharpKick", 0, giMidiNoteDurationList[giKickNote], iNoteVelocity, 4.07
endin
