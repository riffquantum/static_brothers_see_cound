instr MadrinaLoop1
    iPatternLength = secondsToBeats(p3)
    iBeatsPerMeasure = 4
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "IntroLoop", iBaseTime+0, 4, 110, 1, 0

    iMeasureCount += 1
    od
endin
