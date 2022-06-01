instr VerseLoop
  ; _ "PianoInterrupt", 4, 10

  $PATTERN_LOOP(16)
    if iMeasureIndex % 2 == 1 then
      ; beatScoreline("Crash", iBaseTime+0.00, 0.5, 20, 1)
      _ "IcemanLoop", i0+4, 16, 120, 3/7, 4
    endif

    _ "IcemanLoop", i0, 16, 120, 1/3, 4
    ; _ "IcemanLoop", i0, 8, 120,  1, 4
    ; _ "IcemanLoop", i0+8, 8, 120,  1, 4
  $END_PATTERN_LOOP

  $PATTERN_LOOP(8)
    if iMeasureCount % 2 == 1 then
      _ "Stab", i0, .5, 40, 2.08
      _ "Stab", i0+6, .5, 40, 3.08
    else
      _ "Stab", i0, .5, 40, 1.08
      _ "IcemanLoop", i0, 2.5, 80, 1/3, 8
    endif

    if iMeasureCount % 4 == 3 then
      _ "Stab", i0+0.5, .5, 40, 2.08
    endif
  $END_PATTERN_LOOP

  $PATTERN_LOOP(4)
    if iMeasureCount % 2 == 0 then
      _ "IcemanLoop", i0, 3.5, 120, 2/3, 8
    else
      ; _ "IcemanLoop", i0, 1, 120, 4/3, 8
      ; _ "IcemanLoop", i0+2, 1, 120, 3.66/3, 8
    endif
  $END_PATTERN_LOOP
endin
