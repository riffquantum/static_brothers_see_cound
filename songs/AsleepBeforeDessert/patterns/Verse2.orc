instr Chorus
  _ "MainLoopC", 0, 4

  if p4 = 0 then
    _ "PastelLoop", 4, 24
  else
    _ "PastelLoop", 4, 24
    _ "AsleepBeforeDessert", 28, 4, 120, 4.00, .01
    _ "AsleepBeforeDessert", 28, 4, 120, 3.05, .1
  endif

  _ "BuzzingSprites", 24, 32
endin

instr Verse2
  _ "PastelLoop", 0, 8
  _ "AsleepBeforeDessert", 8, stb(p3) - 8, 56, 4.000000
  _ "AsleepBeforeDessert", 8.02, stb(p3) - 8, 67, 4.050000
  _ "AsleepBeforeDessert", 8.01, stb(p3) - 8, 65, 3.050000
  _ "AsleepBeforeDessert", 8.05, stb(p3) - 8, 73, 5.000000
  ; gkAsleepBeforeDessertTimeStretch linseg 1, bts(23.75), 1, .1, .5, bts(7.75), .5, .25, 1
endin

