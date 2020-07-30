instr dBeat
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 4
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    iMaxVariation = iMeasureCount/100 * 0

    iKickParams[] fillarray 90, 1.01

    beatScorelineA("Kick", iBaseTime+0.0+randomVariation(iMaxVariation), 1, iKickParams)
    beatScorelineA("Kick", iBaseTime+0.75+randomVariation(iMaxVariation), 1, iKickParams)
    beatScorelineS("Kick", iBaseTime+1.25+randomVariation(iMaxVariation), 1, "90 1.01")
    beatScorelineA("Kick", iBaseTime+2.0+randomVariation(iMaxVariation), 1, iKickParams)
    beatScorelineA("Kick", iBaseTime+2.75+randomVariation(iMaxVariation), 1, iKickParams)
    beatScorelineS("Kick", iBaseTime+3.25+randomVariation(iMaxVariation), 1, "90 1.01")

    beatScorelineS("Snare", iBaseTime + 0.5+randomVariation(iMaxVariation), 1, "100")
    beatScorelineS("Snare", iBaseTime + 1.5+randomVariation(iMaxVariation), 1, "98")
    beatScorelineS("Snare", iBaseTime + 2.5+randomVariation(iMaxVariation), 1, "100")
    beatScorelineS("Snare", iBaseTime + 3.5+randomVariation(iMaxVariation), 1, "98")

    beatScorelineS("OpenHat", iBaseTime+0.0+randomVariation(iMaxVariation), 2, "60 1")
    beatScorelineS("OpenHat", iBaseTime+0.5+randomVariation(iMaxVariation), 2, "50 1.01")
    beatScorelineS("OpenHat", iBaseTime+0.75+randomVariation(iMaxVariation), 2, "55 .99")
    beatScorelineS("OpenHat", iBaseTime+1.25+randomVariation(iMaxVariation), 2, "40 1")
    beatScorelineS("OpenHat", iBaseTime+1.5+randomVariation(iMaxVariation), 2, "45 .994")
    beatScorelineS("OpenHat", iBaseTime+2.0+randomVariation(iMaxVariation), 2, "60 1")
    beatScorelineS("OpenHat", iBaseTime+2.5+randomVariation(iMaxVariation), 2, "50 1.01")
    beatScorelineS("OpenHat", iBaseTime+2.75+randomVariation(iMaxVariation), 2, "55 .99")
    beatScorelineS("OpenHat", iBaseTime+3.25+randomVariation(iMaxVariation), 2, "40 1")
    beatScorelineS("OpenHat", iBaseTime+3.5+randomVariation(iMaxVariation), 2, "45 .994")

    iMeasureCount += 1
  od
endin
