giMidiNoteInterruptList[giTomPad2Note] = 0

instr 2046 ;TomPad2, PadA11,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 0 then
    ; iFrequency mtof 51
    ; event_i   "i", "BirdShitSynth", 0, 1, iAmplitude, iFrequency

    iDuration = filelen("songs/sbDrumKit/instruments/BirdShitSynthSamples/BirdShitSynthSample2.wav")
    event_i   "i", "BirdShitSynthSamples", 0, iDuration, iAmplitude, 2
  endif

endin
