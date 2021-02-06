instr EmContent
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "Voidlessness", iBaseTime+23.880272, 6.275435, 111, 2.060000

    iMeasureIndex += 1
  od
endin
