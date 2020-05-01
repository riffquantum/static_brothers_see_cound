if giCurrentSong == 0 then
  gSMidiNoteSampleList[giGreenPadNote] = "songs/sbDrumKit/instruments/BirdShitSynthSamples/BirdShitSynthSample1.wav"
giMidiNoteDurationList[giGreenPadNote] = filelen(gSMidiNoteSampleList[giGreenPadNote])
elseif giCurrentSong == 1 then
  gSMidiNoteSampleList[giGreenPadNote] = "songs/sbDrumKit/samples/punishYou.wav"
  giMidiNoteDurationList[giGreenPadNote] = filelen(gSMidiNoteSampleList[giGreenPadNote]) - .75
  giMidiNoteInterruptList[giGreenPadNote] ftgen 0, 0, 0, -2, giGreenPadNote, nstrnum("PunishmentAwaits")
endif

instr 2044 ;GreenPad, PadA8,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 0 then
    ; iFrequency mtof 48
    ; event_i   "i", "BirdShitSynth", 0, 1, iAmplitude, iFrequency

    event_i   "i", "BirdShitSynthSamples", 0, 1, iAmplitude, 1
  endif
endin
