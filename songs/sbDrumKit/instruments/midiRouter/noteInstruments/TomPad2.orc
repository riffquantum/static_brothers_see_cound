gSMidiNoteSampleList[giTomPad2Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTomPad2Note] filelen gSMidiNoteSampleList[giTomPad2Note]
giMidiNoteInterruptList[giTomPad2Note] = 0

instr 2046 ;TomPad2, PadA11,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  if giCurrentSong == 0 then
    iFrequency mtof 51
    event_i   "i", "BirdShitSynth", 0, 1, iAmplitude, iFrequency
  endif

endin
