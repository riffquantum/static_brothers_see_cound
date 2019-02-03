gSMidiNoteSampleList[giHatPedalNote] = "songs/sbDrumKit/samples/VA1007_hh.wav"
giMidiNoteDurationList[giHatPedalNote] filelen gSMidiNoteSampleList[giHatPedalNote]
giMidiNoteInterruptList[giHatPedalNote] ftgenonce 0, 0, 0, -2, giHatOpenNote

instr HatPedal, PadB9, 2056

  kpitch = 1
  iSkipTime = 0
  iwraparound = 0
  iformat = 0
  iskipinit = 0

  aHatClosed diskin gSMidiNoteSampleList[giHatPedalNote], kpitch, iSkipTime, iwraparound, iformat, iskipinit

  out aHatClosed
endin
