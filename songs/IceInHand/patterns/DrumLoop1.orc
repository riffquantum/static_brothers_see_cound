instr DrumLoop1
  $PATTERN_LOOP(4)
    _ "Kick", i0+0.00, 1, 120, 1
    _ "Kick", i0+0.25, 1, 120, 1
    _ "Kick", i0+2.00, 1, 120, 1
    _ "Kick", i0+3.75, 1, 120, 1

    _ "ClosedHat", i0+0.00, 1, 50, 1
    _ "ClosedHat", i0+0.50, 1, 20, .99
    _ "ClosedHat", i0+1.00, 1, 50, 1
    _ "ClosedHat", i0+1.25, 1, 50, 1

    if iMeasureCount % 4 == 0 then
      _ "OpenHat1", i0+2, 1.5, 50, .885
      _ "ClosedHat", i0+3, 1, 50, 1
    elseif iMeasureCount % 2 == 0 then
      _ "ClosedHat", i0+2, 1, 50, 1
      _ "ClosedHat", i0+2.25, 1, 50, 1
      _ "ClosedHat", i0+2.5, 1, 50, 1
      _ "ClosedHat", i0+3, 1, 50, 1
    else
      _ "ClosedHat", i0+2, 1, 50, 1
      _ "ClosedHat", i0+2.25, 1, 50, 1
      _ "ClosedHat", i0+2.5, 1, 50, 1
      _ "ClosedHat", i0+3.5, 1, 50, 1
    endif

    _ "Snare", i0+1, 1, 70, 1

    if iMeasureCount % 8 == 5 then
      _ "Snare", i0+3, 1, 70, 1
    elseif iMeasureCount % 4 != 3 then
      _ "Snare2", i0+2.3333, 1,70, 1
      _ "Snare2", i0+2.6666, 1,70, 1
    endif

    _ "Drums", i0, .25, 120, 3.0

    if iMeasureCount % 8 == 7 then
      _ "Drums", i0+.25, 1.75, 120, 3.0, .5
      _ "Drums", i0+2, 2, 120, 3.0, .5
    elseif iMeasureCount % 4 == 3 then
      _ "Drums", i0+.25, 1.75, 120, 3.0
      _ "Drums", i0+2, 2, 120, 3.0
    elseif iMeasureCount % 8 == 5 then
      _ "Drums", i0, .25, 120, 3.0
      _ "Drums", i0+.25, 1.75, 120, 3.0
      _ "Drums", i0+2, .25, 120, 3.0
      _ "Drums", i0+2.25, 1.75, 120, 3.0
    else
      _ "Drums", i0+.25, 3.75, 120, 3.0
    endif
  $END_PATTERN_LOOP
endin
