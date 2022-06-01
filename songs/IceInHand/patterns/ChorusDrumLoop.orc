instr ChorusDrumLoop
  $PATTERN_LOOP(4)
    ; iMeasureCount -= 2

    if iMeasureCount % 2 == 0 then
      _ "Drums", i0, 4, 120, 4.0, 1, .5, 1.5, .7, 1
      _ "Snare", i0+.95, 1, 60, 1
      _ "Snare", i0+1.9, 1, 60, 1
    elseif iMeasureCount % 8 == 7 then
      _ "Drums", i0, 1.75, 120, 4.0, 1, .5, 1.5, .7, 1
      _ "Drums", i0+2, 1.75, 120, 4.0, 1, .5, 1.5, 1, 1
      _ "Snare", i0+.95, 1, 60, 1
      _ "Snare", i0+2.875, 1, 60, 1
    elseif iMeasureCount % 4 == 3 then
      _ "Drums", i0, 1.75, 120, 4.0, 1, .5, 1.5, .7, 1
      _ "Drums", i0+2, 1.75, 120, 4.0, 1, .5, 1.5, .7, .9
      _ "Snare", i0+.95, 1, 60, 1
      _ "Snare", i0+2.875, 1, 60, 1
    else
      _ "Drums", i0, 1.75, 120, 4.0, 1, .5, 1.5, .7, 1
      _ "Drums", i0+2, 1.75, 120, 4.0, 1, .5, 1.5, .7, 1
      _ "Snare", i0+.95, 1, 60, 1
      _ "Snare", i0+2.875, 1, 60, 1
    endif

    _ "Kick", i0+0.00, 1, 100, 1

    if iMeasureCount % 8 == 0 then
      _ "Kick", i0+0.25, 1, 80, 1
    endif

    ; if iMeasureCount % 6 == 0 then
    ;   _ "Kick", i0+1.50, 1, 100, 1
    ;   _ "Kick", i0+1.75, 1, 100, 1
    ; else
    ;   _ "Kick", i0+1.0, 1, 100, 1
    ;   _ "Kick", i0+1.25, 1, 100, 1
    ; endif

    if iMeasureCount % 4 == 0 then
      _ "Kick", i0+2.00, 1, 100, 1
    else
      _ "Kick", i0+2.25, 1, 100, 1
    endif

    ; _ "Kick", i0+3.00, 1, 100, 1

    if iMeasureCount % 6 == 4 then
      _ "Kick", i0+3.25, 1, 100, 1
    endif
  $END_PATTERN_LOOP
endin
