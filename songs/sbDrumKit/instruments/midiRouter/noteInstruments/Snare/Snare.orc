gSMidiNoteSampleList[giSnareNote] = "songs/sbDrumKit/samples/VA1108_sd.wav"
giMidiNoteDurationList[giSnareNote] filelen gSMidiNoteSampleList[giSnareNote]
giMidiNoteInterruptList[giSnareNote] = 0

instr 2036 ;Snare, PadA2,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", "Snare", 0, giMidiNoteDurationList[giSnareNote], iNoteVelocity, 4.07

  if iNoteVelocity > 100 then
    event_i "i", "SharpSnare", 0, giMidiNoteDurationList[giSnareNote], iNoteVelocity*4, 4.07
  endif
endin
