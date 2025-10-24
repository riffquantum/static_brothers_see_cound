instr CacogenMarch
  $PATTERN_LOOP(4)
    if iMeasureCount % 4 == 0 then
      _ "Crash", i0, 1, 80, .5
      _ "Crash2", i0, 1, 80, .5
    endif
    _ "Hand", i0, 4, 120, .5, 0.05
    _ "Hand2", i0, 2, 100, .5, 4.0
    _ "Hand2", i0, 2, 100, 1, 4.0

    _ "Hand2", i0+2, .333, 120, .5, 2.0
    _ "Hand2", i0+2, .333, 120, 1, 2.0

    _ "Hand2", i0+3, .333, 120, .5, 2.0
    _ "Hand2", i0+3, .333, 120, 1, 2.0

    _ "CloserKick", i0+2, 1, 70, 1.25
    _ "CloserKick", i0+2, 1, 60, .8
    _ "CloserKick", i0+3, 1, 70, 1.25
    _ "CloserKick", i0+3, 1, 60, .8

    _ "CloserKick", i0, 1, 70, 1.25
    _ "CloserKick", i0, 1, 60, .8

    _ "FalseHat", i0, .1, 80, 1
    _ "FalseHat", i0+.5, .1, 100, 1.1
    _ "FalseHat", i0+1, .1, 80, 1
    _ "FalseHat", i0+1.5, .1, 100, 1.1
    _ "FalseHat", i0+2, .1, 80, 1
    _ "FalseHat", i0+2.5, .1, 100, 1.1
    _ "FalseHat", i0+3, .1, 80, 1
    _ "FalseHat", i0+3.5, .1, 100, 1.1
    ; _ "Hand", i0, 1.4, 60, 1, 0 ;1.025
    ; ; _ "Hand", i0+1.5, .5, 60, -1, 7
    ; _ "Hand", i0+2, 1.5, 60, 1, 4
    ; _ "Hand", i0+3.5, .5, 60, -1, 4
    ; _ "Asma1", i0, 4, 120, 1, 0
  $END_PATTERN_LOOP
  ; TO TO EMULATE THE INTRO EYELESS WITH THESE SETTINGS
  $PATTERN_LOOP(8)
  $END_PATTERN_LOOP
endin
