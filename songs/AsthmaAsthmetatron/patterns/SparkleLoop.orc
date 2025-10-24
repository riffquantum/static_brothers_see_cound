instr SparkleLoop
  $PATTERN_LOOP(4)
    _ "Kiss", i0, 3.9, 100, 1, 0

    _ "Kick", i0, 1, 100, .8
    _ "Kick", i0+.5, 1, 100, .8

    _ "Kick", i0+1.75, 1, 100, .8
    ; _ "Kick", i0+1.75+1/8, 1, 100, .8
    _ "Kick", i0+2.75, 1, 100, .8
  $END_PATTERN_LOOP


  $PATTERN_LOOP(8)
    if iMeasureCount % 4 == 0 then
      ; _ "Asma8", i0, 16, 100, 1, 12, 0, 0, 6
      _ "Asma8", i0, 8, 100, 1, 12, 0, 0, 5
      _ "Asma8", i0, 2, 100, 4/3, 0, 0, 0, .25
      _ "Asma8", i0+4, 2, 100, 2/3, 4, 0, 0, 0
    else
      _ "Asma8", i0, 8, 100, 1, 0
      _ "Asma8", i0, 2.25, 100, 2/3, 0, 0, 0, 1
      _ "Asma8", i0+4, 2.25, 100, 2/3, 4, 0, 0, 1
    endif
  $END_PATTERN_LOOP
endin
