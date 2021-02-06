instr Clatter
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "TwistedUpHatExample", iBaseTime+0.108844, 0.530189, 20, 2.030000
    beatScoreline "TwistedUpHatExample", iBaseTime+0.577113, 0.355072, 20, 2.100000
    beatScoreline "TwistedUpHatExample", iBaseTime+11, .4, 20, 3.010000

    iMeasureIndex += 1
  od
endin
