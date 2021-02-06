instr Pattern3
  $PATTERN_LOOP(8)

    ; beatScoreline "EscapePrism", iBaseTime, 3.65, 120, 5.05
    ; beatScoreline "EscapePrism3", iBaseTime+2, 2, 120, 5.07, 1, 1, 1, 1, 1, 1, 1

    beatScoreline "EscapePrism3", iBaseTime, 3.65, 120, 5.05
    ; beatScoreline "EscapePrism3", iBaseTime+4, 3.65, 120, 5.05

    ; beatScoreline "EscapePrism3", iBaseTime+0, 1, 120, 5.07
    ; beatScoreline "EscapePrism3", iBaseTime+4, 1, 120, 5.06

    ; beatScoreline "EscapePrism2", iBaseTime, 2, 120, 5.07, 1, 1, 1, 1, 1, 1, 1
    ; beatScoreline "EscapePrism", iBaseTime+4, 3.65, 120, 5.07

    ; beatScoreline "EscapePrism", iBaseTime+6, 1.65, 120, 5.06

  $END_PATTERN_LOOP
endin
