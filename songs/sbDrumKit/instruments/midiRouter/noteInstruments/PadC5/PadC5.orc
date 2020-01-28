gSMidiNoteSampleList[giPadC5Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC5Note] filelen gSMidiNoteSampleList[giPadC5Note]
giMidiNoteInterruptList[giPadC5Note] = 0

instr PadC5, 2060
  prints "%n%n#######################%n%n"
  prints "Now Playing Birdshit - 140 BPM"
  prints "%n%n#######################%n%n"
  giCurrentSong = 0
  gkBPM = 140
  giMetronomeCount = 0
  giMetronomeBeatsPerMeasure = 4
  giMetronomeAccents[] init 1
  giMetronomeAccents fillarray 1
endin
