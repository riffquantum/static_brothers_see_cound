gSMidiNoteSampleList[giTom1Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTom1Note] filelen gSMidiNoteSampleList[giTom1Note]
giMidiNoteInterruptList[giTom1Note] = 0

instr 2053 ;Tom1, PadA16,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  event_i "i", "FatTomMiddle", 0, giMidiNoteDurationList[giTom1Note], iAmplitude
endin
