opcode randomVariation, i, 0
  iVariation random -0.1, 0.1
  xout iVariation
endop

instr weirdBigCymbalPattern
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 4
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScorelineS("KickBassKnob", iBaseTime, iBeatsPerMeasure, "2 .01")
    beatScorelineS("KickMidKnob", iBaseTime, iBeatsPerMeasure, ".01 2")
    beatScorelineS("KickHighKnob", iBaseTime, iBeatsPerMeasure, ".01 2")

    beatScorelineS("Kick", iBaseTime+0.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+0.5, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+1.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+1.5, 1, "2.9 1.01")
    beatScorelineS("Kick", iBaseTime+2.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+2.5, 1, "3.1 1.01")
    beatScorelineS("Kick", iBaseTime+3.0, 1, "3.3 1.01")
    beatScorelineS("Kick", iBaseTime+3.5, 1, "3.1 1.01")

    ;beatScorelineS("Snare", iBaseTime + 0.5, 1, "4")
    beatScorelineS("Snare", iBaseTime + 1, 1, "6 1.1")
    ;beatScorelineS("Snare", iBaseTime + 2.5, 1, "4 0.7")
    beatScorelineS("Snare", iBaseTime + 3, 1, "6.2 1.1")

    beatScorelineS("OpenHat", iBaseTime+0.0, 2, "2.3 .8")
    beatScorelineS("OpenHat", iBaseTime+1, 2, "2.1 .8")
    beatScorelineS("OpenHat", iBaseTime+1.5, 2, "2.2 .8")
    beatScorelineS("OpenHat", iBaseTime+2.5, 2, "1.9 .8")
    ;beatScorelineS("OpenHat", iBaseTime+3.0, 2, "2 .8")

    beatScorelineS("Crash", iBaseTime+0.0, 4, "5 .5")
    beatScorelineS("Crash", iBaseTime+2, 4, "5 1")

    iMeasureCount += 1
  od

  beatScorelineS("KickBassKnob", iPatternLength, 0.1, "1.1 1.1")
  beatScorelineS("KickMidKnob", iPatternLength, 0.1, "1 1")
  beatScorelineS("KickHighKnob", iPatternLength, 0.1, "0.9 0.9")
endin
