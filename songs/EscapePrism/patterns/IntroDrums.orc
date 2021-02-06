instr IntroDrums
  $PATTERN_LOOP(8)
    beatScoreline "HatWarp", iBaseTime+0, 8, 50, 3.05, .5

    beatScoreline "Kick", iBaseTime+0, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+0, 2, 127, .5

    beatScoreline "Kick", iBaseTime+4, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4, .5, 127, .35

    beatScoreline "Kick", iBaseTime+4.5, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4.5, 2, 127, .38
  $END_PATTERN_LOOP
endin
