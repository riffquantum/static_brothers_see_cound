gSMidiNoteSampleList[giHatOpenNote] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giHatOpenNote] filelen gSMidiNoteSampleList[giHatOpenNote]
giMidiNoteInterruptList[giHatOpenNote] ftgen 0, 0, 0, -2, 0

instr 2055 ;HatOpen, PadA14,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giHatClutchIsOpen == 1 then
    event_i "i", "OpenHat", 0, giMidiNoteDurationList[giHatOpenNote], iAmplitude
  else
    event_i "i", "ClosedHat", 0, giMidiNoteDurationList[giHatPedalNote], iAmplitude
  endif
endin
