instr PastelLoop
  $PATTERN_LOOP(4)
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.00
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05
  $END_PATTERN_LOOP
endin

instr PastelLoopWithFlourish
  $PATTERN_LOOP(4)
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.00
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05

    beatScoreline "AsleepBeforeDessert", iBaseTime+2, 2, 120, 4.05
    beatScoreline "AsleepBeforeDessert", iBaseTime+2, 2, 120, 5.00
  $END_PATTERN_LOOP
endin
