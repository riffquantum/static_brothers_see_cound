instr ChorusLoop
  gkStabFader *= 0.9

  $PATTERN_LOOP(4)
    if iMeasureCount > 1 then
      _ "Stab", i0+1, .6, 40, 3.0775
    endif

    _ "Stab", i0+3, .6, 40, 3.0775

      ; _ "IcemanFlute", i0, 4, 60, .25, 0

    if iMeasureCount % 2 == 0 then
      ; _ "IcemanLoop2", i0, 5, 60, 2/3, 6
    endif

    _ "IcemanLoop2", i0, 4, 60, 7/6, 6



    if iMeasureCount > 2 then


      if iMeasureCount < 5 then
        ; _ "IcemanLoop2", i0, 4, 60, 7/6, 0
        ; _ "IcemanFlute", i0, 4, 60, 2/3, 0, 5
      else
      endif
    endif
  $END_PATTERN_LOOP
endin
