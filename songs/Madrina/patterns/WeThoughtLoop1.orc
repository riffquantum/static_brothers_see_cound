instr WeThoughtLoop1
    iPatternLength = p3 * i(gkBPM)/60
    iBeatsPerMeasure = 4
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "WeThought", iBaseTime, 2, 110, 1, .5
    beatScoreline "WeThought", iBaseTime+2, 2, 110, 1, 1.5

    if iMeasureCount % 4 < 2 then
      beatScoreline "WeThought", iBaseTime, .5, 110, 2/3, .5
    else
      beatScoreline "WeThought", iBaseTime, .25, 110, 3/2, .5
    endif

    iMeasureCount += 1
    od
endin
