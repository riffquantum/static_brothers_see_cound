instr Bridge
  $PATTERN_LOOP(3)
    if iMeasureCount == 4 then
      ; _ "Snare", i0, 1, 70, 1
      ; _ "Snare", i0+1, 1, 70, 1
      _ "Snare", i0+2, 1, 70, 1
      _ "Snare", i0+2.5, 1, 70, 1
      _ "Kick", i0+2.75, 1, 120, 1
    elseif iMeasureCount > 4 then
      _ "Kick", i0+0.00, 1, 120, 1
      _ "Kick", i0+0.25, 1, 120, 1
      _ "Kick", i0+2.00, 1, 120, 1


      if iMeasureCount > 2 && iMeasureCount % 2 == 0 then
        _ "Snare", i0+1.5, 1, 70, 1
        _ "Drums", i0, 3, 120, 3.0, .5
      else
        _ "Snare", i0+1, 1, 70, 1
        _ "Drums", i0, 3, 120, 3.0
      endif

      _ "ClosedHat", i0+0.00, 1, 50, 1
      _ "ClosedHat", i0+0.50, 1, 20, .99
      _ "ClosedHat", i0+1.00, 1, 50, 1
      _ "ClosedHat", i0+1.25, 1, 50, 1
      _ "ClosedHat", i0+2, 1, 50, 1
      _ "ClosedHat", i0+2.25, 1, 50, 1

      ; _ "Drums", i0+.25, 2.75, 120, 3.0, .5
    endif
  $END_PATTERN_LOOP
  $PATTERN_LOOP(6)
    _ "IcemanLoop2", i0, 6, 120, 2/3, 4

    if iMeasureCount % 2 == 0 then
      _ "IcemanLoop2", i0, 6, 120, 4/7, 4
    endif

    if iMeasureCount <= 3 then
      _ "IcemanLoop2", i0, 6, 120, 1/3, 4
    else
      _ "IcemanLoop2", i0, 6, 120, 1/3, 0
    endif
  $END_PATTERN_LOOP

  $PATTERN_LOOP(4)
    ; _ "Piano", i0, 4, 100, 1/3, 24.2
    ; _ "Kick", i0+0.00, 1, 120, 1
    ; _ "Kick", i0+0.25, 1, 120, 1
    ; _ "Kick", i0+2.00, 1, 120, 1
    ; _ "Kick", i0+3.75, 1, 120, 1

    ; _ "Snare", i0+1, 1, 70, 1
    ; _ "Snare", i0+3.25, 1, 70, 1

    ; _ "ClosedHat", i0+0.00, 1, 50, 1
    ; _ "ClosedHat", i0+0.50, 1, 20, .99
    ; _ "ClosedHat", i0+1.00, 1, 50, 1
    ; _ "ClosedHat", i0+1.25, 1, 50, 1

    ; _ "Drums", i0, .25, 120, 3.0
    ; _ "Drums", i0+.25, 1.75, 120, 3.0, .5
    ; _ "Drums", i0+2, 2, 120, 3.0, .5
  $END_PATTERN_LOOP
endin
