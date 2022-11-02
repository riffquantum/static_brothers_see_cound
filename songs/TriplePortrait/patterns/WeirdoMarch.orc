instr WeirdoMarch
  $PATTERN_LOOP(4)
    beatScoreline "Violin1", iBaseTime, 2, 120, 1, 4
    beatScoreline "Violin1", iBaseTime+2, 2, 120, 1, 4
    iMeasureCount += 1
  $END_PATTERN_LOOP
endin
