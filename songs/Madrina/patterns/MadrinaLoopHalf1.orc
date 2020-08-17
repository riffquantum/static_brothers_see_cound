instr MadrinaLoopHalf1
    iPatternLength = p3 * i(gkBPM)/60
    iBeatsPerMeasure = 4
    iMeasureCount = 0

    until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "IntroLoop", iBaseTime+0, 2, 110, 1, 0
    beatScoreline "IntroLoop", iBaseTime+2, 2.25, 110, 1, 0

    iMeasureCount += 1
    od
endin
