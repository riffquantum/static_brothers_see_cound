if giCurrentSong == 0 then
  gSMidiNoteSampleList[giGreenPadNote] = "songs/sbDrumKit/instruments/BirdShitSynthSamples/BirdShitSynthSample1.wav"
  giMidiNoteDurationList[giGreenPadNote] = filelen(gSMidiNoteSampleList[giGreenPadNote])
elseif giCurrentSong == 1 then
  gSMidiNoteSampleList[giTomPad2Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
  giMidiNoteDurationList[giTomPad2Note] filelen gSMidiNoteSampleList[giTomPad2Note]
  giMidiNoteInterruptList[giTomPad2Note] = 0
endif

instr 2046 ;TomPad2, PadA11,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 0 then
    ; iFrequency mtof 51
    ; event_i   "i", "BirdShitSynth", 0, 1, iAmplitude, iFrequency

    event_i   "i", "BirdShitSynthSamples", 0, 1, iAmplitude, 2
  endif

endin
