gSMidiNoteSampleList[giBluePadNote] = "localSamples/chorusedGuitarStab.wav"
giMidiNoteDurationList[giBluePadNote] filelen "songs/sbDrumKit/samples/punishYou.wav"
giMidiNoteInterruptList[giBluePadNote] = 0

instr 2045 ;BluePad, PadB1,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 1 then
    interruptThenTrigger nstrnum("PunishYou"), giMidiNoteDurationList[giBluePadNote], iAmplitude
  endif
endin
