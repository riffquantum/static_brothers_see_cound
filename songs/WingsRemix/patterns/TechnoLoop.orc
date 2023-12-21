instr TechnoLoop
  $PATTERN_LOOP(16)
    _ "Guitar1_B52", i0, 8, 40, 5/8, 16
    _ "Guitar2_B52", i0+4, 8, 40, 5/8, 16
    _ "Guitar1_B52", i0+8, 8, 40, 9/8, 16
    _ "Guitar2_B52", i0+4+8, 8, 40, 9/8, 16
  $END_PATTERN_LOOP

  $PATTERN_LOOP(4)
    ; _ "DrumLoop2Bundle", i0, 4, 50, 1.01, 12.0085
    ; _ "DrumLoop2Bundle", i0, 4, 50, .51, 16

    ; _ "VoxScratch", i0, 4
    if iMeasureCount % 2 == 1 then
      _ "Bass", i0, 4, 127, -1, 4
      _ "BassSubDi", i0, 8, 100, -1, 4
      _ "BassSub",   i0, 8, 100, -1, 4
    else
      _ "Bass", i0, 4, 127, -1, 6
      _ "BassSubDi", i0, 8, 100, -1, 6
      _ "BassSub",   i0, 8, 100, -1, 6
    endif

    _ "CloserKick", i0, 1, 100, 1

    if iMeasureCount % 4 == 2 then
      _ "CloserKick", i0+2, 1, 100, 1
      _ "CloserKick", i0+2+(1/6), 1, 60, 1
      _ "CloserKick", i0+2+(2/6), 1, 60, 1
      _ "CloserKick", i0+2+(3/6), 1, 100, 1
      _ "CloserKick", i0+2+(4/6), 1, 60, 1
      _ "CloserKick", i0+2+(5/6), 1, 60, 1
    elseif iMeasureCount % 4 == 2 then
      _ "CloserKick", i0+2.25, 1, 100, 1
      _ "CloserKick", i0+2.75, 1, 100, 1
    else
      _ "CloserKick", i0+2.5, 1, 100, 1
    endif

    _ "CloserKick", i0+3.5, 1, 100, 1
    _ "CloserSnare", i0+1, 1, 100, 1

    if iMeasureCount % 8 == 7 then
      _ "CloserSnare", i0+2.75, 1, 60, 1.3
      _ "CloserSnare", i0+3, 1, 60, 1.3
      _ "CloserSnare", i0+3.25, 1, 60, 1.3
      _ "CloserSnare", i0+3.75, 1, 100, 1
      _ "CloserSnare", i0+3.75+(1/8), 1, 60, 1.3
    else
      _ "CloserSnare", i0+3, 1, 100, 1
    endif

    _ "FalseHat", i0+0.0, 1, 100, 1.05
    _ "FalseHat", i0+0.25, 1, 90, 1
    _ "FalseHat", i0+0.5, 1, 90, .99
    _ "FalseHat", i0+1.0, 1, 100, 1.05
    _ "FalseHat", i0+1.25, 1, 90, 1
    _ "FalseHat", i0+1.5, 1, 90, .99
    _ "FalseHat", i0+2.0, 1, 100, 1.05
    _ "FalseHat", i0+2.25, 1, 90, 1
    _ "FalseHat", i0+2.5, 1, 90, .99
    _ "FalseHat", i0+3.0, 1, 100, 1.05
    _ "FalseHat", i0+3.25, 1, 90, 1
    _ "FalseHat", i0+3.5, 1, 90, .99

    _ "FalseHat", i0+0.75, 1, 60, 2
    _ "FalseHat", i0+1.75, 1, 60, 2
    _ "FalseHat", i0+2.75, 1, 60, 2
    _ "FalseHat", i0+3.75, 1, 60, 2

    _ "FalseHat", i0+0.5, 1, 60, .25
    _ "FalseHat", i0+1.5, 1, 60, .25
    _ "FalseHat", i0+2.5, 1, 60, .25
    _ "FalseHat", i0+3.5, 1, 60, .25
  $END_PATTERN_LOOP
endin
