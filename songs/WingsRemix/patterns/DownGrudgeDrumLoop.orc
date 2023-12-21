instr DownGrudgeDrumLoop
  $PATTERN_LOOP(4)
    ; _ "VoxScratch", i0, 4
    _ "CloserKick", i0, 1, 100, 1
    _ "CloserKick", i0+2, 1, 100, 1
    _ "CloserKick", i0+3.5, 1, 100, 1
    _ "CloserKick", i0+4, 1, 100, 1

    if iMeasureCount % 4 == 3 then
      _ "FalseHat", i0+0.125, 1, 100, 1.09
      _ "FalseHat", i0+0.25, 1, 100, .99
      _ "FalseHat", i0+0.75, 1, 100, .95
    endif

    _ "FalseHat", i0+0.5, 1, 100, .99
    _ "FalseHat", i0+1.5, 1, 100, 1
    _ "FalseHat", i0+1.75, 1, 100, 5/3
    _ "FalseHat", i0+2.5, 1, 100, 1
    _ "FalseHat", i0+3.5, 1, 100, 1
    _ "FalseHat", i0+3.75, 1, 100, 5/3

    _ "KickHelix2", i0, 4, 20, 7.04, (iMeasureCount % 4) + 3, 4
    _ "KickHelix", i0, 4, 40, 5.04, (iMeasureCount % 4) + 1
  $END_PATTERN_LOOP

  $PATTERN_LOOP(8)
    if iMeasureIndex == 0  then
      _ "CloserSnare", i0, 1, 100, .25
      ; _ "CloserSnare", i0, 1, 100, 1
      _ "CloserSnare", i0+7, 1, 100, 1
    elseif iMeasureIndex == 1 then
      _ "CloserSnare", i0+3, 1, 100, .25
      _ "CloserSnare", i0+7, 1, 100, .5
    else
      _ "CloserSnare", i0+2, 1, 100, .25
      _ "CloserSnare", i0+6, 1, 70, 2
    endif

    if iMeasureCount * iBeatsPerMeasure >= iPatternLength then
      _ "CloserSnare", i0+7, 1, 100, 1
      ; _ "CloserSnare", i0+7.5, 1, 100, 1.2
      ; _ "CloserSnare", i0+8, 1, 100, 1.3
      ; _ "CloserSnare", i0+8.5, 1, 100, 1.4
    endif

    _ "CloserSnare", i0+7, 1, 100, 1
  $END_PATTERN_LOOP

  $PATTERN_LOOP(8)
    if iMeasureCount % 2 != 0 then
      _ "DL2_CHINA", i0, 8, 100, 0.51, 16
      _ "DL2_HH", i0, 8, 100, 0.51, 16
      _ "DL2_KICK", i0, 8, 100, 0.51, 16
      _ "DL2_RIDE", i0, 8, 100, 0.51, 16
      _ "DL2_SNAREBOTTOM", i0, 8, 100, 0.51, 16
      _ "DL2_SNARETOP", i0, 8, 100, 0.51, 16
    else
      _ "DL2_CHINA", i0, 2, 100, 0.51, 16
      _ "DL2_HH", i0, 2, 100, 0.51, 16
      _ "DL2_KICK", i0, 2, 100, 0.51, 16
      _ "DL2_RIDE", i0, 2, 100, 0.51, 16
      _ "DL2_SNAREBOTTOM", i0, 2, 100, 0.51, 16
      _ "DL2_SNARETOP", i0, 2, 100, 0.51, 16

      _ "DL2G_CHINA", i0, 8, 120, 4.0, 1.3, 1/iMeasureIndex, 1/iMeasureIndex, 1/iMeasureIndex
      _ "DL2G_HH", i0, 8, 120, 4.0, 1.1, 1/iMeasureIndex, 1/iMeasureIndex, 1/iMeasureIndex
      _ "DL2G_KICK", i0, 8, 120, 4.0, 1.6, 1/iMeasureIndex, 1/iMeasureIndex, 1/iMeasureIndex
      _ "DL2G_RIDE", i0, 8, 120, 4.0, 1.8, 1/iMeasureIndex, 1/iMeasureIndex, 1/iMeasureIndex
      _ "DL2G_SNAREBOTTOM", i0, 8, 120, 4.0, 1.4, 1/iMeasureIndex, 1/iMeasureIndex, 1/iMeasureIndex
      _ "DL2G_SNARETOP", i0, 8, 120, 4.0, 1.2, 1/iMeasureIndex, 1/iMeasureIndex, 1/iMeasureIndex
    endif

    ; _ "DL2_CHINA", i0, 8, 100, 0.51, 16
    ; _ "DL2_HH", i0, 8, 100, 0.51, 16
    ; _ "DL2_KICK", i0, 8, 100, 0.51, 16
    ; _ "DL2_RIDE", i0, 8, 100, 0.51, 16
    ; _ "DL2_SNAREBOTTOM", i0, 8, 100, 0.51, 16
    ; _ "DL2_SNARETOP", i0, 8, 100, 0.51, 16
    ; ; else
    ; ; _ "DL2_CHINA", i0, 2, 100, 0.51, 16
    ; ; _ "DL2_HH", i0, 2, 100, 0.51, 16
    ; ; _ "DL2_KICK", i0, 2, 100, 0.51, 16
    ; ; _ "DL2_RIDE", i0, 2, 100, 0.51, 16
    ; ; _ "DL2_SNAREBOTTOM", i0, 2, 100, 0.51, 16
    ; ; _ "DL2_SNARETOP", i0, 2, 100, 0.51, 16

    ; _ "DL2G_CHINA", i0, 8, 120, 4.0, 1.3
    ; _ "DL2G_HH", i0, 8, 120, 4.0, 1.1
    ; _ "DL2G_KICK", i0, 8, 120, 4.0, 1.6
    ; _ "DL2G_RIDE", i0, 8, 120, 4.0, 1.8
    ; _ "DL2G_SNAREBOTTOM", i0, 8, 120, 4.0, 1.4
    ; _ "DL2G_SNARETOP", i0, 8, 120, 4.0, 1.2
  $END_PATTERN_LOOP
endin
