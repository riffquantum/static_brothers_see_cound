giMidiNoteInterruptList[giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("OpenHat")

instr 2056 ;HatPedal, PadB9,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giHatClutchIsOpen == 1 then
    iDuration filelen "songs/sbDrumKit/samples/VA2105_hh.wav"
    event_i "i", "ClosedHat", 0, iDuration, iAmplitude
  endif

  if giDoubleKickOn == 1 then
    iDuration filelen "songs/sbDrumKit/samples/EA7604_R8_Bd.wav"

    event_i "i", "CbKick", 0, iDuration, iAmplitude

    interruptThenTrigger nstrnum("LongDeepKick"), 0, iDuration, iAmplitude

    event_i "i", "SharpKick", 0, iDuration, iAmplitude
  endif
endin
