instr Twinkle2CounterMelodyShort
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "DescentTwinkle2", iBaseTime, 2, 70,  4.02
    beatScoreline "DescentTwinkle2", iBaseTime+2.05, 2, 70,  4.05
    beatScoreline "DescentTwinkle2", iBaseTime+4, 4, 70,  3.02

    iMeasureCount += 1
  od
endin
