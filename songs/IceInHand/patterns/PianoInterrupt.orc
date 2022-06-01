instr PianoBridgePhrase
  _ "Piano", 0, 1.45, 120, (.75) * .55, 26.9
  _ "IcemanLoop", 1.45, p4, 80, 1/3, 8
  _ "Stab", 1.45, .5, 40, 2.08
  _ "Stab", 1.45, .5, 40, 1.08
endin

instr PianoInterrupt
  ; gkDrumPostBusFader = 0
  ; gkIcemanLoopFader = 0
  ; gkStabFader = 0
  ; _ "Stab", 0, .5, 40, 2.08

  _ "IcemanFlute", 0, 28.9, 60, 1/3, 0, 8

  _ "PianoBridgePhrase", 8, 7.45, 6
  _ "PianoBridgePhrase", 15.45, 7.45, 11

  _ "Piano", 19.9, 8, 90, (.75) * .55, 27
  ; _ "Piano", 21.7, 3.1, 50, (.75) * .55, 27.9
  ; _ "Piano", 24.8, 3.1, 80, (.75) * .55, 27.9

  _ "Piano", 27.9, 8, 120, (.75) * .55, 24.2

  _ "ClosedHat", secondsToBeats(p3) - .5, 1, 40, .8
  _ "Snare", secondsToBeats(p3) - .5, 1, 40, .8
  _ "Kick", secondsToBeats(p3) - .5, 1, 80, .8
  _ "Kick", secondsToBeats(p3) - .25, 1, 80, .8
  ; _ "Stab", 1, .6, 40, 3.0775
  ; _ "Stab", 3, .6, 40, 3.0775
endin
