instr WithersLoop1
  $PATTERN_LOOP(4)
    ; These drums are just a mockup. We should be playing them on the kit in a busy,
    ; dramatic and flashy fashion
    _ "DefaultCrash", i0, 1, 50, 1
    _ "DefaultSnare", i0+1, 1, 50, 1

    _ "DefaultTomMid", i0+1.75, 1, 50, 1
    _ "DefaultTomLow", i0+1.875, 1, 50, 1
    _ "DefaultTomMid", i0+2, 1, 50, 1

    _ "Distorted808Kick", i0+2.5, .333334, 120, .5
    _ "Distorted808Kick", i0+3.5, .333334, 120, .5

    if i0 != iPatternLength - 4 then
      _ "WhoIsHeLoop", i0+0, 1, 110, 1, 11
      _ "WhoIsHeLoop", i0+1, 1, 110, 1, 11
      _ "WhoIsHeLoop", i0+2, 2, 110, 1, 11

      if iMeasureCount % 5 == 0 then
        _ "WhoIsHeLoop", i0+0, 4, 110, .5, 11
      else
        _ "WhoIsHeLoop", i0+0, 1, 110, .5, 11
        _ "WhoIsHeLoop", i0+1, 1, 110, .5, 11
        _ "WhoIsHeLoop", i0+2, 2, 110, .5, 11
      endif
    else
      _ "WhoIsHeLoop", i0+0, 4, 110, 1, 11
      _ "WhoIsHeLoop", i0+0, 4, 110, .5, 11
    endif
  $END_PATTERN_LOOP
endin
