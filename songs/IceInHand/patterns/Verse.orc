

instr Verse
  iVerseVariation = p4

  if iVerseVariation == 0 then
    if secondsToBeats(p3) > 24 then
      _ "DrumCut", 24, 3
    endif
    if secondsToBeats(p3) > 56 then
      _ "DrumCut", 56, 4
    endif
    _ "TapeFlutter", 3, 1, 3
  endif


  ; if secondsToBeats(p3) > 40 then
  ;   _ "FilterSweep", 40, 8
  ; endif


  _ "VerseLoop", 0, secondsToBeats(p3)
  _ "DrumLoop1", 0, secondsToBeats(p3)

  ; Second time around ideas
  ;  add a shaker? maybe from the think break
endin
