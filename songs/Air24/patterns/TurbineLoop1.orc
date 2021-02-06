instr TurbineLoop1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "MachineSickness", iBaseTime+0, 24, 115, 2.060000
    beatScoreline "MachineSickness", iBaseTime+4, 1, 35, 3.10
    beatScoreline "MachineSickness", iBaseTime+5, 6, 35, 4.000000
    beatScoreline "MachineSickness", iBaseTime+16, 8, 91, 3.060000

    iMeasureIndex += 1
  od
endin
