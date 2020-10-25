instr VersePattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  gkHatWarpGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(32), 0, 0, 1, \
    14, 1, \
    2, 1.3, \
    0, 1, \
    12, 1, \
    2, .75, \
    2, 1.8, \
    0 \
  )

  gkKickHelixGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(32), 0, 0, 1, \
    14, 1, \
    2, 1.3, \
    0, 1, \
    1.5, 4, \
    0, 1, \
    10.5, 1, \
    2, 1.25, \
    2, 1.8, \
    0 \
  )

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    ; beatScoreline "PitchedDownCrash", iBaseTime+0, 8, 127, 1
    ; beatScoreline "AwfulCrash", iBaseTime+0.25, 8, 127, .95
    ; beatScoreline "AwfulCrash", iBaseTime+0.5, 8, 127, .95

    beatScoreline "Snare", iBaseTime+1.05, 1, 127, 1
    beatScoreline "Snare", iBaseTime+3, 1, 127, 1
    beatScoreline "Snare", iBaseTime+5, 1, 127, 1
    beatScoreline "Snare", iBaseTime+7, 1, 127, 1

    beatScoreline "Distorted808Kick", iBaseTime, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime, 2, 127, 1
    beatScoreline "DefaultKick", iBaseTime+3.5, 2, 127, 1
    beatScoreline "DefaultKick", iBaseTime+4, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4, 2, 127, .4
    beatScoreline "Distorted808Kick", iBaseTime+3.5, 2, 127, .5

    beatScoreline "KickHelix", iBaseTime+0, 4, 100, 3.05
    beatScoreline "KickHelix", iBaseTime+4, 4, 100, 3.05
    ; beatScoreline "KickHelix", iBaseTime+8, 4, 120, 3.05
    ; beatScoreline "KickHelix", iBaseTime+12, 4, 120, 3.05

    beatScoreline "HatWarp", iBaseTime, iBeatsPerMeasure, 100, 3.05

    if iMeasureCount % 4 == 3 then
      beatScoreline "HatWarp", iBaseTime, iBeatsPerMeasure, 40, 2.05
      ; beatScoreline "DelayForSnare", iBaseTime+5, 1
    endif
    if iMeasureCount % 4 == 0 then
      beatScoreline "HatWarp", iBaseTime, iBeatsPerMeasure, 40, 1.05
      ; beatScoreline "DelayForSnare", iBaseTime+5, 1
    endif

    beatScoreline "PainSpiral", iBaseTime+0.0, 2.5, 120, 2.06
    beatScoreline "PainSpiral", iBaseTime+0.0, 2.5, 120, 4.06

    beatScoreline "PainSpiral", iBaseTime+3, 5, 127, 2.01
    ; beatScoreline "PainSpiral", iBaseTime+7, 2, 120, 4.06
    iMeasureIndex += 1
  od
endin
