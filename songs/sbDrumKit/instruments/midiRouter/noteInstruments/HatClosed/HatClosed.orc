gSMidiNoteSampleList[giHatClosedNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatClosedNote] filelen gSMidiNoteSampleList[giHatClosedNote]
giMidiNoteInterruptList[giHatClosedNote] = 0

instr 2047 ;HatClosed, PadA10,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", 3009, 0, giMidiNoteDurationList[giHatClosedNote], iNoteVelocity*2, 4.07
endin
