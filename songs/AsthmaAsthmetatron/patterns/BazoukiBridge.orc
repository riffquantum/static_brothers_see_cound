instr BazoukiBridge
  $PATTERN_LOOP(8)
    ; _ "DrumLoop1", i0, 8
    ; _ "HandLoop", i0, 8

    if iMeasureCount == 1 then
    _ "DrumLoop7", i0, 8
    _ "Asma5", i0, 8, 120, 1, 0
    ; _ "Asma1", i0, 4, 80, 2/3, 0 ; Maybe
    elseif iMeasureCount == 3 then
      _ "DrumLoop5", i0, 8
      _ "Asma5", i0, 8, 120, 1, 4
    elseif iMeasureCount > 3 then
      _ "Asma5", i0, 4, 120, 1, 8
      _ "Asma5", i0+4, 4, 120, (iMeasureIndex%2==1 ? -1 : 1), 0
      if iMeasureCount == iPatternLengthInMeasures then
        _ "DrumLoop1", i0, 8
      else
        _ "DrumLoop5", i0, 8
      endif
    else
      _ "Asma5", i0, 4, 120, 1, 4
      _ "Asma5", i0+4, 4, 120, 1, 4
      _ "DrumLoop7", i0, 8

      ; _ "Asma1", i0+4, 2, 80, 4/3, 0, 0, 0, .25
      ; _ "Asma1", i0+7, 2, 80, 4/3, 4, 0, 0, .25
    endif
  $END_PATTERN_LOOP
endin
