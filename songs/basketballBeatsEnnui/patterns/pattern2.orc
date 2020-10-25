instr pattern2
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 4
  iMeasureCount = 0

  ;beatScorelineS("KickBassKnob", p2, iPatternLength/2, "2 .01")
  ;beatScorelineS("KickMidKnob", p2, iPatternLength/2, ".01 2")
  ;beatScorelineS("KickHighKnob", p2, iPatternLength/2, ".01 2")

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    ;hats
    /*
    */
    beatScorelineS("HiHat", iBaseTime, 1, "4 1.01")
    beatScorelineS("HiHat", iBaseTime+0.5, 1, "4")
    beatScorelineS("HiHat", iBaseTime+1, 1, "2.75")
    beatScorelineS("HiHat", iBaseTime+1.5, 1, "2.5")
    beatScorelineS("HiHat", iBaseTime+2, 1, "2.75")
    beatScorelineS("HiHat", iBaseTime+2.5, 1, "2.5 1.01")
    beatScorelineS("HiHat", iBaseTime+3, 1, "2.75")
    beatScorelineS("HiHat", iBaseTime+3.5, 1, "2.5")

    if (iMeasureCount + 1) % 4 == 0 then
      beatScorelineS("HiHat", iBaseTime+2.625, 1, "2.25")
      beatScorelineS("HiHat", iBaseTime+2.75, 1, "2.35")
      beatScorelineS("HiHat", iBaseTime+2.875, 1, "2.45 1.01")
    endif


    ;Kicks
    beatScorelineS("Kick", iBaseTime, 1, "2")
    beatScorelineS("Kick", iBaseTime+0.25, 1, "2")
    beatScorelineS("Kick", iBaseTime+0.375, 1, "2.5")


    if (iMeasureCount + 1) % 4 != 3 then
      beatScorelineS("Kick", iBaseTime+2.5, 1, "2")
    endif



    ;Snares
    beatScorelineS("Snare", iBaseTime + 1, 1, "3")
    beatScorelineS("Snare", iBaseTime + 3, 1, "3")
    if (iMeasureCount + 1) % 4 == 0 then
      beatScorelineS("Snare", iBaseTime + 1.75, 1, "2.5")
    endif

    if (iMeasureCount + 1) % 4 == 2 then
      beatScorelineS("Snare", iBaseTime + 2.25, 1, "2.25")
    endif

    iMeasureCount += 1
  od
endin
