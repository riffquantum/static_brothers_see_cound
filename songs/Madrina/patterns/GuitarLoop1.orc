instr GuitarLoop1
    iPatternLength = secondsToBeats(p3)
    iBeatsPerMeasure = 8
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    iLastMeasure = iBaseTime == iPatternLength - iBeatsPerMeasure ? 1 : 0

    beatScoreline "Guitar", iBaseTime+0, 1, 110, 3/2
    beatScoreline "Guitar", iBaseTime+0, 8, 110, 1

    beatScoreline "Guitar", iBaseTime+3, 1, 110, 3/2, 4

    beatScoreline "Guitar", iBaseTime+4, .5, 120, 6/2, 0


    if (iLastMeasure != 1) then
      beatScoreline "Guitar", iBaseTime+6, 2, 110, 2, 4
      beatScoreline "Guitar", iBaseTime+7, 1, 110, 7/3, 4
      beatScoreline "Guitar", iBaseTime+7.75, .5, 110, 4/3, 4
    endif

    iMeasureCount += 1
    od
endin
