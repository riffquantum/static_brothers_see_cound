instr Pattern2
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  gkKickHelixGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(16), 0, 0, 2.1, \
    14, 2.1, \
    2, 1.3, \
    0, 2.1, \
    1.5, 4, \
    0, 2.1, \
    10.5, 2.1, \
    2, 1.25, \
    2, 1.8, \
    0 \
  )

  gkHatWarpGrainFrequencyAdjustment = 3.1

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "Snare", iBaseTime+1.05, 1, 127, 1
    beatScoreline "Snare", iBaseTime+3, 1, 127, 1
    beatScoreline "Snare", iBaseTime+5, 1, 127, 1
    beatScoreline "Snare", iBaseTime+7, 1, 127, 1

    beatScoreline "Distorted808Kick", iBaseTime, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime + 5/6, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime + 5/6, 2, 127, 1

    beatScoreline "Distorted808Kick", iBaseTime + 5, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime + 5, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime + 5 + 2/6, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime + 5 + 2/6, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime + 5 + 4/6, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime + 5 + 4/6, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime + 5 + 6/6, 2, 127, .5
    beatScoreline "DefaultKick", iBaseTime + 5 + 6/6, 2, 127, 1

    beatScoreline "AwfulCrash", iBaseTime+0, 8, 127, .25

    beatScoreline "DefaultKick", iBaseTime + 7 + 0, 2, 127, 1
    beatScoreline "DefaultKick", iBaseTime + 7 + 1/3, 2, 127, 1
    beatScoreline "DefaultKick", iBaseTime + 7 + 1/6, 2, 127, 1
    beatScoreline "DefaultKick", iBaseTime + 7 + 4/6, 2, 127, 1

    beatScoreline "KickHelix", iBaseTime+0, 4, 100, 3.05
    beatScoreline "KickHelix", iBaseTime+4, 4, 100, 3.05

    beatScoreline "HatWarp", iBaseTime, 2, 30, 3.05


    iPainSpiralPitch = 4 + (iMeasureCount % 4)/100

    iMeasureIndex += 1
  od
endin
