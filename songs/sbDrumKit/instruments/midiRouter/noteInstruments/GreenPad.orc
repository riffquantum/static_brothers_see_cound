giMidiNoteInterruptList[giGreenPadNote] = 0

instr 2044 ;GreenPad, PadA8,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 0 then
    ; iFrequency mtof 48
    ; event_i   "i", "BirdShitSynth", 0, 1, iAmplitude, iFrequency

    iDuration = filelen("songs/sbDrumKit/instruments/BirdShitSynthSamples/BirdShitSynthSample1.wav")

    event_i   "i", "BirdShitSynthSamples", 0, iDuration, iAmplitude, 1
  endif
endin
