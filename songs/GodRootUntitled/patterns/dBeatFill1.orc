opcode randomVariation, i, 0
  iVariation random -0.07, 0.07
  xout iVariation
endop

instr dBeatFill1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScorelineS("Kick", iBaseTime+0.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+1.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+2.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+3.0, 1, "3.3 1.01")

    beatScorelineS("Snare", iBaseTime + 0, 1, "3.3")
    beatScorelineS("Snare", iBaseTime + 1, 1, "3.3")

    beatScoreline("TomLow", iBaseTime + 2, 1, 4.2)

    beatScoreline("TomLow", iBaseTime + 3, 1, 4.2)
    ; beatScorelineS("Snare", iBaseTime + 1.333, 1, "3.3")

    ; ;beatScorelineS("Snare", iBaseTime + 2, 1, "3.2")

    ; beatScorelineS("TomMid", iBaseTime + 2, 1, "3.2")
    ; beatScorelineS("TomLow", iBaseTime + 2.5, 1, "3.2")
    ; beatScorelineS("TomLow", iBaseTime + 3.5, 1, "3.2")


    beatScorelineS("Crash", iBaseTime+0.0, 1.1, "3 .8")
    beatScorelineS("Crash", iBaseTime+1, 2, "4 .8")

    beatScorelineS("OpenHat", iBaseTime+2, 2, "2.1 .8")
    beatScorelineS("OpenHat", iBaseTime+3, 2, "2.1 .8")


    iMeasureCount += 1
  od
endin
