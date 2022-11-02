; This needs Teeth Did Brightly SHine and Reynardine samples

instr WithersLoop2
  gkWhoIsHeLoopPan = 60

  $PATTERN_LOOP(4)
    _ "Distorted808Kick", i0+3.6666666, .333334, 120, .5
    _ "Distorted808Kick", i0+0, 1, 120, .5
    _ "Distorted808Kick", i0+1.66666, 1, 120, .5
    _ "Distorted808Kick", i0+2, 1, 120, .5
    _ "Snare", i0+1, 1, 60, .5
    _ "Snare", i0+3, 1, 60, .5

    ; _ "WhoIsHeLoop", i0+0, 4, 110, .5, 2.5
    ; _ "WhoIsHeLoop", i0+0, 8, 110, .25, 2.5

    if iMeasureCount % 2 == 1 then
      ; _ "WhoIsHeLoop", i0+0, 2, 110, 1, 6
      _ "ClosedHat", i0+1.5+0, 1, 1, 1
      _ "ClosedHat", i0+1.5+1/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+2/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+3/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+4/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+5/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+6/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+7/6.5, 1, 5, 1
      _ "ClosedHat", i0+1.5+8/6.5, 1, 5, 1

    endif

    if iMeasureCount % 4 == 3 then
      _ "WhoIsHeLoop", i0+0, 2, 110, 4/7, 3
    endif

    if iMeasureCount % 8 == 6 then
      _ "WhoIsHeLoop", i0+0, 2, 110, 3/7, 3
    endif

    if iMeasureCount % 8 == 0 then
      _ "WhoIsHeLoop", i0+0, 4, 110, .25, 3
      ; _ "WhoIsHeLoop", i0+0, 4, 110, .5, 3
    else
      _ "WhoIsHeLoop", i0+0, 4, 110, .25, 2.5
      _ "WhoIsHeLoop", i0+0, 4, 110, .5, 2.5
    endif

    ; _ "WhoIsHeLoop", i0+0, 2, 110, 5/9, 2.5
    ; _ "WhoIsHeLoop", i0+4, 4, 110, 4/7, 0
  $END_PATTERN_LOOP
endin
