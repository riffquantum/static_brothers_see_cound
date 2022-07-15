instr WithersLoop1
  $PATTERN_LOOP(4)
    if i0 != iPatternLength - 4 then
      _ "WhoIsHeLoop", i0+0, 1, 110, 1, 11
      _ "WhoIsHeLoop", i0+1, 1, 110, 1, 11
      _ "WhoIsHeLoop", i0+2, 2, 110, 1, 11
    else
      _ "WhoIsHeLoop", i0+0, 4, 110, 1, 11
    endif
  $END_PATTERN_LOOP
endin
