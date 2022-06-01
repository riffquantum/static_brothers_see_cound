instr ChorusSegue
  gkIcemanLoop2Fader = linseg(0, beatsToSeconds(4), 0, p3-beatsToSeconds(4), 1)

  _ "IcemanLoop", 0, secondsToBeats(p3), 80, 1/3, 8
  _ "Stab", 0, .5, 40, 2.08

  _ "Stab", 0+3.5, .5, 40, 1.08
  _ "IcemanLoop", 0+3.5, secondsToBeats(p3) - 3.5, 80, 1/3, 8

  _ "IcemanLoop2", 0+3.5, secondsToBeats(p3) - 3.5, 80, 1/3, 6


  ; _ "IcemanFlute", 8, secondsToBeats(p3) + 8, 60, 1/3, 0, 8
  _ "IcemanFlute", 8, secondsToBeats(p3), 60, 1/3, 0, 8
  ; _ "IcemanFlute", 8, secondsToBeats(p3) - 8, 60, 1/3, 0, 8

  $PATTERN_LOOP(4)
    _ "IcemanLoop2", i0, 4, 60, 7/6, 6
  $END_PATTERN_LOOP
endin
