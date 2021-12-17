instr VerseBass
  $PATTERN_LOOP(8)
    beatScoreline "BassSynth", iBaseTime, 4, 100, 2.00

    if iMeasureCount % 4 == 0 then
      beatScoreline "BassSynth", iBaseTime+4, 4, 80, 1.04
      beatScoreline "BassSynth", iBaseTime+4, 4, 80, 2.04
    else
      beatScoreline "BassSynth", iBaseTime+4, 4, 100, 1.043.05, 0, 0, (iMeasureCount % 16 >= 13 ? .1 : 0)
    endif
  $END_PATTERN_LOOP
endin
