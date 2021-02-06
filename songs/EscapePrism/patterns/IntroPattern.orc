instr IntroPattern
  $PATTERN_LOOP(8)
    beatScoreline "EscapePrism2", iBaseTime, 2, 120, 5.07, 1, 1, 1, 1, 1, 1, 1

    if iMeasureCount > 1 then
      beatScoreline "EscapePrism", iBaseTime+4, 3.65, 120, 5.07
    endif
    if iMeasureCount > 3 then
      beatScoreline "EscapePrism", iBaseTime+6, 1.65, 120, 5.06
    endif

  $END_PATTERN_LOOP
endin
