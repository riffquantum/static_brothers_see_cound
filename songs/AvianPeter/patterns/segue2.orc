instr segue2
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 8
  iMeasureCount = 0
  iSampleMode = 0
  iDurationInBeats = p3*i(gkBPM)/60

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "DefaultClosedHat", iBaseTime+0, 1, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+2, 1, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+4, 1, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+6, 1, 100, 1

    iMeasureCount += 1
  od
endin
