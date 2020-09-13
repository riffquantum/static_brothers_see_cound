instr DrumPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  gkItsOnlyLoveGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(32), 0, 0, 1, \
    14, 1, \
    2, 1.3, \
    0, 1, \
    14, 1, \
    2, 1.8, \
    0 \
  )

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "ItsOnlyLove", iBaseTime+0, iBeatsPerMeasure, 100,  3.09


    beatScoreline "ClosedHat", iBaseTime+0, 1, 100,  1.1
    beatScoreline "ClosedHat", iBaseTime+.25, 1, 60,  1.1
    beatScoreline "ClosedHat", iBaseTime+.5, 1, 60,  1.1
    beatScoreline "OpenHat", iBaseTime+1.333, 4, 50,  1.1 - iMeasureCount/1000

    beatScoreline "Kick", iBaseTime+0, 1, 100,  1.1

    if iMeasureCount % 4 == 2 then
      beatScoreline "Kick", iBaseTime+.25, 1, 80,  1
    endif

    if iMeasureCount % 8 == 6 then
      beatScoreline "Kick", iBaseTime+.5, 1, 100,  1.1

      beatScoreline "Kick", iBaseTime+3+6/8, 1, 100,  .8
      beatScoreline "Kick", iBaseTime+3+7/8, 1, 90,  1
    endif

    beatScoreline "Kick", iBaseTime+2, 1, 100,  1.1
    beatScoreline "Kick", iBaseTime+2.25, 1, 100,  1.1
    beatScoreline "Kick", iBaseTime+2.5, 1, 100,  1.1
    beatScoreline "Kick", iBaseTime+3, 1, 100,  1.1

    beatScoreline "ClosedHat", iBaseTime+2.25, 1, 80,  1.2
    beatScoreline "ClosedHat", iBaseTime+3.25, 1, 100,  1.15
    beatScoreline "OpenHat", iBaseTime+3, 4, 50,  1.1 - 1.08 - iMeasureCount/800


    iMeasureCount += 1
  od
endin
