instr VerseElectronicDrums
  $PATTERN_LOOP(4)
    _ "CloserKick", i0, 1, 100, 1
    _ "CloserKick", i0+2, 1, 100, 1
    _ "CloserKick", i0+3.5, 1, 100, 1
    _ "CloserKick", i0+4, 1, 100, 1

    _ "FalseHat", i0+0.5, 1, 100, .99
    _ "FalseHat", i0+1.5, 1, 100, 1
    _ "FalseHat", i0+1.75, 1, 100, 5/3
    _ "FalseHat", i0+2.5, 1, 100, 1
    _ "FalseHat", i0+3.5, 1, 100, 1
    _ "FalseHat", i0+3.75, 1, 100, 5/3
  $END_PATTERN_LOOP

  $PATTERN_LOOP(8)
    _ "CloserSnare", i0+6, 1, 100, .75
  $END_PATTERN_LOOP

  $PATTERN_LOOP(16)
    if iMeasureCount % 4 == 2 then
      _ "CloserKick", i0+14.25, .25, 100, 1
      _ "CloserKick", i0+14.5, .25, 100, 1
      ; _ "CloserKick", i0+14.75, .25, 100, 1
      _ "CloserKick", i0+15.00, .25, 100, 1
    else
      _ "CloserKick", i0+15, 1, 100, 1
    endif
  $END_PATTERN_LOOP
endin

instr Verse808s
  $PATTERN_LOOP(16)
    _ "Dist808", i0, 4, 120, .5
    ; _ "Dist808", i0+3, 4, 120, .5
    ; _ "Dist808", i0+4, 4, 120, .5
    _ "Dist808", i0+15, 4, 120, .5
  $END_PATTERN_LOOP
endin

instr VerseKickHelix
  $PATTERN_LOOP(16)
    _ "KickHelix", i0, 16, 40, 5.04, (iMeasureCount % 4) + 1
    _ "KickHelix2", i0, 16, 20, 7.04, (iMeasureCount % 4) + 3, 4
  $END_PATTERN_LOOP
endin

