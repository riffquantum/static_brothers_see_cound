gSMidiNoteSampleList[giBluePadNote] = "localSamples/chorusedGuitarStab.wav"
giMidiNoteDurationList[giBluePadNote] filelen "songs/sbDrumKit/samples/punishmentAwaits.wav"
giMidiNoteInterruptList[giBluePadNote] ftgen 0, 0, 0, -2, giPunishYouInstrumentNumber

instr 2045 ;BluePad, PadB1,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch = 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  iPunishmentInstrumentNumber interruptThenTrigger 3001

  event_i "i", iPunishmentInstrumentNumber, 0, giMidiNoteDurationList[giBluePadNote], iNoteVelocity*2, 4.07
endin
