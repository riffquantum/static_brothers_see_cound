instr WithersLoop1
    iPatternLength = secondsToBeats(p3)
    iBeatsPerMeasure = 4
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
      iBaseTime = iMeasureCount*iBeatsPerMeasure

      if iBaseTime != iPatternLength - 4 then
        beatScoreline "WhoIsHeLoop", iBaseTime+0, 1, 110, 1, 11
        beatScoreline "WhoIsHeLoop", iBaseTime+1, 1, 110, 1, 11
        beatScoreline "WhoIsHeLoop", iBaseTime+2, 2, 110, 1, 11
      else
        beatScoreline "WhoIsHeLoop", iBaseTime+0, 4, 110, 1, 11
      endif

      iMeasureCount += 1
    od
endin
