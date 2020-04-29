gSMidiNoteSampleList[giSnareNote] = "songs/sbDrumKit/samples/VA1108_sd.wav"
giMidiNoteDurationList[giSnareNote] filelen gSMidiNoteSampleList[giSnareNote]
giMidiNoteInterruptList[giSnareNote] = 0

instr 2036 ;Snare, PadA2,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity

  event_i "i", "Snare", 0, giMidiNoteDurationList[giSnareNote], iAmplitude

  if iNoteVelocity > 100 then
    event_i "i", "SharpSnare", 0, giMidiNoteDurationList[giSnareNote], iAmplitude
  endif
endin
