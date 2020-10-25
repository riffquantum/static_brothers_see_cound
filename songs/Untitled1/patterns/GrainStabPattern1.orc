instr GrainStabPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure


    beatScoreline "GrainStab", iBaseTime+0, .75, 120, 5.01
    beatScoreline "GrainStab", iBaseTime+6.9, .8, 120, 4.02

    iMeasureCount += 1
  od
endin
