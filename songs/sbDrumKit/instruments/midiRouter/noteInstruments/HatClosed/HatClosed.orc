gSMidiNoteSampleList[giHatClosedNote] = "songs/sbDrumKit/samples/VA1007_hh.wav"
giMidiNoteDurationList[giHatClosedNote] filelen gSMidiNoteSampleList[giHatClosedNote]
giMidiNoteInterruptList[giHatClosedNote] = 0

instr HatClosed, PadA10, 2047
  kpitch = 1
  iSkipTime = 0
  iwraparound = 0
  iformat = 0
  iskipinit = 0

  aHatClosed diskin gSMidiNoteSampleList[giHatClosedNote], kpitch, iSkipTime, iwraparound, iformat, iskipinit

  out aHatClosed
endin
