instr VibeLoop
  $PATTERN_LOOP(8)
    ; _ "VibeLine", iBaseTime+0, 8, 100, .5
    ; repeatNotes("ClosedHat", iBaseTime, 8, 2, .5, 50, 1)



    if iMeasureCount % 2 == 0 then
      _ "VibeLine", iBaseTime+0, 8, 100, .5
    else
      ; _ "VibeLine2", iBaseTime+0, 1, 100, .5, 3
      _ "VibeLine", iBaseTime+0, 4, 100, .5
      _ "VibeLine", iBaseTime+4, 4, 100, .5, 2
    endif

    if iMeasureCount % 4 == 3 then
      _ "VibeLine", iBaseTime+4, 4, 100, .25, 4
      _ "VibeLine", iBaseTime+7.5, .5, 100, 1
    endif
  $END_PATTERN_LOOP
endin
