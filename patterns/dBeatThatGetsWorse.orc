instr dBeatThatGetsWorse
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    iMaxVariation = iMeasureCount/100

    iKickParams[] fillarray 3.3, 1.01

    beatScorelineA("Kick", iBaseTime+0.0+randomVariation(iMaxVariation), 1, iKickParams)
    beatScorelineA("Kick", iBaseTime+1.5+randomVariation(iMaxVariation), 1, iKickParams)
    beatScorelineS("Kick", iBaseTime+2.5+randomVariation(iMaxVariation), 1, "3.1 1.01")
    beatScorelineS("Snare", iBaseTime + 1+randomVariation(iMaxVariation), 1, "3.3")
    beatScorelineS("Snare", iBaseTime + 3+randomVariation(iMaxVariation), 1, "3.2")

    beatScorelineS("OpenHat1", iBaseTime+0.0+randomVariation(iMaxVariation), 2, "2.3 1")
    beatScorelineS("OpenHat1", iBaseTime+1+randomVariation(iMaxVariation), 2, "2.1 1.01")
    beatScorelineS("OpenHat1", iBaseTime+1.5+randomVariation(iMaxVariation), 2, "2.2 .99")
    beatScorelineS("OpenHat1", iBaseTime+2.5+randomVariation(iMaxVariation), 2, "1.8 1")
    beatScorelineS("OpenHat1", iBaseTime+3.0+randomVariation(iMaxVariation), 2, "2 .994")

    iMeasureCount += 1
  od
endin
