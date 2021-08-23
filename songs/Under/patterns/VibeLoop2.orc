instr VibeLoop2
  $PATTERN_LOOP(8)
    beatScoreline "VibeLine2", iBaseTime+0, 8, 100, .33, 4.98

    if iMeasureCount > 1 then
      beatScoreline "VibeLine2", iBaseTime+0, 8, 100, .33, 6
    endif

    if iMeasureCount > 2 then
      beatScoreline "VibeLine2", iBaseTime+0, 4, 100, .66, 6
    endif
    if iMeasureCount > 3 then
      beatScoreline "VibeLine2", iBaseTime+04, 4, 100, .66, 0
    endif

    ; beatScoreline "VibeRiteajqajq", iBaseTime+0, 5, 100, .5, 5

    ; beatScoreline "VibeLine2", iBaseTime+0, 2.4, 100, .5
    ; beatScoreline "VibeLine2", iBaseTime+2.35, 2.4, 100, .5
    ; beatScoreline "VibeLine2", iBaseTime+4.74, 2.4, 100, .5
    ; beatScoreline "VibeLine2", iBaseTime+7.13, .9, 100, .75

    ; beatScoreline "AjqShort", iBaseTime+0, 4, 100, .5
    ; beatScoreline "AjqShort", iBaseTime+4, 4, 100, .66

    ; beatScoreline "AjqShort2", iBaseTime, 8, 100, .25

    ; beatScoreline "AjqLoop", iBaseTime, 8, 100, 1
    if iMeasureCount > 3 then
      beatScoreline "PercLoop", iBaseTime+5, 3, 50, 2, 4
    endif
    if iMeasureCount > 2 then
      beatScoreline "PercLoop", iBaseTime, 4, 50, 1, 4
    endif
  $END_PATTERN_LOOP
endin
