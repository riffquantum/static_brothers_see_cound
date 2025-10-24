instr SplashBeat
  kStart = 1
  kTime = times()
  kTrigger = trigger(kTime, kStart, 1) - 1
  printk2(kTrigger)

    $PATTERN_LOOP(4)
      _ "Hand", i0, 4, 120, .5, 7
      _ "Hand2", i0, 1, 100, 1, 6.0
      _ "Hand2", i0+1, 1, 100, 1, 1.01

      _ "Hand2", i0+2, 1, 100, 1, 6.0
      _ "Hand2", i0+3, 1, 100, 1, 7.0

      _ "CloserKick", i0, 1, 70, 1.25
      _ "CloserKick", i0, 1, 60, .8

      _ "CloserKick", i0+3, 1, 70, 1.25
      _ "CloserKick", i0+3, 1, 60, .8

      _ "FalseHat", i0, .1, 100, 1.1
      _ "FalseHat", i0+1/4, .1, 80, 1
      _ "FalseHat", i0+1, .1, 100, 1.1
      _ "FalseHat", i0+2, .1, 100, 1.1
      _ "FalseHat", i0+2+1/4, .1, 80, 1

      _ "FalseHat", i0+3.0, .1, 80, 1
      _ "FalseHat", i0+3.5, .1, 80, 1
    $END_PATTERN_LOOP

    $PATTERN_LOOP(8)
    $END_PATTERN_LOOP
endin
