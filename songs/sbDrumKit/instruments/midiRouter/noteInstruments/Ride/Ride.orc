gSMidiNoteSampleList[giRideNote] = "songs/sbDrumKit/samples/EA7810_R8_Ride.wav"
giMidiNoteDurationList[giRideNote] filelen gSMidiNoteSampleList[giRideNote]
giMidiNoteInterruptList[giRideNote] = 0

instr 2049 ;Ride, PadA13,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  event_i "i", 3011, 0, giMidiNoteDurationList[giRideNote], iNoteVelocity*2, 4.07
endin
