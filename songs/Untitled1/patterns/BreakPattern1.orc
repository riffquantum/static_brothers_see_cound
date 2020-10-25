instr BreakPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "JbShoutBreak", iBaseTime+0, iBeatsPerMeasure/2, 127, 1, 0
    beatScoreline "JbShoutBreak", iBaseTime+iBeatsPerMeasure/2, iBeatsPerMeasure/2, 127, 1, 0

    iMeasureCount += 1
  od
endin
