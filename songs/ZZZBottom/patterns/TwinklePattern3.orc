instr TwinklePattern3
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

      beatScoreline "DescentTwinkle", iBaseTime+0, 1/3, 70,  5.10
      beatScoreline "DescentTwinkle", iBaseTime+2/3, 1/3, 74,  6.09
      beatScoreline "DescentTwinkle", iBaseTime+4/3, 1/3, 74,  6.10
      beatScoreline "DescentTwinkle", iBaseTime+3.75, 2, 74,  5.06

    iMeasureCount += 1
  od
endin
