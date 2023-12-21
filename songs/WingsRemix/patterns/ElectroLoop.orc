instr ElectroLoop
  ; gkBPM init 95
  ; _ "CloserVerb", 0, stb(p3), 1
  ; _ "BassDelay", 0, stb(p3)
  ; $PATTERN_LOOP(16)
  ;   if iMeasureCount % 2 == 1 then
  ;     _ "VoxScratch", i0+8, 28
  ;   else
  ;     _ "Vox3Scratch", i0+8, 16
  ;   endif
  ; $END_PATTERN_LOOP

  $PATTERN_LOOP(4)
    if iMeasureCount % 2 == 0 then
      _ "KickHelix2", i0, 4, 50, 7.04, (iMeasureCount % 4) + 3, 4
      _ "Bass", i0, 1, 127, -1, 1
    else
      _ "Bass", i0, 1, 127, -1, 5
      _ "KickHelix", i0, 4, 50, 5.04, (iMeasureCount % 4) + 1
    endif

    if iMeasureCount % 3 == 0 then
      _ "CloserSnare", i0+2, 1, 100, .25
    endif

    if iMeasureCount % 4 == 0 then
      _ "Bass", i0+1.5, 3, 127, 1, 5
    else
      _ "Bass", i0+1.5, 3, 127, 1, 1
    endif
    ; _ "BassSubDi", i0+1.5, 3, 200, 1, 1
    ; _ "BassSub", i0+1.5, 3, 200, 1, 1

    _ "CloserKick", i0, 1, 100, 1
    _ "CloserKick", i0+2.5, 1, 100, 1

    if iMeasureIndex % 8 == 3 then
      _ "CloserKick", i0+.75, 1, 100, .75
      _ "CloserKick", i0+1.5, 1, 100, .75
    elseif iMeasureIndex % 4 == 2 then
      _ "CloserKick", i0+1.525, 1, 100, .75
      _ "CloserKick", i0+2.2525, 1, 100, .75
    elseif iMeasureIndex % 8 == 6 || iMeasureIndex % 8 == 7 then
      _ "CloserKick", i0+1+(1/4), 1, 100, 1
    elseif iMeasureIndex % 2 == 1 || iMeasureIndex == 0 then
      _ "CloserKick", i0+1.525, 1, 100, 1
      _ "CloserKick", i0+1.45+(1/6), 1, 100, 1
      _ "CloserKick", i0+1.5+(2/6), 1, 100, 1
      _ "CloserKick", i0+2, 1, 100, 1
    else
      _ "CloserKick", i0+1.525, 1, 100, 1
    endif

    _ "CloserSnare", i0+1, 1, 100, 2-0.15
    _ "CloserSnare", i0+3, 1, 100, 2-0.15

    if iMeasureIndex != 12 && iMeasureIndex != 14 then
      _ "FalseHat", i0+0.5, 1, 100, .99
      _ "FalseHat", i0+1.5, 1, 100, 1
      _ "FalseHat", i0+1.75, 1, 100, 5/3
      _ "FalseHat", i0+2.5, 1, 100, 1
      _ "FalseHat", i0+3.5, 1, 100, 1
      _ "FalseHat", i0+3.75, 1, 100, 5/3
    endif

    if (iMeasureIndex > 5 && iMeasureIndex < 8) || iMeasureIndex == 12 then
      _ "FalseHat", i0+0.0, 1, 100, 1.7
      _ "FalseHat", i0+0.25, 1, 100, 1.7
      _ "FalseHat", i0+0.75, 1, 100, 1.7
      _ "FalseHat", i0+1.0, 1, 100, 1.7
      _ "FalseHat", i0+1.25, 1, 100, 1.7
      _ "FalseHat", i0+1.75, 1, 100, 1.7
      _ "FalseHat", i0+2.0, 1, 100, 1.7
      _ "FalseHat", i0+2.25, 1, 100, 1.7
      _ "FalseHat", i0+2.75, 1, 100, 1.7
      _ "FalseHat", i0+3.0, 1, 100, 1.7
      _ "FalseHat", i0+3.25, 1, 100, 1.7
      _ "FalseHat", i0+3.75, 1, 100, 1.7
    endif

    if iMeasureIndex == 12 || iMeasureIndex == 14 then
      _ "FalseHat", i0+0.0, 1, 100, 1
      _ "FalseHat", i0+0.25, 1, 100, 1
      _ "FalseHat", i0+0.75, 1, 100, 1
      _ "FalseHat", i0+1.0, 1, 100, 1
      _ "FalseHat", i0+1.25, 1, 100, 1
      _ "FalseHat", i0+1.75, 1, 100, 1
      _ "FalseHat", i0+2.0, 1, 100, 1
      _ "FalseHat", i0+2.25, 1, 100, 1
      _ "FalseHat", i0+2.75, 1, 100, 1
      _ "FalseHat", i0+3.0, 1, 100, 1
      _ "FalseHat", i0+3.25, 1, 100, 1
      _ "FalseHat", i0+3.75, 1, 100, 1
    endif
  $END_PATTERN_LOOP
endin
