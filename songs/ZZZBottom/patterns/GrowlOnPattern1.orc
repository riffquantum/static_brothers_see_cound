instr GrowlOnPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "GrowlOn", iBaseTime+0, 2, 100,  2.02
    beatScoreline "GrowlOn", iBaseTime+2, 1, 100,  2.01

    iMeasureCount += 1
  od
endin
