instr OffBreeze
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "BreezeNudge", iBaseTime+2.165986, 3.889342, 53, 3.020000
    beatScoreline "BreezeNudge", iBaseTime+5.960998, 8.126984, 107, 2.030000
    beatScoreline "BreezeNudge", iBaseTime+14.032351, 8.221315, 89, 2.010000

    iMeasureIndex += 1
  od
endin
