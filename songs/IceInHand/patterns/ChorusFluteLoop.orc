instr ChorusFluteLoop
  ; gkStabFader *= 0.9

  $PATTERN_LOOP(8)
    iFluteNumerator = iMeasureIndex % 8 < 4 ? 1 : 2

    if iMeasureIndex % 4 < 2 then
      _ "IcemanFlute", i0, 4, 60, iFluteNumerator/3, 12
    elseif iMeasureIndex % 4 == 2 then
      _ "IcemanFlute", i0, .5, 60, iFluteNumerator/3, 15
      _ "IcemanFlute", i0+.5, 3.5, 60, iFluteNumerator/3, 15
    else
      _ "IcemanFlute", i0, 4, 60, iFluteNumerator/3, 11
    endif

    if iFluteNumerator == 2 then
      _ "IcemanFlute", i0+4, 4, 60, iFluteNumerator/3, 8
    endif
    _ "IcemanFlute", i0+4, 4, 60, 1/3, 8
    ; _ "IcemanFlute", i0+4, 4, 60, (iMeasureCount > 16 ? iFluteNumerator : 1)/3, 8
  $END_PATTERN_LOOP
endin
