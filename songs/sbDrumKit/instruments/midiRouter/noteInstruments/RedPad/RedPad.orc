gSMidiNoteSampleList[giRedPadNote] = "localSamples/dissonantStab.wav"
giMidiNoteDurationList[giRedPadNote] = 0.65
giMidiNoteInterruptList[giRedPadNote] ftgen 0, 0, 0, -2, giRedPadNote

instr 2038 ;RedPad, PadA6,
  iNoteVelocity = p4

  if giCurrentSong == 1 then
    iPunishmentInstrumentNumber interruptThenTrigger nstrnum("PunishmentAwaits")
    event_i "i", iPunishmentInstrumentNumber, 0, giMidiNoteDurationList[giRedPadNote], iNoteVelocity, 4.07
  endif
endin
