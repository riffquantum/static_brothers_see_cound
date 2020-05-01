gSMidiNoteSampleList[giRideNote] = "songs/sbDrumKit/samples/EA7810_R8_Ride.wav"
giMidiNoteDurationList[giRideNote] filelen gSMidiNoteSampleList[giRideNote]
giMidiNoteInterruptList[giRideNote] = 0

instr 2049 ;Ride, PadA13,
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity, 0.2

  event_i "i", "Ride", 0, giMidiNoteDurationList[giRideNote], iAmplitude
endin
