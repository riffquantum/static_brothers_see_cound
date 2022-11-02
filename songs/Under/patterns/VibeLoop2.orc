instr VibeLoop2
  $PATTERN_LOOP(8)
    _ "VibeLine2", iBaseTime+0, 8, 100, .33, 4.98

    if iMeasureCount > 1 then
      _ "VibeLine2", iBaseTime+0, 8, 100, .33, 6
    endif

    if iMeasureCount > 2 then
      _ "VibeLine2", iBaseTime+0, 4, 100, .66, 6
    endif
    if iMeasureCount > 3 then
      _ "VibeLine2", iBaseTime+04, 4, 100, .66, 0
    endif

    ; _ "VibeRiteajqajq", iBaseTime+0, 5, 100, .5, 5

    ; _ "VibeLine2", iBaseTime+0, 2.4, 100, .5
    ; _ "VibeLine2", iBaseTime+2.35, 2.4, 100, .5
    ; _ "VibeLine2", iBaseTime+4.74, 2.4, 100, .5
    ; _ "VibeLine2", iBaseTime+7.13, .9, 100, .75

    ; _ "AjqShort", iBaseTime+0, 4, 100, .5
    ; _ "AjqShort", iBaseTime+4, 4, 100, .66

    ; _ "AjqShort2", iBaseTime, 8, 100, .25

    ; _ "AjqLoop", iBaseTime, 8, 100, 1
    if iMeasureCount > 3 then
      _ "PercLoop", iBaseTime+5, 3, 50, 2, 4
    endif
    if iMeasureCount > 2 then
      _ "PercLoop", iBaseTime, 4, 50, 1, 4
    endif
  $END_PATTERN_LOOP
endin
