instr Melody1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "MmmMmm", iBaseTime+2, .9, 100, 2
    beatScoreline "MmmMmm", iBaseTime+2, 1.8, 100, 1

    iMeasureCount += 1
  od
endin
