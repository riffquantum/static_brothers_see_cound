instr Pattern2
  $PATTERN_LOOP(8)

    beatScoreline "EscapePrism3", iBaseTime+0, 1, 120, 5.07
    beatScoreline "EscapePrism3", iBaseTime+4, 1, 120, 5.06

    if iMeasureCount > 2 && iMeasureCount % 2 == 1 then
      beatScoreline "EscapePrism3", iBaseTime, 3.65, 120, 5.055
    endif

    if iMeasureCount % 4 == 0 then
      beatScoreline "EscapePrism3", iBaseTime+0, 7.895752, 120, 4.110000
    endif

    ; beatScoreline "LayeredBassSynth", iBaseTime+3.983673, 4.107997, 89, 4.03
    ; beatScoreline "LayeredBassSynth", iBaseTime+4.019471, 4.099289, 81, 4.08

  $END_PATTERN_LOOP
endin
