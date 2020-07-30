instr synthPattern1
  iPatternLength = p3 * i(gkBPM)/60

  iBeatsPerMeasure = 8
  iMeasureIndex = 0
  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "BigCrunchySynth", iBaseTime+0, 4, 50, 6.02
    beatScoreline "BigCrunchySynth", iBaseTime+4, 1, 50, 6.11
    beatScoreline "BigCrunchySynth", iBaseTime+5, 3, 50, 5.05

    iMeasureIndex += 1
  od
endin
