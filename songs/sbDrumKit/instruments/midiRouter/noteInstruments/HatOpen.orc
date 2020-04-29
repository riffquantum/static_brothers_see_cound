gSMidiNoteSampleList[giHatOpenNote] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giHatOpenNote] filelen gSMidiNoteSampleList[giHatOpenNote]
giMidiNoteInterruptList[giHatOpenNote] ftgen 0, 0, 0, -2, 0

instr 2055 ;HatOpen, PadA14,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch = 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  if giHatClutchIsOpen == 1 then
    event_i "i", "OpenHat", 0, giMidiNoteDurationList[giHatOpenNote], iNoteVelocity, 4.07
  else
    event_i "i", "ClosedHat", 0, giMidiNoteDurationList[giHatPedalNote], iNoteVelocity, 4.07
  endif

endin
