instr HatPattern2
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "DefaultClosedHat", iBaseTime+0, 1, 100,  1
    beatScoreline "DefaultClosedHat", iBaseTime+1/3, 1, 70,  .95
    beatScoreline "DefaultClosedHat", iBaseTime+1, 1, 100,  1.1
    beatScoreline "DefaultClosedHat", iBaseTime+1.5, 1, 70,  1
    beatScoreline "DefaultClosedHat", iBaseTime+1+5/6, 1, 70,  1.1
    beatScoreline "DefaultClosedHat", iBaseTime+2, 1, 100,  1
    beatScoreline "DefaultClosedHat", iBaseTime+7/3, 1, 70,  .95
    beatScoreline "DefaultClosedHat", iBaseTime+3, 1, 100,  1.3

    iMeasureCount += 1
  od
endin
