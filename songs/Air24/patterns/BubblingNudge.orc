instr BubblingNudge
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "BreezeNudge", iBaseTime+0, 1.361754, 89, 1.020000
    beatScoreline "BreezeNudge", iBaseTime+1.886621, 1.889040, 73, 1.020000
    beatScoreline "BreezeNudge", iBaseTime+6.061376, 1.325472, 99, 1.020000
    beatScoreline "BreezeNudge", iBaseTime+7.955253, 1.494785, 89, 1.020000
    beatScoreline "BreezeNudge", iBaseTime+13.102343, 1.547997, 111, 1.020000

    iMeasureIndex += 1
  od
endin
