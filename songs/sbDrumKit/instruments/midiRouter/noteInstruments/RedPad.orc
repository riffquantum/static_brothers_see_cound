gSMidiNoteSampleList[giRedPadNote] = "localSamples/dissonantStab.wav"
giMidiNoteDurationList[giRedPadNote] = 0.65
giMidiNoteInterruptList[giRedPadNote] ftgen 0, 0, 0, -2, giRedPadNote

instr 2038 ;RedPad, PadA6,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 1 then
    interruptThenTrigger nstrnum("PunishmentAwaits"), giMidiNoteDurationList[giRedPadNote], iAmplitude
  endif
endin
