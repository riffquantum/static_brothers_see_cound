instr TwinkleMelodyShort
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    if iMeasureCount % 2 == 0 then
      beatScoreline "DescentTwinkle", iBaseTime+-.05, .69, 70,  5.03
      beatScoreline "DescentTwinkle", iBaseTime+.69, 3.25, 70,  5.02
      beatScoreline "DescentTwinkle", iBaseTime+3.92, 4, 70,  4.06
    else
      beatScoreline "DescentTwinkle", iBaseTime+-.05, .69, 70,  5.03
      beatScoreline "DescentTwinkle", iBaseTime+.69, 1.24, 70,  5.02
      beatScoreline "DescentTwinkle", iBaseTime+1.92, 1.92, 70,  4.02
      beatScoreline "DescentTwinkle", iBaseTime+3.92, 4, 70,  4.06
    endif

    iMeasureCount += 1
  od
endin
