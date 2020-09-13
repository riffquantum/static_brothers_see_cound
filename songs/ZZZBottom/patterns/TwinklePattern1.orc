instr TwinklePattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    ; beatScoreline "DescentTwinkle", iBaseTime+0, .75, 100,  5.03
    ; beatScoreline "DescentTwinkle", iBaseTime+.5, 2, 100,  5.02

    beatScoreline "DescentTwinkle", iBaseTime+0, 8, 80,  3.07

    iMeasureCount += 1
  od
endin
