instr BassLineVerse
  beatScoreline "BassSynthChorus", 0, -1
  beatScoreline "BassSynthDelay", 0, -1

  $PATTERN_LOOP(16)
    if iMeasureCount % 4 != 3 then
      beatScoreline "BassSynth", iBaseTime+0, 7, 80, 1.110000
      beatScoreline "BassSynth", iBaseTime+8, 7, 50, 1.090000

      if iMeasureCount % 2 != 0 then
        beatScoreline "BassSynth", iBaseTime+13.171398, 0.189630, 76, 1.060000
        beatScoreline "BassSynth", iBaseTime+13.388118, 0.154800, 70, 1.110000
        beatScoreline "BassSynth", iBaseTime+13.621285, 0.262192, 52, 2.060000
        beatScoreline "BassSynth", iBaseTime+13.914437, 0.216720, 67, 2.090000
      endif
    else
      beatScoreline "BassSynth", iBaseTime+0, 7, 80, 1.070000
      beatScoreline "BassSynth", iBaseTime+8, 4, 80, 1.040000
      beatScoreline "BassSynth", iBaseTime+12, 3, 80, 1.060000
    endif
  $END_PATTERN_LOOP
endin
