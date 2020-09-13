instr TwinkleMelodyLong
  iPatternLength = secondsToBeats(p3)
  iMelodyVariation = p4
  iBeatsPerMeasure = 16
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    if iMelodyVariation % 2 == 0 then
      beatScoreline "DescentTwinkle", iBaseTime+-.05, .69, 70,  5.03
      beatScoreline "DescentTwinkle", iBaseTime+.69, 3.25, 70,  5.02
      beatScoreline "DescentTwinkle", iBaseTime+3.92, 4, 70,  4.06
    else
      beatScoreline "DescentTwinkle", iBaseTime+-.05, .69, 70,  5.03
      beatScoreline "DescentTwinkle", iBaseTime+.69, 1.24, 40,  5.06
      beatScoreline "DescentTwinkle", iBaseTime+.69, 1.24, 70,  5.02
      beatScoreline "DescentTwinkle", iBaseTime+1.92, 1.92, 70,  4.02
      beatScoreline "DescentTwinkle", iBaseTime+3.92, 4, 70,  4.06
    endif

    beatScoreline "DescentTwinkle", iBaseTime+7.95, 2, 70,  4.09
    beatScoreline "DescentTwinkle", iBaseTime+10, 2, 70,  4.02
    beatScoreline "DescentTwinkle", iBaseTime+12, 4, 70,  4.06

    iMeasureCount += 1
  od
endin
