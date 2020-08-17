instr SuddenlyLoop1
    iPatternLength = p3 * i(gkBPM)/60
    iBeatsPerMeasure = 4
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "Suddenly", iBaseTime+0, 4, 110, 2, 2


    if iMeasureCount % 4 < 2 then
      beatScoreline "Suddenly", iBaseTime+0.5, .5, 110, 2 * 3/4, 2
      beatScoreline "Suddenly", iBaseTime+1.5, .5, 110, 2 * 3/4, 3.25
    else
      beatScoreline "Suddenly", iBaseTime+0, 1, 110, 1, 2
    endif



    iMeasureCount += 1
    od
endin
