instr bassPattern1
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 8
  iMeasureIndex = 0
  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "BassPluck", iBaseTime+0, 1, 60, 2.04
    beatScoreline "BassPluck", iBaseTime+1, 3, 60, 2.02
      beatScoreline "BassPluck", iBaseTime+4, 1, 70, 2.07

    if iMeasureCount % 4 == 2 then
      beatScoreline "BassPluck", iBaseTime+5, 1, 70, 2.05
      beatScoreline "BassPluck", iBaseTime+6, 2, 70, 2.04
    else
      beatScoreline "BassPluck", iBaseTime+5, 3, 70, 2.05
    endif

    if iMeasureCount % 4 == 3 then
      beatScoreline "BassPluck", iBaseTime+5, .5, 60, 4.09
      beatScoreline "BassPluck", iBaseTime+5.5, 1, 60, 4.11
      beatScoreline "BassPluck", iBaseTime+6.5, .5, 60, 4.09
      beatScoreline "BassPluck", iBaseTime+7, 1, 60, 4.07
    endif

    iMeasureIndex += 1
  od
endin
