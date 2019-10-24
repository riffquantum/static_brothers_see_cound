gSMidiNoteSampleList[giTom1Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTom1Note] filelen gSMidiNoteSampleList[giTom1Note]
giMidiNoteInterruptList[giTom1Note] = 0

instr 2053 ;Tom1, PadA16,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", "FatTomMiddle", 0, giMidiNoteDurationList[giTom1Note], iNoteVelocity, 4.07
endin
