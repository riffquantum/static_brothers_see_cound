instr Intro
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1


    beatScoreline "Distorted808Kick", iBaseTime, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime, 2, 127, 1


    beatScoreline "HatWarp", iBaseTime+2, 1.7, 100, 3.05
    beatScoreline "HatWarp", iBaseTime+7, 1.7, 100, 3.045

    beatScoreline "DefaultKick", iBaseTime+5.5, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+5.5, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime+6, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+6, 2, 127, .4

    beatScoreline "PainSpiral", iBaseTime, 12, 127, 2.01
    iMeasureIndex += 1
  od
endin
