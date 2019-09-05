gSMidiNoteSampleList[giGreenPadNote] = "songs/sbDrumKit/samples/punishYou.wav"
giMidiNoteDurationList[giGreenPadNote] = filelen(gSMidiNoteSampleList[giGreenPadNote]) - .75
giMidiNoteInterruptList[giGreenPadNote] ftgen 0, 0, 0, -2, giGreenPadNote, 3001

instr 2044 ;GreenPad, PadA8,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  iPunishYouInstrumentNumber interruptThenTrigger giPunishYouInstrumentNumber

  event_i "i", iPunishYouInstrumentNumber, 0, giMidiNoteDurationList[giBluePadNote], iNoteVelocity*2, 4.07
endin
