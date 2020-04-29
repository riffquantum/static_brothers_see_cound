gSMidiNoteSampleList[giHatPedalNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatPedalNote] filelen gSMidiNoteSampleList[giHatPedalNote]
giMidiNoteInterruptList[giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("OpenHat")

instr 2056 ;HatPedal, PadB9,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giHatClutchIsOpen == 1 then
    event_i "i", "ClosedHat", 0, giMidiNoteDurationList[giHatPedalNote], iAmplitude
  endif

  if giDoubleKickOn == 1 then
    event_i "i", "CbKick", 0, giMidiNoteDurationList[giKickNote], iAmplitude

    interruptThenTrigger nstrnum("LongDeepKick"), 0, giMidiNoteDurationList[giKickNote], iAmplitude

    event_i "i", "SharpKick", 0, giMidiNoteDurationList[giKickNote], iAmplitude
  endif
endin
