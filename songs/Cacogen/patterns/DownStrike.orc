instr DownStrike
      $PATTERN_LOOP(2)
        ; if iMeasureIndex % 2 == 0 then
        ;   _ "Crash", i0, 1, 80, .5
        ;   _ "Crash2", i0+.5, 1, 80, .5
        ; endif
        ; _ "Hand", i0, 5, 120, .5, 0.05
        ; _ "Hand2", i0, 2, 100, 1, 4.0
        ; if iMeasureIndex%2==0 then
        ; _ "Hand", i0, 2, 120, .5, 4
        ; else
        ; _ "Hand", i0, 2, 120, .5, 6
        ; endif

        ; _ "Hand2", i0, 1, 100, 1, 1.0
        ; _ "Hand2", i0+.5, .5, 100, 1, 5.0
        ; ; _ "Hand2", i0, 2, 100, .5, 1.0
        ; _ "Hand2", i0+.25, 1/4, 100, 1, 4.0
        ; _ "Hand2", i0+.25, 1/4, 100, .5, 4.0
        ; ; _ "Hand2", i0+1, .5, 100, 1, 1.0
        ; _ "Hand2", i0+1.5, .5, 100, 1, 5.0
        ; _ "Hand2", i0+2, .5, 100, .5, 5.0
      $END_PATTERN_LOOP
      $PATTERN_LOOP(2)

        _ "Hand2", i0, 1/4, 100, 1, 1.0
        _ "Hand2", i0, 1/4, 100, .5, 1.0
        _ "Hand2", i0+1/8+1/64, 3/8, 100, 1, 4.0
        _ "Hand2", i0+1/8+1/64, 3/8, 100, .5, 4.0
        _ "Hand2", i0+2/8, 3/8, 100, 1, 4.0
        _ "Hand2", i0+2/8, 3/8, 100, .5, 4.0
        _ "Hand2", i0+3/8+1/64, 1/8, 100, 1, 4.0
        _ "Hand2", i0+3/8+1/64, 1/8, 100, .5, 4.0

        _ "Hand2", i0+1, 1, 100, 1, 1.0
        _ "Hand2", i0+1, 1, 100, .5, 1.0

        ; _ "Hand2", i0, .5, 100, 1, 0.0
        ; _ "Hand2", i0, .5, 100, .5, 0.0
        ; ; _ "Hand2", i0+.25, 1/4, 100, 1, 4.0
        ; ; _ "Hand2", i0+.25, 1/4, 100, .5, 4.0
        ; _ "Hand2", i0+.5, .5, 100, 1, 6.0
        ; _ "Hand2", i0+.5, .5, 100, .5, 6.0
        ; _ "Hand2", i0+.75, 1/4, 100, 1, 4.0
        ; _ "Hand2", i0+.75, 1/4, 100, .5, 4.0

        ; _ "Hand2", i0+1, 1/8, 100, 1, 4.0
        ; _ "Hand2", i0+9/8, 3/8, 100, 1, 4.0

        ; _ "Hand2", i0+2, 1, 100, 1, 5.5
        ; if iMeasureCount % 4 == 0 then
        ;   _ "Hand2", i0+2, 1, 100, 1, 5.25
        ; endif
        ; _ "Hand2", i0+2, .333, 120, .5, 2.0
        ; _ "Hand2", i0+2, .333, 120, 1, 2.0

        ; _ "Hand2", i0+3, .333, 120, .5, 2.0
        ; _ "Hand2", i0+3, .333, 120, 1, 2.0

        _ "CloserKicks", i0+0/8, 1, 120, 1.1
        _ "CloserKicks", i0+1/8, 1, 70, 1
        _ "CloserKicks", i0+2/8, 1, 70, 1
        _ "CloserKicks", i0+3/8, 1, 70, 1
        _ "CloserKicks", i0+4/8, 1, 120, 1.1
        _ "CloserKicks", i0+5/8, 1, 70, 1
        _ "CloserKicks", i0+6/8, 1, 70, 1
        _ "CloserKicks", i0+7/8, 1, 70, 1

        ; _ "CloserKicks", i0+1+0/8, 1, 120, 1.1
        ; _ "CloserKicks", i0+1+1/8, 1, 70, 1
        ; _ "CloserKicks", i0+1+2/8, 1, 70, 1
        ; _ "CloserKicks", i0+1+3/8, 1, 70, 1
        ; _ "CloserKicks", i0+1+4/8, 1, 120, 1.1
        ; _ "CloserKicks", i0+1+5/8, 1, 70, 1
        _ "CloserKicks", i0+1+6/8, 1, 70, 1
        _ "CloserKicks", i0+1+7/8, 1, 70, 1
        ; _ "CloserKicks", i0+4/6, 1, 100, 1
        ; if iMeasureCount % 2 == 0 then
        ; _ "CloserKicks", i0+1/6, 1, 100, 1
        ; _ "CloserKicks", i0+2/6, 1, 100, 1
        ; _ "CloserKicks", i0+3/6, 1, 100, 1

        ; _ "CloserKicks", i0+9/8, 1, 100, 1
        ; _ "CloserKicks", i0+11/8, 1, 100, 1
        ; endif
        ; _ "CloserKicks", i0+.75, 1, 100, 1
        ; _ "CloserKicks", i0+1, 1, 100, 1
        ; _ "CloserKicks", i0+10/8, 1, 100, 1
        ; _ "CloserKicks", i0+1.75, 1, 100, 1

        ; _ "FalseHat", i0, .1, 80, 1
        ; _ "FalseHat", i0+.5, .1, 100, 1.1
        ; _ "FalseHat", i0+1, .1, 80, 1
        ; _ "FalseHat", i0+1.5, .1, 100, 1.1
        ; _ "FalseHat", i0+2, .1, 80, 1
        ; _ "FalseHat", i0+2.5, .1, 100, 1.1
      $END_PATTERN_LOOP
    endin
