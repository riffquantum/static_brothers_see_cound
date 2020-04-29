gSMidiNoteSampleList[giHatPedalNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatPedalNote] filelen gSMidiNoteSampleList[giHatPedalNote]
giMidiNoteInterruptList[giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("OpenHat")

instr 2056 ;HatPedal, PadB9,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch = 1
  if giHatClutchIsOpen == 1 then
    event_i "i", "ClosedHat", 0, giMidiNoteDurationList[giHatPedalNote], iNoteVelocity, 4.07
  endif

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  if giDoubleKickOn == 1 then
    event_i "i", "CbKick", 0, giMidiNoteDurationList[giKickNote], iNoteVelocity, 4.07

    ;event_i "i", "LongDeepKick", 0, giMidiNoteDurationList[giKickNote], iNoteVelocity, 4.07

    ;event_i "i", "SharpKick", 0, giMidiNoteDurationList[giKickNote], iNoteVelocity, 4.07
  endif
endin
