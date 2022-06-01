instr Chorus
  gkFluteStretchPan = 50 + oscil(45, .1)
  ; _ "FluteStretch", 0, 16, 20, 5.0


  ; For the flute stretch to land perfectly over the painoInterrupt we need it to last for 72
  ;  beats and 24 of those beats should happen after the Chorus ends. So the formula is p2 =
  ;  secondsToBeats(p3) - 48 and p3 for the first one is iLastFluteStretchNoteP2 - 16
  iLastFluteStretchNoteP2 = secondsToBeats(p3) - 48
  iFirstFluteStretchNoteP3 = iLastFluteStretchNoteP2 - 16
  _ "FluteStretch", 16, iFirstFluteStretchNoteP3, 20, 5.0
  _ "FluteStretch", iLastFluteStretchNoteP2, 72, 20, 5.0

  _ "ChorusSegue", 0, 16
  _ "IcemanFlute", 24, 6, 60, 1/3, 8

  if secondsToBeats(p3) > 36 then
    _ "DrumCut", 36, 1.5
  endif

  if secondsToBeats(p3) > 76 then
    _ "DrumCut", 76, 1.5
  endif

  _ "Stab", 16, .5, 40, 2.08

  _ "ChorusLoop", 16, secondsToBeats(p3) - 16
  _ "ChorusFluteLoop", 32, secondsToBeats(p3) - 32
  _ "Snare", 19, 1, 40, 1
  _ "ChorusDrumLoop", 20, secondsToBeats(p3) - 20
endin

