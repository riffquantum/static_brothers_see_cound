instr CloudDrift1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "CloudThoughts", iBaseTime+0.100378, 23.911716, 120, 2.010000
    beatScoreline "CloudThoughts", iBaseTime+0.100378, 23.911716, 120, 2.060000
    beatScoreline "CloudThoughts", iBaseTime+8.945729, 1.025548, 99, 3.080000
    beatScoreline "CloudThoughts", iBaseTime+9.922902, 14.048073, 99, 3.060000

    if iMeasureCount % 2 == 0 then
      beatScoreline "CloudThoughts", iBaseTime+18.267574, 16.160847, 120, 4.010000
    endif

    if iMeasureCount % 4 == 0 then
      beatScoreline "Voidlessness", iBaseTime+18.267574, 16.160847, 91, 3.060000
    endif

    iMeasureIndex += 1
  od
endin
