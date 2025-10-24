instr MainLoop
  $PATTERN_LOOP(4)
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.05
  $END_PATTERN_LOOP
endin

instr MainLoopC
  $PATTERN_LOOP(4)
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.00
  $END_PATTERN_LOOP
endin

instr MainLoopCLow
  $PATTERN_LOOP(4)
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.00
  $END_PATTERN_LOOP
endin

instr MainLoop2
  $PATTERN_LOOP(4)
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.05
    beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05
  $END_PATTERN_LOOP
endin
