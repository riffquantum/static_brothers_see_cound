instr DarkoVerse1
  _ "DarkoVoxVerse1", stb(14.561), 60, 127, 1

  _ "Intro", 0, 32
  _ "Verse", 32, 32
  _ "BridgeToC", 64, 16
endin

instr DarkoChorus
  _ "DarkoVoxChorus", 0, 60, 127, 1
  _ "Chorus", 0, 28, p4
endin

instr DarkoVerse2
  _ "DarkoVoxVerse2", 2, 60, 127, 1
  _ "Verse2", 0, stb(p3)
endin

instr DonBridge
  _ "AsleepBeforeDessert", 0, 2, 56, 4.000000
  _ "AsleepBeforeDessert", 0.02, 2, 67, 4.050000
  _ "AsleepBeforeDessert", 0.01, 2, 65, 3.050000
  _ "AsleepBeforeDessert", 0.05, 2, 73, 5.000000

  ; _ "AsleepBeforeDessert", 0, 2, 120, 4.05, 1
  ; _ "AsleepBeforeDessert", 0, 2, 120, 3.00, 1

  _ "AsleepBeforeDessert", 2, 2, 120, 4.04, 1
  _ "AsleepBeforeDessert", 2, 2, 120, 3.00, 1

  _ "AsleepBeforeDessert", 4, 4, 120, 4.05, .5
  _ "AsleepBeforeDessert", 4, 4, 120, 3.00, .5

  _ "AsleepBeforeDessert", 8, 4, 120, 4.05, .05
  _ "AsleepBeforeDessert", 8, 4, 120, 4.00, .25
  _ "AsleepBeforeDessert", 12, 4, 120, 3.05, .5
  _ "AsleepBeforeDessert", 12, 4, 120, 4.00, .5
endin

instr DonBridge2

  _ "AsleepBeforeDessert", 0, 4, 120, 4.00, .5
  _ "AsleepBeforeDessert", 0, 4, 120, 3.05, .5

  _ "AsleepBeforeDessert", 4, 4, 120, 4.05, .05
  _ "AsleepBeforeDessert", 4, 4, 120, 4.00, .25

  _ "AsleepBeforeDessert", 8, 4, 120, 4.00, 1
  _ "AsleepBeforeDessert", 8, 4, 120, 3.05, 1

  _ "AsleepBeforeDessert", 12, 4, 120, 3.05, .5
  _ "AsleepBeforeDessert", 12, 4, 120, 4.00, .5
endin


instr DonVerse
  _ "iAliveVox", stb(0.212), stb(39), 127, 1

  ; gkAsleepBeforeDessertTimeStretch linseg 1, bts(16), 1, bts(.001), .5, bts(8), .75, bts(.01), 1

  _ "AsleepBeforeDessert", 0, 4, 120, 4.05, .5, 10
  _ "AsleepBeforeDessert", 0, 4, 120, 4.00, .5, 10
  _ "AsleepBeforeDessert", 4, 4, 120, 3.05, .5, 10
  _ "AsleepBeforeDessert", 4, 4, 120, 4.00, .5, 10

  _ "PastelLoop", 8, 8

  _ "AsleepBeforeDessert", 16, 4, 120, 4.05, .5
  _ "AsleepBeforeDessert", 16, 4, 120, 4.00, .5
  ; _ "AsleepBeforeDessert", 20, 4, 120, 3.05, .5
  ; _ "AsleepBeforeDessert", 20, 4, 120, 4.00, .5

  _ "PastelLoop", 20, 8


  ; _ "AsleepBeforeDessert", 16, 8, 120, 4.00, 2, .3, 16
  _ "BridgeToC", 28, 16
  _ "MainLoopC", 44, 4
  _ "PastelLoop", 48, 8

  ; _ "Chorus", 72, 32
endin

instr DonVerse2
  _ "iAliveVox", 0, 48, 127, 1, 39.0925
  _ "PastelLoop", 0, 24
  ; _ "DessertDrop", 15.125, stb(1.711)
  _ "BuzzingSprites", 12, 32
endin

instr DessertDrop
  iVolume = i(gkAsleepBeforeDessertFader)
  gkAsleepBeforeDessertFader linseg iVolume, 0.01, 0, p3-0.11, 0, .1, iVolume
endin
