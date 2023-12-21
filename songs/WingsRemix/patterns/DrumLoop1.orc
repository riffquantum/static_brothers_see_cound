instr DrumLoop1
  _ "SnareDelay", 0, stb(p3)

  $PATTERN_LOOP(8)
    _ "DL1_CHINA", i0, 8, 100, 1, 0
    _ "DL1_HH", i0, 8, 100, 1, 0
    _ "DL1_KICK", i0, 8, 100, 1, 0
    _ "DL1_RIDE", i0, 8, 100, 1, 0
    ; ; _ "DL1_OH", i0, 8, 100, 1, 0
    ; ; _ "DL1_ROOMS", i0, 8, 100, 1, 0
    _ "DL1_SNAREBOTTOM", i0, 8, 100, 1, 0
    _ "DL1_SNARETOP", i0, 8, 100, 1, 0
    ; _ "DL1_TOM1", i0, 8, 100, 1, 0
    ; _ "DL1_TOM2", i0, 8, 100, 1, 0
  $END_PATTERN_LOOP
endin
