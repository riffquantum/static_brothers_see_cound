gSMidiNoteSampleList[giTomPad1Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTomPad1Note] filelen "songs/sbDrumKit/samples/punishmentAwaits.wav"
giMidiNoteInterruptList[giTomPad1Note] = 0

instr 2054 ;TomPad1, PadA11,
  iNoteVelocity = p4

  if giCurrentSong == 1 then
    iPunishmentInstrumentNumber interruptThenTrigger nstrnum("PunishmentAwaits")
    event_i "i", iPunishmentInstrumentNumber, 0, giMidiNoteDurationList[giTomPad1Note], iNoteVelocity, 4.07
  endif
endin
