instr WithersLoop2
    iPatternLength = secondsToBeats(p3)
    iBeatsPerMeasure = 4
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "WhoIsHeLoop", iBaseTime+0, 4, 110, 1, 2.5

    iMeasureCount += 1
    od
endin
