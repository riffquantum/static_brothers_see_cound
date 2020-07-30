instr drumPattern1
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 21
  iMeasureCount = 0
  iSampleMode = 0
  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "drumFigure1", iBaseTime+0, 15

    beatScoreline "drumFigure2", iBaseTime+15, 6

    iMeasureCount += 1
  od
endin
