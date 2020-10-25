instr synthPattern1
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 8
  iMeasureIndex = 0
  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "BigCrunchySynth", iBaseTime+0, 4, 50, 2.02
    beatScoreline "BigCrunchySynth", iBaseTime+4, 1, 50, 2.11
    beatScoreline "BigCrunchySynth", iBaseTime+5, 3, 50, 1.05

    iMeasureIndex += 1
  od
endin
