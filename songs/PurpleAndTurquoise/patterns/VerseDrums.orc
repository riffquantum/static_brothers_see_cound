instr VerseDrums
  $PATTERN_LOOP(8)
    if iMeasureCount % 4 == 0 then
      beatScoreline "Snare", iBaseTime+5+(2/3), 1, 60, 1
      beatScoreline "Snare", iBaseTime+7.666, 1, 40, 1
    endif

    beatScoreline "MuffledKick", iBaseTime, 2, 127, 1
    beatScoreline "MuffledKick", iBaseTime+2, 2, 127, .9
    beatScoreline "MuffledKick", iBaseTime+4, 4, 127, 1

    beatScoreline "Snare", iBaseTime+1, 1, 120, 1
    beatScoreline "Snare", iBaseTime+1.75, 1, 30, .8
    beatScoreline "Snare", iBaseTime+3, 1, 120, 1
    beatScoreline "Snare", iBaseTime+5, 1, 120, 1
    beatScoreline "Snare", iBaseTime+7, 1, 120, 1
  $END_PATTERN_LOOP
endin
