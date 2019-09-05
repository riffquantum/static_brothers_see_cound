gSMidiNoteSampleList[giHatPedalNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatPedalNote] filelen gSMidiNoteSampleList[giHatPedalNote]
giMidiNoteInterruptList[giHatPedalNote] ftgen 0, 0, 0, -2, giHatOpenNote, 3010

instr 2056 ;HatPedal, PadB9,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  event_i "i", 3009, 0, giMidiNoteDurationList[giHatPedalNote], iNoteVelocity*2, 4.07

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", 3002, 0, giMidiNoteDurationList[giKickNote], iNoteVelocity*2, 4.07

  event_i "i", 3003, 0, giMidiNoteDurationList[giKickNote], iNoteVelocity*2, 4.07

  event_i "i", 3004, 0, giMidiNoteDurationList[giKickNote], iNoteVelocity*2, 4.07
endin
