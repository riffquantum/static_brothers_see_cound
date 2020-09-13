 instr BassLine1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "Distorted808Kick", iBaseTime+0, 1, 120, .5
    beatScoreline "BassTone", iBaseTime+0, 1.5, 80, 3.01


    if iMeasureCount % 2 == 0 then
      beatScoreline "BassTone", iBaseTime+2, 1.5, 100, 2.09
      beatScoreline "Distorted808Kick", iBaseTime+3.5, 2, 120, .75
      beatScoreline "Distorted808Kick", iBaseTime+4, 2, 120, .8125
      beatScoreline "BassTone", iBaseTime+3.5, 4, 100, 2.04
    else
      beatScoreline "BassTone", iBaseTime+2, 1.5, 100, 2.07
      beatScoreline "Distorted808Kick", iBaseTime+3.5, 2, 120, .6
      beatScoreline "Distorted808Kick", iBaseTime+4, 2, 120, .7625
      beatScoreline "BassTone", iBaseTime+3.5, 4, 100, 2.03
    endif


    iMeasureCount += 1
  od
endin
