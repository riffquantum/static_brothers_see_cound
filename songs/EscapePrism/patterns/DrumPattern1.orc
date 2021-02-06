instr DrumPattern1
  $PATTERN_LOOP(8)
    beatScoreline "Snare", iBaseTime+1, 1, 127, 1
    beatScoreline "Snare", iBaseTime+3, 1, 127, 1
    beatScoreline "Snare", iBaseTime+5, 1, 127, 1
    beatScoreline "Snare", iBaseTime+7, 1, 127, 1

    beatScoreline "HatWarp", iBaseTime+0, 8, 100, 3.057, 3


    beatScoreline "Kick", iBaseTime+0, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+0, 2, 127, .5

    beatScoreline "Kick", iBaseTime+4, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4, .5, 127, .35

    beatScoreline "Kick", iBaseTime+4.5, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4.5, 2, 127, .38

    beatScoreline "Kick", iBaseTime+2.5, 2, 127, 1

    ; beatScoreline "KickHelix", iBaseTime+2, 1, 100, 2.11
    ; beatScoreline "KickHelix", iBaseTime+5, 1, 100, 2.11

  $END_PATTERN_LOOP
endin
