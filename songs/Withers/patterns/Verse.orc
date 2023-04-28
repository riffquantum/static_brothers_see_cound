instr Verse
  gkWhoIsHeLoopPan = 60

  $PATTERN_LOOP(37)
    _ "DrumLoop1", i0, 31
    _ "VerseLoop1", i0, 28

    _ "WhoIsHeLoop", i0+8, 2, 110, 4/7, 3

    _ "WhoIsHeLoop", i0+24, 2, 110, 4/7, 3

    _ "WhoIsHeLoop", i0+20, 2, 110, 3/7, 3

    _ "VerseTurnAround", i0+28, 9


    if iMeasureCount % 2 == 1 then
      _ "WhoIsHeLoopMelody", i0+0, 2, 110, 1, 6
      _ "WhoIsHeLoopMelody", i0+1.9, 2.1, 110, 1, 6
      ; _ "WhoPitchShifter", i0+1.9, 2.1, 9/8
      ; _ "WhoWarp", i0+1.9, 2.1, 9/8, 1
      _ "WhoMince", i0+1.9, 2.1, 9/8, 1
      ; _ "HatTrill", i0+1.5, 4
    endif

    if iMeasureCount % 3 == 2 then
      _ "WhoIsHeLoop", i0+0, 2, 110, 5/9, 2.5
      _ "WhoIsHeLoop", i0+4, 4, 127, 4/7, 0
    endif
  $END_PATTERN_LOOP
endin
