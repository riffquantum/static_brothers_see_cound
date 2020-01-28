gSMidiNoteSampleList[giPadC6Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC6Note] filelen gSMidiNoteSampleList[giPadC6Note]
giMidiNoteInterruptList[giPadC6Note] = 0

instr PadC6, 2061
  prints "%n%n#######################%n%n"
  prints "Now Playing Avian Peter - 112 BPM"
  prints "%n%n#######################%n%n"
  giCurrentSong = 1
  gkBPM = 112
  giMetronomeCount = 0
  giMetronomeBeatsPerMeasure = 21
  giMetronomeAccents[] init 1
  giMetronomeAccents fillarray 1, 3, 6, 8, 11, 13, 16, 18, 19, 20, 21
endin
