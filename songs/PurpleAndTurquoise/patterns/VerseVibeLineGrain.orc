instr VibeLineGrain
  $PATTERN_LOOP(8)
    if iMeasureCount % 4 == 0 then
      beatScoreline "VibeLineGrain", iBaseTime, 8, 150, 2.05
      beatScoreline "VibeLineGrain", iBaseTime, 8.25, 80, 3.05, 0.001
    else
      beatScoreline "VibeLineGrain", iBaseTime, 4, 150, 3.07, (iMeasureCount % 4 == 3 ? 14 : 0), 0, (iMeasureCount % 16 >= 13 ? .1 : 0)
      beatScoreline "VibeLineGrain", iBaseTime+4, 4, 150, 3.05, 0, 0, (iMeasureCount % 16 >= 13 ? .1 : 0)
    endif
  $END_PATTERN_LOOP
endin
