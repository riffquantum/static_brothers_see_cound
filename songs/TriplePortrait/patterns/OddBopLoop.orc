instr OddBopLoop
  $PATTERN_LOOP(8)
    beatScoreline "Violin4", iBaseTime, 4, 120, .333, 0
    beatScoreline "Violin4", iBaseTime+4, 1, 120, .333, 0
    beatScoreline "Violin4", iBaseTime+5, 3, 120, .333, 0
    beatScoreline "Violin4", iBaseTime+3, 1, 120, .666, 2
    beatScoreline "Violin4", iBaseTime+7, 2, 120, .666, 2
  $END_PATTERN_LOOP
endin
