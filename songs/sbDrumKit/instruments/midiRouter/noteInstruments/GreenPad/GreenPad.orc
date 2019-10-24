gSMidiNoteSampleList[giGreenPadNote] = "songs/sbDrumKit/samples/punishYou.wav"
giMidiNoteDurationList[giGreenPadNote] = filelen(gSMidiNoteSampleList[giGreenPadNote]) - .75
giMidiNoteInterruptList[giGreenPadNote] ftgen 0, 0, 0, -2, giGreenPadNote, nstrnum("PunishmentAwaits")

instr 2044 ;GreenPad, PadA8,
  iNoteVelocity = p4

  if giCurrentSong == 0 then
    iFrequency mtof 48
    event_i   "i", "BirdShitSynth", 0, 1, velocityToAmplitude(iNoteVelocity), iFrequency
  endif
endin
