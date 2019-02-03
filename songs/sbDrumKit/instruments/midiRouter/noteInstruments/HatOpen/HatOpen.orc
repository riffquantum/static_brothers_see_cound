;gSMidiNoteSampleList[giHatOpenNote] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
gSMidiNoteSampleList[giHatOpenNote] = "localSamples/blueangel5.wav"
giMidiNoteDurationList[giHatOpenNote] filelen gSMidiNoteSampleList[giHatOpenNote]
giMidiNoteInterruptList[giHatOpenNote] ftgenonce 0, 0, 0, -2, giHatOpenNote

instr HatOpen, PadA14, 2055
  iLengthOfSample filelen gSMidiNoteSampleList[giHatOpenNote]

  kpitch = 1
  iSkipTime = 0
  iwraparound = 0
  iformat = 0
  iskipinit = 0

  aHatOpenL, aHatOpenR diskin gSMidiNoteSampleList[giHatOpenNote], kpitch, iSkipTime, iwraparound, iformat, iskipinit

  out aHatOpenR + aHatOpenL

endin
